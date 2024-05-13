import XCTest
@testable import NewsApp

final class NewsAppTests: XCTestCase {

    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }

	func testInteractorNewsAPICall() {
		let expectation = XCTestExpectation(description: "Wait for news request")

		let presenter = PresenterMock { result in
			switch result {
			case .success(let success):
				print(success.status)
				XCTAssert(success.status == "ok")

			case .failure(let failure):
				print(failure.localizedDescription)
			}

			expectation.fulfill()
		}

		let interactor = NewsAPIInteractor(presenter: presenter)

		interactor.fetchNews()

		wait(for: [expectation], timeout: 15)
	}
}
