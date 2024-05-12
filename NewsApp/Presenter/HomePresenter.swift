import Foundation

final class HomePresenter: HomePresenterProtocol, InteractorOutputProtocol {
	var interactor: InteractorInputProtocol?
	weak var router: RouterProtocol?
	weak var view: HomeViewProtocol?

	init(router: RouterProtocol) {
		self.router = router
	}

	// TODO: Implement these
	func startFetchingNews() {

	}
	
	func startImageFetch(url: String, idx: Int) {

	}
	
	func onNavigationRequest(to: ArticleModel) {

	}
	
	func onFetchNewsResult(_ result: Result<ResponseModel, any Error>) {

	}
	
	func onImageRequestResult(_ result: Result<Data, any Error>, idx: Int) {

	}
}
