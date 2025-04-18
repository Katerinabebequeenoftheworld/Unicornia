import SwiftUI

struct MenuRectangle: View {

    var body: some View {
        Rectangle()
        .fill(Color.init(hexString: "FF5FE7"))
            .opacity(0.5)
            .cornerRadius(20)
            .frame(width: 300, height: 80)
    }
}
