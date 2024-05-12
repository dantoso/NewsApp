import UIKit

protocol HomeViewProtocol {
	func onErrorReceived(message: String)
	func onNewsReceived(articles: [ArticleModel])
	func onImageReceived(image: UIImage)
}

protocol PresenterProtocol {
	func startFetchingNews()
	func startImageFetch(url: String)
	func onNavigationRequest(to: ArticleModel)
}

protocol RouterProtocol {
	func createModule() -> HomeVC
	func routeToArticleView()
	func presentHomeView()
}

protocol InteractorInputProtocol {
	func fetchNews()
	func fetchImage(url: String)
}

protocol InteractorOutputProtocol {
	func onFetchNewsResult(_ result: Result<ResponseModel, Error>)
	func onImageRequestResult(_ result: Result<Data, Error>)
}
