import UIKit

struct MockData {
	private enum ImageURLs: String {
		case hylicsWayne = "HylicsWayne"
	}

	static let articles = [
		ArticleModel(
			source: .init(id: "", name: ""),
			author: "Allison Johnson",
			title: "Michael Cohen set to take the stand in Trump's hush money trial - NBC News",
			description: "The Google Pixel 8A is a midrange phone with a camera that punches above its weight — important when you’re unexpectedly photographing a once-in-a-lifetime event.",
			urlToImage: ImageURLs.hylicsWayne.rawValue,
			publishedAt: "2024-05-14T15:54:30Z",
			content: String.loremIpsum
		)
	]

	static func getViewModels() -> [ArticleViewModel] {
		var idx = 0
		let vms = articles.map { model in
			idx += 1
			var article = ArticleViewModel(model: model, index: idx)
			article.image = image(url: model.urlToImage ?? "")

			return article
		}

		return vms
	}

	static func image(url: String) -> UIImage? {
		return UIImage(named: url)
	}
}
