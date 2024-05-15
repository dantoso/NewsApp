import Foundation

struct MockInteractor: InteractorInputProtocol {

	let output: InteractorOutputProtocol

	func fetchNews() {
		let response = ResponseModel(status: "ok", totalResults: 1, articles: MockData.articles)
		output.onFetchNewsResult(.success(response))
	}
	
	func fetchImage(url: String, idx: Int) {
		guard 
			let image = MockData.image(url: url)
		else {
			return output.onImageRequestResult(.failure(NewsAPIError.imageNotFound), idx: idx)
		}

		guard
			let data = image.jpegData(compressionQuality: 1)
		else {
			return output.onImageRequestResult(.failure(NewsAPIError.corruptedImage), idx: idx)
		}

		output.onImageRequestResult(.success(data), idx: idx)
	}
	

}
