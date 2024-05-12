import UIKit

protocol ViewToPresenterProtocol {
	func startFetchingNews()
	func startImageFetch(url: String)
}

protocol PresenterToViewProtocol {
	func onErrorReceived(message: String)
	func onNewsReceived(articles: [ArticleModel])
	func onImageReceived(image: UIImage)
}

protocol PresenterToRouterProtocol {
	func routeToArticleView()
	func routeToHomeView()
}

protocol PresenterToInteractorProtocol {
	func fetchNews()
	func fetchImage(url: String)
}

protocol InteractorToPresenterProtocol {
	func onFetchNewsResult(_ result: Result<ResponseModel, Error>)
	func onImageRequestResult(_ result: Result<Data, Error>)
}
