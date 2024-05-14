import SwiftUI

struct LoadingImage: View {
	let hasURL: Bool
	let image: UIImage?

	var body: some View {
		Group {
			if hasURL {
				if let image {
					Image(uiImage: image)
						.resizable()
						.aspectRatio(contentMode: .fit)
				} else {
					ProgressView()
				}
			}
		}
	}
}
