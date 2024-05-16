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
	
	func onNavigationRequest(to article: ArticleViewModel) {
		router?.routeToArticleView(article: article)
	}

	func onFetchNewsResult(_ result: Result<ResponseModel, any Error>) {
		switch result {
		case .success(let success):
			let articles = getViewModelFromData(data: success.articles)
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
				router?.updateImageOnArticleView(image: image, idx: idx)
			} else {
				view?.onErrorReceived(message: "Data received could not be converted to image")
			}

		case .failure(let failure):
			view?.onErrorReceived(message: failure.localizedDescription)
		}
	}

	func getViewModelFromData(data: [ArticleModel]) -> [ArticleViewModel] {
		var idx = 0
		let articles: [ArticleViewModel] = data.compactMap { model in
			let title = model.title
			guard title != nil && title != "[Removed]" else { return nil }

			let vm = ArticleViewModel(model: model, index: idx)
			idx += 1
			
			return vm
		}

		return articles
	}
}
