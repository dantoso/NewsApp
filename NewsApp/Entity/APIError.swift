import Foundation

struct APIError: Decodable {
	let status: String?
	let code: String?
	let message: String?
}
