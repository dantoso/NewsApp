import Foundation

struct ErrorResponseModel: Decodable, Error {
	let status: String?
	let code: String?
	let message: String?
}
