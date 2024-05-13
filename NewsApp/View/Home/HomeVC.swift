import UIKit

final class HomeVC: UIViewController {

	private lazy var newsFeed: UITableView = createNewsFeed()
	private lazy var progressView = UIActivityIndicatorView(frame: view.bounds)

	weak var presenter: HomePresenterProtocol?

	var data: [ArticleModel] = []
	var images: [Int: UIImage] = [:]

	override func viewDidLoad() {
		super.viewDidLoad()
		addProgressView()

		presenter?.startFetchingNews()
	}

	private func addProgressView() {
		progressView.hidesWhenStopped = true
		view.addSubview(progressView)

		progressView.anchor(
			top: view.topAnchor,
			left: view.leftAnchor,
			bottom: view.bottomAnchor,
			right: view.rightAnchor
	  )

		progressView.startAnimating()
	}

	private func addNewsFeed() {
		progressView.stopAnimating()

		view.addSubview(newsFeed)

		newsFeed.anchor(
			top: view.topAnchor,
			left: view.leftAnchor,
			bottom: view.bottomAnchor,
			right: view.rightAnchor
		)
	}

	private func createNewsFeed() -> UITableView {
		let tableView = UITableView(frame: view.bounds)
		tableView.register(ArticleCell.self, forCellReuseIdentifier: ArticleCell.identifier)
		tableView.delegate = self
		tableView.dataSource = self
		
		return tableView
	}
}

// TODO: Immplement these
extension HomeVC: HomeViewProtocol {
	func onErrorReceived(message: String) {
		print(message)
	}
	
	func onNewsReceived(articles: [ArticleModel]) {
		data = articles
		DispatchQueue.main.async {
			self.addNewsFeed()
		}
	}
	
	func onImageReceived(image: UIImage, idx: Int) {
		print("got image at \(idx)")

		images.updateValue(image, forKey: idx)

		DispatchQueue.main.async {
			let path = IndexPath(row: 0, section: idx)
			self.newsFeed.reconfigureRows(at: [path])
		}
	}
}

extension HomeVC: UITableViewDataSource {

	func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return 10
	}

	func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		let view = UIView()
		view.backgroundColor = UIColor.clear
		return view
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return data.count
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard
			let cell = tableView.dequeueReusableCell(withIdentifier: ArticleCell.identifier, for: indexPath) as? ArticleCell
		else { fatalError("Could not find reusable NewsCell for \(indexPath)") }

		let article = data[indexPath.section]
		let image = images[indexPath.section]
		cell.configure(article: article, image: image)

		if let urlToImage = article.urlToImage, image == nil {
			presenter?.startImageFetch(url: urlToImage, idx: indexPath.section)
		}

		return cell
	}
	

}

extension HomeVC: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

	}
}
