import UIKit

final class Router: RouterProtocol {

	private let window: UIWindow
	private var navController = UINavigationController()

	private lazy var homePresenter = HomePresenter(router: self)
	private lazy var interactor = NewsAPIInteractor(presenter: homePresenter)

	init(window: UIWindow) {
		self.window = window
	}
	
	// TODO: Implement this
	func routeToArticleView(article: ArticleModel) {
		print("Routing to article view not yet implemented")
	}

	func startApp() {
		navController.viewControllers = [createHomeVC()]
		window.rootViewController = navController
		window.overrideUserInterfaceStyle = .dark
		window.makeKeyAndVisible()
	}

	private func createHomeVC() -> HomeVC {
		let home = HomeVC()
		home.presenter = homePresenter

		homePresenter.view = home
		homePresenter.interactor = interactor

		return home
	}
}
