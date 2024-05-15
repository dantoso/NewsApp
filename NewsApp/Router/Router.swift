import UIKit
import SwiftUI

final class Router: RouterProtocol {

	private let window: UIWindow
	private var navController = UINavigationController()

	private lazy var homePresenter = HomePresenter(router: self)
	private lazy var interactor = NewsAPIInteractor(presenter: homePresenter)

	init(window: UIWindow) {
		self.window = window
	}

	func routeToArticleView(article: ArticleModel, image: UIImage?) {
		let vc = UIHostingController(rootView: ArticleView(image: image, article: article, screen: window.screen))
		vc.navigationItem.backButtonTitle = ""
		vc.navigationItem.largeTitleDisplayMode = .never
		navController.pushViewController(vc, animated: true)
	}

	func startApp() {
		setupNavController()
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

	private func setupNavController() {
		navController.viewControllers = [createHomeVC()]
		navController.navigationBar.prefersLargeTitles = true
	}
}
