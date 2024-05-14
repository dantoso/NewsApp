import Foundation

struct ArticlePresenter {
	func getFormattedDateString(from string: String?) -> String? {
		guard let string else { return nil }

		let isoFormatter = ISO8601DateFormatter()
		isoFormatter.timeZone = TimeZone(secondsFromGMT: 0)

		guard let date = isoFormatter.date(from: string) else { return nil }

		let formatter = DateFormatter()
		formatter.dateStyle = .long
		formatter.timeStyle = .none

		let formattedString = formatter.string(from: date)

		return formattedString
	}
}
