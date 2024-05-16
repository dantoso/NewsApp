import UIKit

final class HomeVC: UIViewController {

	private lazy var newsFeed: UITableView = createNewsFeed()
	private lazy var progressView = UIActivityIndicatorView(frame: view.bounds)

	private var data: [ArticleViewModel] = []

	weak var presenter: HomePresenterProtocol?

	let screen: UIScreen

	init(screen: UIScreen) {
		self.screen = screen
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()

		title = "Today's news"
		navigationItem.largeTitleDisplayMode = .always
		navigationItem.backButtonTitle = ""

		addProgressView()

		presenter?.startFetchingNews()
	}

	override func viewWillAppear(_ animated: Bool) {
		let appearance = UINavigationBarAppearance()
		appearance.configureWithDefaultBackground()
		
		navigationController?.navigationBar.standardAppearance = appearance
		navigationController?.navigationBar.scrollEdgeAppearance = appearance
		navigationController?.navigationBar.compactAppearance = appearance

		super.viewWillAppear(animated)
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
		tableView.separatorStyle = .none

		return tableView
	}

	func getData() -> [ArticleViewModel] {
		return data
	}
}

extension HomeVC: HomeViewProtocol {

	// TODO: Alert errors to user
	func onErrorReceived(message: String) {
		print(message)
	}
	
	func onNewsReceived(articles: [ArticleViewModel]) {
		data = articles
		Task { @MainActor in
			self.addNewsFeed()
		}
	}
	
	func onImageReceived(image: UIImage, idx: Int) {
		print("got image at \(idx)")

		data[idx].image = image

		Task { @MainActor in
			let path = IndexPath(row: 0, section: idx)
			self.newsFeed.reconfigureRows(at: [path])
		}
	}
}

extension HomeVC: UITableViewDataSource {

	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 15
	}

	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
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
		cell.configure(article: article, screen: screen)

		if let urlToImage = article.imageURL, article.image == nil {
			presenter?.startImageFetch(url: urlToImage, idx: indexPath.section)
		}

		return cell
	}
	

}

extension HomeVC: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let article = data[indexPath.section]
		presenter?.onNavigationRequest(to: article)
	}
}
