import XCTest
@testable import NewsApp

final class InteractorPresenterTests: XCTestCase {

	var receivedImageURL: String?
	lazy var mockPresenter = MockInteractorOutput { result in
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

	override func setUpWithError() throws { 
		receivedImageURL = nil
	}

	override func tearDownWithError() throws { }

	func testMockInteractorMockPresenterFetchConnection() {
		let interactor = MockInteractor(output: mockPresenter)

		interactor.fetchNews()
		interactor.fetchImage(url: receivedImageURL ?? "", idx: 0)
	}


}
