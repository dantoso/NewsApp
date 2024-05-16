import Foundation

struct NewsAPIInteractor: InteractorInputProtocol {

	let presenter: InteractorOutputProtocol
	let endpoint = "https://newsapi.org/v2/top-headlines?country=us&pageSize=100"
	let apiKeyHeader = "Authorization"

	var apiKey: String? {
		let key = Bundle.main.object(forInfoDictionaryKey: "NEWS_API_KEY") as? String

		return key
	}

	func fetchNews() {
		guard let apiKey else {
			return presenter.onFetchNewsResult(.failure(NewsAPIError.missingKey))
		}

		guard let url = URL(string: endpoint) else {
			return presenter.onFetchNewsResult(.failure(NewsAPIError.wrongEndpointFormat))
		}

		Task {
			var request = URLRequest(url: url)
			request.setValue(apiKey, forHTTPHeaderField: apiKeyHeader)

			let session = URLSession.shared
			do {
				let (data, response) = try await session.data(for: request)
				let model = try decodeData(data: data)

				presenter.onFetchNewsResult(.success(model))

			} catch let error {
				if error is NewsAPIError {
					return presenter.onFetchNewsResult(.failure(error))
				}
				presenter.onFetchNewsResult(.failure(NewsAPIError.requestFailed))
			}
		}
	}
	
	func fetchImage(url: String, idx: Int) {
		guard let url = URL(string: url) else {
			return presenter.onImageRequestResult(.failure(NewsAPIError.wrongEndpointFormat), idx: idx)
		}

		Task {
			var request = URLRequest(url: url)
			let session = URLSession.shared
			do {
				let (data, response) = try await session.data(for: request)
				presenter.onImageRequestResult(.success(data), idx: idx)
			} catch {
				presenter.onImageRequestResult(.failure(NewsAPIError.imageNotFound), idx: idx)
			}
		}
	}

	func decodeData(data: Data) throws -> ResponseModel {
		let decoder = JSONDecoder()
		do {
			let response = try decoder.decode(ResponseModel.self, from: data)
			return response
		} catch {
			throw NewsAPIError.decodeFailed
		}
	}
}
