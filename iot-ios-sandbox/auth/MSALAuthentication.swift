//
//  MSALAuthentication.swift
//  iot-ios-sandbox
//
//  Created by ITLABS WEG on 09/05/19.
//  Copyright © 2019 WEG. All rights reserved.
//

import MSAL

// MARK: Setup and initialization
public class MSALAuthentication {

    static let shared = MSALAuthentication()

    var currentAccountIdentifier: String? {
        get {
            return UserDefaults.standard.string(forKey: Constants.ACCOUNT_ID)
        }
        set (accountIdentifier) {
            UserDefaults.standard.set(accountIdentifier, forKey: Constants.ACCOUNT_ID)
        }
    }

    var currentTokenId: String? {
        get {
            return UserDefaults.standard.string(forKey: Constants.ID_TOKEN_KEY)
        }
        set (tokenValue) {
            UserDefaults.standard.set(tokenValue, forKey: Constants.ID_TOKEN_KEY)
        }
    }

    func setup() {
        MSALGlobalConfig.loggerConfig.setLogCallback { (_: MSALLogLevel, message: String?, containsPII: Bool) in
            if let displayableMessage = message {
                if !containsPII {
                    print(displayableMessage)
                }
            }
        }
    }

    func createClientApplication() throws -> MSALPublicClientApplication {

        let urlStringAuthority = String(format: Constants.ENDPOINT, arguments: [Constants.TENANT, Constants.POLICY])

        let urlAuthority = URL(string: urlStringAuthority)!

        let authority = try MSALB2CAuthority(url: urlAuthority)

        let config = MSALPublicClientApplicationConfig(clientId: Constants.CLIENT_ID, redirectUri: nil, authority: authority)

        do {
            return try MSALPublicClientApplication(configuration: config)
        } catch let error as NSError {
            throw AppErrors.PublicClientApplicationCreation(error)
        }
    }

    @discardableResult func currentAccount() throws -> MSALAccount {

        guard let accountIdentifier = currentAccountIdentifier else {
            throw AppErrors.NoUserSignedIn
        }

        let clientApplication = try createClientApplication()

        var acc: MSALAccount?
        do {
            acc = try clientApplication.account(forHomeAccountId: accountIdentifier)
        } catch let error as NSError {
            throw AppErrors.UserNotFound(error)
        }

        guard let account = acc else {
            clearCurrentAccount()
            throw AppErrors.NoUserSignedIn
        }
        return account
    }

    func signInAccount(completion: @escaping (MSALAccount?, _ acessToken: String?, Error?) -> Void) {
        do {
            let clientApplication = try createClientApplication()

            let parameters = MSALInteractiveTokenParameters(scopes: Constants.SCOPES)

            clientApplication.acquireToken(with: parameters) { (result: MSALResult?, error: Error?) in

                guard let acquireTokenResult = result, error == nil else {
                    completion(nil, nil, error)
                    return
                }

                let signedInAccount = acquireTokenResult.account
                self.currentAccountIdentifier = signedInAccount.homeAccountId?.identifier
                self.currentTokenId = acquireTokenResult.idToken

                completion(signedInAccount, acquireTokenResult.accessToken, nil)
            }
        } catch let createApplicationError {
            completion(nil, nil, createApplicationError)
        }
    }

    func acquireTokenSilentForCurrentAccount(forScopes scopes: [String], completion: @escaping (_ acessToken: String?, Error?) -> Void) {
        do {
            let application = try createClientApplication()
            let account = try currentAccount()

            let parameters = MSALSilentTokenParameters(scopes: scopes, account: account)
            application.acquireTokenSilent(with: parameters) { (result: MSALResult?, error: Error?) in
                guard let acquireTokenResult = result, error == nil else {
                    completion(nil, error)
                    return
                }

                self.currentTokenId = acquireTokenResult.idToken

                completion(acquireTokenResult.accessToken, nil)
            }
        } catch let error {
            completion(nil, error)
        }
    }

    func acquireTokenInteractiveForCurrentAccount(forScopes scopes: [String], completion: @escaping (_ acessToken: String?, Error?) -> Void) {
        do {
            let application = try createClientApplication()
            let account = try currentAccount()

            let parameters = MSALInteractiveTokenParameters(scopes: scopes)
            parameters.account = account
            parameters.promptType = .default

            application.acquireToken(with: parameters) { (result: MSALResult?, error: Error?) in

                guard let acquireTokenResult = result, error == nil else {
                    completion(nil, error)
                    return
                }

                self.currentTokenId = acquireTokenResult.idToken

                completion(acquireTokenResult.accessToken, nil)
            }
        } catch let error {
            completion(nil, error)
        }
    }

    func acquireTokenForCurrentAccount(forScopes scopes: [String], completion: @escaping (_ idToken: String?, Error?) -> Void) {
        acquireTokenSilentForCurrentAccount(forScopes: scopes) { (token: String?, error: Error?) in
            if let token = token {
                completion(token, nil)
                return
            }

            let nsError = error! as NSError

            if nsError.domain == MSALErrorDomain &&
                nsError.code == MSALError.interactionRequired.rawValue {
                DispatchQueue.main.async {
                    self.acquireTokenInteractiveForCurrentAccount(forScopes: scopes, completion: completion)
                }
                return
            }

            completion(nil, error)
        }
    }

    func signOut() throws {

        clearCurrentAccount()

        let accountToDelete = try? currentAccount()

        if let accountToDelete = accountToDelete {
            let application = try createClientApplication()
            try application.remove(accountToDelete)
        }
    }

    func clearCurrentAccount() {
        UserDefaults.standard.removeObject(forKey: Constants.ACCOUNT_ID)
        UserDefaults.standard.removeObject(forKey: Constants.ID_TOKEN_KEY)
    }

    func verifyExpiredToken () {
        acquireTokenForCurrentAccount(forScopes: Constants.SCOPES) { (token: String?, _: Error?) in
            guard token != nil else {
                return
            }
        }
    }
}
