import UIKit
import SwiftUI

final class NewsCell: UITableViewCell {

	static let identifier = "NewsCell"

	func configure(article: ArticleModel, image: UIImage?) {
		let controller = UIHostingController(rootView: NewsCellView(image: image, article: article))
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
