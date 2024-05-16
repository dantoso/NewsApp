import UIKit

struct MockData {
	private enum ImageURLs: String {
		case hylicsWayne = "HylicsWayne"
	}

	static let articles = createModels()
	static let filteredArticles: [ArticleViewModel] = []
	static func getViewModels() -> [ArticleViewModel] {
		var idx = 0
		let vms = articles.map { model in
			var article = ArticleViewModel(model: model, index: idx)
			article.image = image(url: model.urlToImage ?? "")
			idx += 1

			return article
		}

		return vms
	}

	static func image(url: String) -> UIImage? {
		return UIImage(named: url)
	}

	static private func createModels() -> [ArticleModel] {
		var articles: [ArticleModel] = []

		for i in 0..<20 {
			let title: String? = {
				if i%7 == 0 {
					return "[Removed]"
				}
				if i%9 == 0 {
					return nil
				}

				return "Michael Cohen set to take the stand in Trump's hush money trial - NBC News"
			}()

			let model = ArticleModel(
				source: .init(id: "", name: ""),
				author: "Allison Johnson",
				title: title,
				description: "The Google Pixel 8A is a midrange phone with a camera that punches above its weight — important when you’re unexpectedly photographing a once-in-a-lifetime event.",
				urlToImage: ImageURLs.hylicsWayne.rawValue,
				publishedAt: "2024-05-14T15:54:30Z",
				content: String.loremIpsum
			)

			articles.append(model)
		}

		return articles
	}
}
