import SwiftUI

struct NavigationButton<Destination: View>: View {
    let imageName: String
    let destination: Destination
    
    var body: some View {
        NavigationLink(destination: destination) {
            Image(imageName)
                .resizable()
                .scaledToFill()
        }
        .frame(width: 80, height: 80)
    }
}
