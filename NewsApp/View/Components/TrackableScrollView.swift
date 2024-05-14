import SwiftUI

struct TrackableScrollView<Content: View>: View {
	let axes: Axis.Set
	let showsIndicators: Bool
	@Binding var scrollOffset: CGVector
	let content: Content

	init(_ axes: Axis.Set = .vertical, showsIndicators: Bool = false, scrollOffset: Binding<CGVector>, @ViewBuilder content: () -> Content) {
		self.axes = axes
		self.showsIndicators = showsIndicators
		self._scrollOffset = scrollOffset
		self.content = content()
	}


	var body: some View {
		ScrollView(axes, showsIndicators: showsIndicators) {
			ZStack {
				GeometryReader { proxy in
					Color.clear
						.preference(key: PointPreferenceKey.self, value: proxy.frame(in: .named("ScrollView")).origin)
				}
				content
			}
		}
		.coordinateSpace(name: "ScrollView")
		.onPreferenceChange(PointPreferenceKey.self) { origin in
			let xOffset = origin.x
			let yOffset = origin.y

			scrollOffset = CGVector(dx: xOffset, dy: yOffset)
		}
	}
}

struct PointPreferenceKey: PreferenceKey {
	typealias Value = CGPoint
	static var defaultValue: CGPoint = .zero

	static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {}
}

struct TrackableScroll_Previews: PreviewProvider {
	@State static var scrollOffset: CGVector = .zero

	static var previews: some View {
		VStack {
			Text("dx: \(scrollOffset.dx)")
			Text("dy: \(scrollOffset.dy)")
			TrackableScrollView(.vertical, scrollOffset: $scrollOffset) {
				VStack {
					ForEach(0..<20) { i in
						Text("number: \(i)")
							.background(.yellow)
							.padding()
							.background(.red)
							.padding()
							.background(.green)
					}
				}
			}
		}
	}
}
