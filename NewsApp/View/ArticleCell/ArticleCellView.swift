import SwiftUI

struct ArticleCellView: View {

	let image: UIImage?
	let article: ArticleModel

	var body: some View {
		VStack(alignment: .center, spacing: 10) {
			title
				.padding()

			ZStack(alignment: .bottom) {
				LoadingImage(hasURL: article.urlToImage != nil, image: image)
					.padding(.horizontal, 24)
					.padding(.bottom, 56)

				description
					.padding(.horizontal, 12)
			}

			author
				.padding(.bottom)
		}
		.background {
			RoundedRectangle(cornerRadius: 24)
				.fill(.regularMaterial)
		}
	}

	var title: some View {
		Text(article.title ?? String.titleIsNil)
			.font(.system(size: 24, weight: .medium))
			.multilineTextAlignment(.center)
	}

	var description: some View {
		Group {
			if let description = article.description {
				Text("\(description)")
					.font(.subheadline)
					.multilineTextAlignment(.leading)
			}
		}
		.padding()
		.background {
			RoundedRectangle(cornerRadius: 10)
				.fill(.thinMaterial)
		}
		.fixedSize(horizontal: false, vertical: true)
	}

	var author: some View {
		Text("\(String.byAuthor) \(article.author ?? String.authorIsNil)")
			.font(.caption)
			.opacity(0.8)
	}
}

#Preview {
	ArticleCellView(
		image: MockData.image(url: MockData.articles[0].urlToImage ?? ""),
		article: MockData.articles[0]
	)
	.preferredColorScheme(.dark)
}
