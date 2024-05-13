import Foundation
import Alamofire

final class NewsAPIInteractor: InteractorInputProtocol {

	let presenter: InteractorOutputProtocol
	let endpoint = "https://newsapi.org/v2/top-headlines?country=br"

	lazy var apiKey: String? = {
		let key = Bundle.main.object(forInfoDictionaryKey: "NEWS_API_KEY") as? String

		return key
	}()

	init(presenter: InteractorOutputProtocol) {
		self.presenter = presenter
	}

	func fetchNews() {
		guard let apiKey else { fatalError("ERROR: Could not get API key frin plist file") }

		let headers: HTTPHeaders = ["Authorization": apiKey]

		Task {
			let result: Result<ResponseModel, Error>

			do {
				let response = try await AF
					.request(endpoint, method: .get, headers: headers)
					.serializingDecodable(ResponseModel.self).value

				result = .success(response)
			} catch let error {
				result = .failure(error)
			}

			presenter.onFetchNewsResult(result)
		}
	}
	
	func fetchImage(url: String) {
		
	}
}
