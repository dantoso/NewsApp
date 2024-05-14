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
		let vc = UIHostingController(rootView: ArticleView(image: image, article: article))
		navController.pushViewController(vc, animated: true)
	}

	func startApp() {
		navController.navigationBar.tintColor = .white
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
