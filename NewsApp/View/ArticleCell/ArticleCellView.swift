import SwiftUI

struct ArticleCellView: View {

	let article: ArticleViewModel
	let screen: UIScreen

	var body: some View {
		VStack(alignment: .center, spacing: 10) {
			title
				.padding()

			ZStack(alignment: .bottom) {
				imageView
					.mask {
						RoundedRectangle(cornerRadius: 8)
					}
					.padding(.horizontal, 24)
					.padding(.bottom, 80)

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
		.background {
			imageView
				.aspectRatio(contentMode: .fill)
				.mask {
					RoundedRectangle(cornerRadius: 24)
						.frame(width: screen.bounds.width)
				}

		}

	}

	var title: some View {
		Text(article.title ?? String.titleIsNil)
			.font(.system(size: 24, weight: .medium))
			.multilineTextAlignment(.center)
	}

	var imageView: some View {
		LoadingImage(hasURL: article.imageURL != nil, image: article.image)
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
		article: ArticleViewModel(model: MockData.articles[0], index: 0),
		screen: UIScreen.main
	)
	.preferredColorScheme(.dark)
}
