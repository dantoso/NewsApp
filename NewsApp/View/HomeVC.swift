import UIKit

final class HomeVC: UIViewController {
	weak var presenter: HomePresenterProtocol?

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemPink
	}


}

// TODO: Immplement these
extension HomeVC: HomeViewProtocol {
	func onErrorReceived(message: String) {

	}
	
	func onNewsReceived(articles: [ArticleModel]) {

	}
	
	func onImageReceived(image: UIImage, idx: Int) {

	}
}
