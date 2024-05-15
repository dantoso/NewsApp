import Foundation
import UIKit

final class HomePresenter: HomePresenterProtocol, InteractorOutputProtocol {
	var interactor: InteractorInputProtocol?
	weak var router: RouterProtocol?
	weak var view: HomeViewProtocol?

	init(router: RouterProtocol) {
		self.router = router
	}

	func startFetchingNews() {
		interactor?.fetchNews()
	}
	
	func startImageFetch(url: String, idx: Int) {
		interactor?.fetchImage(url: url, idx: idx)
	}
	
	func onNavigationRequest(to article: ArticleModel, with image: UIImage?) {
		router?.routeToArticleView(article: article, image: image)
	}
	
	func onFetchNewsResult(_ result: Result<ResponseModel, any Error>) {
		switch result {
		case .success(let success):
			let articles = filterRemovedAndEmptyArticles(articles: success.articles)
			view?.onNewsReceived(articles: articles)

		case .failure(let failure):
			view?.onErrorReceived(message: failure.localizedDescription)

		}
	}
	
	func onImageRequestResult(_ result: Result<Data, any Error>, idx: Int) {
		switch result {
		case .success(let data):
			if let image = UIImage(data: data) {
				view?.onImageReceived(image: image, idx: idx)
			} else {
				view?.onErrorReceived(message: "Data received could not be converted to image")
			}

		case .failure(let failure):
			view?.onErrorReceived(message: failure.localizedDescription)
		}
	}

	func filterRemovedAndEmptyArticles(articles: [ArticleModel]) -> [ArticleModel] {
		let filtered = articles.filter { article in
			let title = article.title
			return title != nil && title != "[Removed]"
		}

		return filtered
	}
}
