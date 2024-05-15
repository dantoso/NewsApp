import SwiftUI

struct ArticleView: View {
	let image: UIImage?
	let article: ArticleModel
	let presenter = ArticlePresenter()

	@State private var scrollOffset: CGVector = .zero

	var mult: CGFloat {
		return -scrollOffset.dy*0.1
	}

	var body: some View {
		ZStack(alignment: .topTrailing) {
			LoadingImage(hasURL: article.urlToImage != nil, image: image)
				.offset(y: -mult)

			TrackableScrollView(scrollOffset: $scrollOffset) {
				VStack {
					Text(article.content ?? String.contentIsNil)
						.padding(.bottom)

					Text(String.lackOfContentNotice)
						.padding(.bottom)

					Text(String.loremIpsum)
				}
				.padding(.bottom, 100)
				.padding()
				.background {
					RoundedRectangle(cornerRadius: 24)
						.fill(.thinMaterial)
				}

			}
			.padding(.top, 170)

			date
				.padding()
				.padding(.top, 42)
				.offset(y: mult < 80 ? mult*0.5 : 40)
				.opacity(mult < 20 ? 1 : CGFloat(2 - mult/20))
				.blur(radius: mult < 25 ? 0 : mult/25)
		}
		.ignoresSafeArea()
	}

	var date: some View {
		let date = presenter.getFormattedDateString(from: article.publishedAt)
		return Text("\(String.publishedAt) \(date ?? String.dateIsNil)")
			.foregroundStyle(.secondary)
			.font(.footnote)
			.padding(10)
			.background {
				RoundedRectangle(cornerRadius: 12)
					.fill(.ultraThinMaterial)
			}
	}

}

#Preview {
	ArticleView(
		image: MockData.image(url: MockData.articles[0].urlToImage ?? ""),
		article: MockData.articles[0]
	)
	.preferredColorScheme(.dark)
}
