import SwiftUI

struct NewsCellView: View {

	let image: UIImage?
	let article: ArticleModel

	var body: some View {
		VStack(alignment: .center, spacing: 10) {
			Text(article.title ?? "Untitled")
				.font(.system(size: 24, weight: .medium))
				.multilineTextAlignment(.center)

			if article.urlToImage != nil {
				if let image {
					Image(uiImage: image)
						.resizable()
						.aspectRatio(contentMode: .fit)
				} else {
					ProgressView()
				}
			}


			if let description = article.description {
				Text("\t\(description)")
					.font(.subheadline)
			}

			Text("by \(article.author ?? "Unknown author")")
				.font(.caption)
				.foregroundStyle(.gray)
		}
		.padding()
	}
}

#Preview {
	NewsCellView(
		image: nil,
		article: .init(
			source: .init(id: "", name: ""),
			author: "Allison Johnson",
			title: "Michael Cohen set to take the stand in Trump's hush money trial - NBC News",
			description: "The Google Pixel 8A is a midrange phone with a camera that punches above its weight — important when you’re unexpectedly photographing a once-in-a-lifetime event.",
			urlToImage: nil,
			publishedAt: nil,
			content: nil
		)
	)
}
