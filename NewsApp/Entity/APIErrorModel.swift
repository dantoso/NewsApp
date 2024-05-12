import Foundation

struct APIErrorModel: Decodable {
	let status: String?
	let code: String?
	let message: String?
}
