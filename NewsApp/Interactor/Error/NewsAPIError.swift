import Foundation

enum NewsAPIError: Error {
	case imageNotFound
	case corruptedImage
	case articlesNotFound
	case conectionError
	case badRequest
	case missingKey
}
