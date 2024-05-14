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
		vc.navigationItem.backButtonTitle = ""
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
		home.navigationItem.backButtonTitle = ""

		homePresenter.view = home
		homePresenter.interactor = interactor

		return home
	}

	private func setupNavController() {
		navController.viewControllers = [createHomeVC()]

		let backImage = UIImage(systemName: "chevron.backward.circle.fill")

		let appearance = UINavigationBar.appearance()
		appearance.backIndicatorImage = backImage
		appearance.backIndicatorTransitionMaskImage = backImage
	}
}
