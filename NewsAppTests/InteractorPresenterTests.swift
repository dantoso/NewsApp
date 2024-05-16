import XCTest
@testable import NewsApp

final class InteractorPresenterTests: XCTestCase {

	var receivedImageURL: String?
	var mockPresenter: MockInteractorOutput?

	override func setUpWithError() throws { 
		receivedImageURL = nil

		mockPresenter = MockInteractorOutput { result in
			switch result {
			case .success(let success):
				self.receivedImageURL = success.articles.first?.urlToImage
				XCTAssert(success.status == "ok")
				XCTAssert(success.totalResults == success.articles.count)
				for i in 0..<success.totalResults {
					XCTAssert(success.articles[i].title == MockData.articles[i].title)
				}

			case .failure(_):
				XCTAssert(false)

			}
		} imageFetchCompletion: { result in
			switch result {
			case .success(let data):
				XCTAssertNotNil(UIImage(data: data))

			case .failure(_):
				XCTAssert(false)
			}
		}
	}

	override func tearDownWithError() throws { 
		receivedImageURL = nil
		mockPresenter = nil
	}

	func test_mockInteractor_mockPresenter_fetchConnection() {
		let interactor = MockInteractor(output: mockPresenter!)

		interactor.fetchNews()
		interactor.fetchImage(url: receivedImageURL ?? "", idx: 0)
	}

	func test_homePresenter_connection_to_HomeView() {
		let router = MockRouter()
		let presenter = HomePresenter(router: router)
		let view = HomeVC(screen: .init())
		let interactor = MockInteractor(output: presenter)

		view.presenter = presenter
		presenter.view = view

		interactor.fetchNews()

		let data = view.getData()
		XCTAssert(!data.isEmpty)
		for i in 0..<data.count {
			let article = data[i]
			XCTAssert(article.title == MockData.articles[i].title)
			XCTAssertNil(article.image)

			if let url = article.imageURL {
				interactor.fetchImage(url: url, idx: i)
			}
		}

		let newData = view.getData()
		XCTAssert(!newData.isEmpty)
		for i in 0..<newData.count {
			if newData[i].imageURL != nil {
				XCTAssertNotNil(newData[i].image)
			}
		}
	}
}
