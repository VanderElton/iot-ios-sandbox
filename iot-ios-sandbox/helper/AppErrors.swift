
import Foundation

enum AppErrors: Error {
    case PublicClientApplicationCreation(NSError)
    case UserNotFound (NSError)
    case NoUserSignedIn
}
