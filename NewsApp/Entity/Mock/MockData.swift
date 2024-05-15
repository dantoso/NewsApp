import UIKit

struct MockData {
	private enum ImageURLs: String {
		case hylicsWayne = "HylicsWayne"
	}

	static let articles = [
		ArticleModel(
			source: .init(id: "", name: ""),
			author: "Allison Johnson",
			title: "Michael Cohen set to take the stand in Trump's hush money trial - NBC News",
			description: "The Google Pixel 8A is a midrange phone with a camera that punches above its weight — important when you’re unexpectedly photographing a once-in-a-lifetime event.",
			urlToImage: ImageURLs.hylicsWayne.rawValue,
			publishedAt: "2024-05-14T15:54:30Z",
			content: "The Google Pixel 8A is a midrange phone with a camera that punches above its weight — important when you’re unexpectedly photographing a once-in-a-lifetime event. The Google Pixel 8A is a midrange phone with a camera that punches above its weight — important when you’re unexpectedly photographing a once-in-a-lifetime event. The Google Pixel 8A is a midrange phone with a camera that punches above its weight — important when you’re unexpectedly photographing a once-in-a-lifetime event. The Google Pixel 8A is a midrange phone with a camera that punches above its weight — important when you’re unexpectedly photographing a once-in-a-lifetime event. The Google Pixel 8A is a midrange phone with a camera that punches above its weight — important when you’re unexpectedly photographing a once-in-a-lifetime event. The Google Pixel 8A is a midrange phone with a camera that punches above its weight — important when you’re unexpectedly photographing a once-in-a-lifetime event. The Google Pixel 8A is a midrange phone with a camera that punches above its weight — important when you’re unexpectedly photographing a once-in-a-lifetime event. The Google Pixel 8A is a midrange phone with a camera that punches above its weight — important when you’re unexpectedly photographing a once-in-a-lifetime event. The Google Pixel 8A is a midrange phone with a camera that punches above its weight — important when you’re unexpectedly photographing a once-in-a-lifetime event. The Google Pixel 8A is a midrange phone with a camera that punches above its weight — important when you’re unexpectedly photographing a once-in-a-lifetime event. The Google Pixel 8A is a midrange phone with a camera that punches above its weight — important when you’re unexpectedly photographing a once-in-a-lifetime event. The Google Pixel 8A is a midrange phone with a camera that punches above its weight — important when you’re unexpectedly photographing a once-in-a-lifetime event. The Google Pixel 8A is a midrange phone with a camera that punches above its weight — important when you’re unexpectedly photographing a once-in-a-lifetime event. The Google Pixel 8A is a midrange phone with a camera that punches above its weight — important when you’re unexpectedly photographing a once-in-a-lifetime event."
		)
	]

	static func image(url: String) -> UIImage? {
		return UIImage(named: url)
	}
}
