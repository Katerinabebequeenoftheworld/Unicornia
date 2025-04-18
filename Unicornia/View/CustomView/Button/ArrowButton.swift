import SwiftUI

struct ArrowButton: View {
    let imageName: String
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            action()
            VibrationsService.shared.impactFeedback(style: .soft)
        }) {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
        }
        .frame(width: 80, height: 80)
    }
}
