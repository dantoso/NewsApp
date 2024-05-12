import Foundation

struct ResponseModel: Decodable {
	let status: String
	let totalResults: Int
	let articles: [ArticleModel]
}
