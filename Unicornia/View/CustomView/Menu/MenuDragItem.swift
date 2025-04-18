import SwiftUI

struct MenuDragItem: View {
    @State private var position: CGSize = .zero
    
    let imageName: String
    let action: () -> Void
    
    var body: some View {
        Image(imageName)
            .resizable()
            .scaledToFit()
            .frame(width: 60, height: 60)
            .cornerRadius(10)
            .shadow(radius: 5)
            .offset(position)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        position = value.translation
                    }
                    .onEnded { value in
                        if value.translation.height < -100 && value.translation.height > -500 {
                            VibrationsService.shared.impactFeedback(style: .soft)
                            action()
                            
                            position = .zero
                        } else {
                            withAnimation {
                                position = .zero
                            }
                        }
                    }
            )
    }
}

