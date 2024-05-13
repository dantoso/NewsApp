import SwiftUI

struct ArticleCellView: View {

	let image: UIImage?
	let article: ArticleModel

	var body: some View {
		VStack(alignment: .center, spacing: 10) {
			title

			loadingImage

			description

			author
		}
		.padding()
		.background {
			RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/)
				.fill(.regularMaterial)
		}
	}

	var title: some View {
		Text(article.title ?? "Untitled")
			.font(.system(size: 24, weight: .medium))
			.multilineTextAlignment(.center)
	}

	var description: some View {
		Group {
			if let description = article.description {
				Text("\(description)")
					.font(.subheadline)
					.multilineTextAlignment(.center)
			}
		}
	}

	var author: some View {
		Text("by \(article.author ?? "Unknown author")")
			.font(.caption)
			.opacity(0.8)
	}

	var loadingImage: some View {
		Group {
			if article.urlToImage != nil {
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

#Preview {
	ArticleCellView(
		image: UIImage(named: "HylicsWayne"),
		article: .init(
			source: .init(id: "", name: ""),
			author: "Allison Johnson",
			title: "Michael Cohen set to take the stand in Trump's hush money trial - NBC News",
			description: "The Google Pixel 8A is a midrange phone with a camera that punches above its weight — important when you’re unexpectedly photographing a once-in-a-lifetime event.",
			urlToImage: "not nil",
			publishedAt: nil,
			content: nil
		)
	)
}
