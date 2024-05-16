import Foundation

enum NewsAPIError: Error {
	case imageNotFound
	case corruptedImage
	case articlesNotFound
	case decodeFailed
	case requestFailed
	case missingKey
	case wrongEndpointFormat
}
