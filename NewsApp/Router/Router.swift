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

	func routeToArticleView(article: ArticleViewModel) {
		let vc = UIHostingController(rootView: ArticleView(article: article, screen: window.screen))
		vc.title = "Article"
		vc.navigationItem.backButtonTitle = ""
		vc.navigationItem.largeTitleDisplayMode = .never
		navController.pushViewController(vc, animated: true)
	}

	func updateImageOnArticleView(image: UIImage, idx: Int) {
		Task { @MainActor in
			guard let vc = navController.topViewController as? UIHostingController<ArticleView> else { return }
			guard vc.rootView.article.index == idx else { return }
			
			let article = ArticleViewModel(viewModel: vc.rootView.article, updatingImage: image)
			vc.rootView = ArticleView(article: article, screen: window.screen)
		}
	}

	func startApp() {
		setupNavController()
		window.rootViewController = navController
		window.overrideUserInterfaceStyle = .dark
		window.makeKeyAndVisible()
	}

	private func createHomeVC() -> HomeVC {
		let home = HomeVC(screen: window.screen)
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
