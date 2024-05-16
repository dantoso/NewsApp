import UIKit

struct ArticleViewModel {
	private let isoDate: String?
	let index: Int
	var image: UIImage?
	let imageURL: String?
	let title: String?
	let description: String?
	let content: String?
	let author: String?

	var dateString: String? {
		guard let isoDate else { return nil }

		let isoFormatter = ISO8601DateFormatter()
		isoFormatter.timeZone = TimeZone(secondsFromGMT: 0)

		guard let date = isoFormatter.date(from: isoDate) else { return nil }

		let formatter = DateFormatter()
		formatter.dateStyle = .long
		formatter.timeStyle = .none

		let formattedString = formatter.string(from: date)

		return formattedString
	}

	init(model: ArticleModel, index: Int) {
		self.index = index
		self.image = nil
		self.imageURL = model.urlToImage
		self.title = model.title
		self.description = model.description
		self.content = model.content
		self.author = model.author
		self.isoDate = model.publishedAt
	}
}
