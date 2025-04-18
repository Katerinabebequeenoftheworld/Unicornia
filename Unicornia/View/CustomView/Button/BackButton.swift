import SwiftUI

struct BackButton: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button(action: {
            dismiss()
            VibrationsService.shared.impactFeedback(style: .light)
        }) {
            Image("back_button")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
        }
        .frame(width: 100, height: 100)
    }
}
