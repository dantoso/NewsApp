import UIKit

final class MockRouter: RouterProtocol {
	func routeToArticleView(article: ArticleViewModel) { }
	func updateImageOnArticleView(image: UIImage, idx: Int) { }
}
