import Foundation

struct Response: Decodable {
	let status: String
	let totalResults: Int
	let articles: [Article]
}
