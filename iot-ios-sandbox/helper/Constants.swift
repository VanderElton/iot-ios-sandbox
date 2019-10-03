
import Foundation

public struct Constants {

    static let ENDPOINT = "https://login.microsoftonline.com/tfp/%@/%@"
    static let CLIENT_ID = "<your_client_id>"
    static let SCOPES: [String] = ["your_scopes"]
    static let POLICY = "your_policy"
    static let TENANT = "your_tenant.onmicrosoft.com"
    static let BASE_URL = "https://your_api"

    /* UserDefaults KEYS */
    static let ID_TOKEN_KEY = "msal.idtoken"
    static let ACCOUNT_ID = "msal.currentAccountIdentifier"

}
