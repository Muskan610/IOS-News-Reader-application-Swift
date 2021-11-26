
import Foundation


enum APIError: Error {
    case decodingError
    case errorCode(Int)
    case unknown
}

extension APIError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .decodingError:
            return "something went wrong while decoding"
        case .errorCode(let code):
            return "Error \(code) Somthing went wrong :("
        case .unknown:
            return "Error Unknown"
        }
    }
}
