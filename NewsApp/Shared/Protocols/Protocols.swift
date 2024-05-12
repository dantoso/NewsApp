import UIKit

protocol HomeViewProtocol {
	func onErrorReceived(message: String)
	func onNewsReceived(articles: [ArticleModel])
	func onImageReceived(image: UIImage, idx: Int)
}

protocol PresenterProtocol {
	func startFetchingNews()
	func startImageFetch(url: String, idx: Int)
	func onNavigationRequest(to: ArticleModel)
}

protocol RouterProtocol {
	func createModule() -> HomeVC
	func routeToArticleView()
	func presentHomeView()
}

protocol InteractorInputProtocol {
	func fetchNews()
	func fetchImage(url: String, idx: Int)
}

protocol InteractorOutputProtocol {
	func onFetchNewsResult(_ result: Result<ResponseModel, Error>)
	func onImageRequestResult(_ result: Result<Data, Error>, idx: Int)
}
