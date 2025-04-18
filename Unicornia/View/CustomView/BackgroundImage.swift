import SwiftUI

struct BackgroundImage: View {
    let imageName: String
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
            .scaleEffect(1.30)
    }
}
