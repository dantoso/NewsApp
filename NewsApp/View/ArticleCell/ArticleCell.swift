import UIKit
import SwiftUI

final class ArticleCell: UITableViewCell {

	static let identifier = "NewsCell"

	func configure(article: ArticleViewModel, screen: UIScreen) {
		let controller = UIHostingController(rootView: ArticleCellView(article: article, screen: screen))
		guard let view = controller.view else { return }

		render(view: view)
	}

	private func render(view: UIView) {
		contentView.subviews.forEach { $0.removeFromSuperview() }
		contentView.addSubview(view)
		view.anchor(
			top: contentView.topAnchor,
			left: contentView.leftAnchor,
			bottom: contentView.bottomAnchor,
			right: contentView.rightAnchor
		)
	}
}
