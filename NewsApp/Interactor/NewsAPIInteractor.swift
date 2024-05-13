import Foundation
import Alamofire

struct NewsAPIInteractor: InteractorInputProtocol {

	let presenter: InteractorOutputProtocol
	let endpoint = "https://newsapi.org/v2/top-headlines?country=us&pageSize=100"

	var apiKey: String? {
		let key = Bundle.main.object(forInfoDictionaryKey: "NEWS_API_KEY") as? String

		return key
	}

	func fetchNews() {
		guard let apiKey else { fatalError("ERROR: Could not get API key in plist file") }

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
	
	func fetchImage(url: String, idx: Int) {
		Task {
			let result: Result<Data, Error>

			do {
				let response = try await AF
					.request(url, method: .get)
					.serializingData().value

				result = .success(response)
			} catch let error {
				result = .failure(error)
			}

			presenter.onImageRequestResult(result, idx: idx)
		}
	}
}
