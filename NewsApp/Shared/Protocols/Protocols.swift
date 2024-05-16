import UIKit

protocol HomeViewProtocol: AnyObject {
	func onErrorReceived(message: String)
	func onNewsReceived(articles: [ArticleViewModel])
	func onImageReceived(image: UIImage, idx: Int)
}

protocol HomePresenterProtocol: AnyObject {
	func startFetchingNews()
	func startImageFetch(url: String, idx: Int)
	func onNavigationRequest(to: ArticleViewModel)
}

protocol RouterProtocol: AnyObject {
	func routeToArticleView(article: ArticleViewModel)
	func updateImageOnArticleView(image: UIImage, idx: Int)
}

protocol InteractorInputProtocol {
	func fetchNews()
	func fetchImage(url: String, idx: Int)
}

protocol InteractorOutputProtocol: AnyObject {
	func onFetchNewsResult(_ result: Result<ResponseModel, Error>)
	func onImageRequestResult(_ result: Result<Data, Error>, idx: Int)
}
