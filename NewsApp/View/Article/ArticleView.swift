import SwiftUI

struct ArticleView: View {
	@State var article: ArticleViewModel
	let screen: UIScreen

	@State private var scrollOffset: CGVector = .zero

	var mult: CGFloat {
		return -scrollOffset.dy*0.1
	}

	var body: some View {
		ZStack(alignment: .topTrailing) {

			animatedImage

			TrackableScrollView(scrollOffset: $scrollOffset) {
				VStack {
					Text(article.content ?? String.contentIsNil)
						.padding(.bottom)

					Text(String.lackOfContentNotice)
						.padding(.bottom)

					Text(String.loremIpsum)
				}
				.padding(.bottom, 100)
				.ignoresSafeArea()

			}
			.padding()
			.background {
				RoundedRectangle(cornerRadius: 24)
					.fill(.thinMaterial)
					.offset(y: scrollOffset.dy < 0 ? 0 : scrollOffset.dy)
					.ignoresSafeArea()
			}
			.padding(.top, screen.bounds.height*0.2)

			animatedDate
		}
	}

	var animatedImage: some View {
		let imageSpace = CGSize(width: screen.bounds.width, height: screen.bounds.height*0.3)
		let imageMoveLimit = imageSpace.height*0.28

		return LoadingImage(hasURL: article.imageURL != nil, image: article.image)
			.aspectRatio(contentMode: .fill)
			.frame(width: imageSpace.width, height: imageSpace.height)
			.mask {
				Rectangle()
					.frame(width: screen.bounds.width, height: screen.bounds.height*0.3)
			}
			.offset(y: mult < imageMoveLimit ? -mult : -imageMoveLimit)
	}

	var animatedDate: some View {
		return Text("\(String.publishedAt) \(article.dateString ?? String.dateIsNil)")
			.foregroundStyle(.secondary)
			.font(.footnote)
			.padding(10)
			.background {
				RoundedRectangle(cornerRadius: 12)
					.fill(.ultraThinMaterial)
			}
			.padding()
			.padding(.top)
			.offset(y: mult < 80 ? mult*0.5 : 40)
			.opacity(mult < 8 ? 1 : CGFloat(2 - mult/8))
			.blur(radius: mult < 10 ? 0 : mult/10)
	}

}

#Preview {
	ArticleView(
		article: MockData.getViewModels()[0],
		screen: UIScreen.main
	)
	.preferredColorScheme(.dark)
}
