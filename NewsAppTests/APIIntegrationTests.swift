import XCTest
@testable import NewsApp

final class APIIntegrationTests: XCTestCase {

    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }

	func test_interactor_newsAPICall() {
		let expectation = XCTestExpectation(description: "Wait for news request")

		let presenter = MockInteractorOutput { result in
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

		wait(for: [expectation], timeout: 2)
	}
}
