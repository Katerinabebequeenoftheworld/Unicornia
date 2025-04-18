import SwiftUI

struct MainButton: View {
    let imageName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
            VibrationsService.shared.impactFeedback(style: .medium)
        }) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
        }
        .frame(width: 100, height: 100)
    }
}
