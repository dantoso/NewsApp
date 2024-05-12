import Foundation

struct PresenterMock: InteractorOutputProtocol {

	let newsFetchCompletion: (Result<ResponseModel, Error>) -> Void
	let imageFetchCompletion: (Result<Data, Error>) -> Void

	init(
		newsFetchCompletion: @escaping (Result<ResponseModel, Error>) -> Void = { _ in },
		imageFetchCompletion: @escaping (Result<Data, Error>) -> Void = { _ in }
	) {
		self.newsFetchCompletion = newsFetchCompletion
		self.imageFetchCompletion = imageFetchCompletion
	}

	func onFetchNewsResult(_ result: Result<ResponseModel, Error>) {
		newsFetchCompletion(result)
	}
	
	func onImageRequestResult(_ result: Result<Data, Error>, idx: Int) {
		imageFetchCompletion(result)
	}
}
