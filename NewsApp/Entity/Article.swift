import Foundation

struct Article: Decodable {
	let source: Source
	let author: String?
	let title: String?
	let description: String?
	let urlToImage: String?
	let publishedAt: String?
	let content: String?
}
