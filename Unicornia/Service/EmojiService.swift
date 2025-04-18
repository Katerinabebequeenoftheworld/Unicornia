import SwiftUI

struct Emoji: Identifiable {
    let id: UUID
    let position: CGPoint
    var opacity: Double
}

class EmojiService: ObservableObject {
    @Published var emojis: [Emoji] = []
    
    func startEmojiRain(in size: CGSize) {
        emojis.removeAll()
        
        let centerX = size.width / 2
        let centerY = size.height / 2
        let squareSize: CGFloat = 300
        
        for _ in 0..<10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0...3)) {
                let newEmoji = Emoji(
                    id: UUID(),
                    position: CGPoint(
                        x: centerX + CGFloat.random(in: -squareSize/2...squareSize/2),
                        y: centerY + CGFloat.random(in: -squareSize/2...squareSize/2)
                    ),
                    opacity: 0
                )

                self.emojis.append(newEmoji)

                withAnimation(.easeInOut(duration: 1)) {
                    if let index = self.emojis.firstIndex(where: { $0.id == newEmoji.id }) {
                        self.emojis[index].opacity = 1
                    }
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.easeInOut(duration: 1)) {
                        if let index = self.emojis.firstIndex(where: { $0.id == newEmoji.id }) {
                            self.emojis[index].opacity = 0
                        }
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        self.emojis.removeAll { $0.id == newEmoji.id }
                    }
                }
            }
        }
    }
    
    func startLongEmojiRain(in size: CGSize) {
        emojis.removeAll()
        
        let centerX = size.width / 2
        let centerY = size.height / 2
        let squareSize: CGFloat = 300
        
        for _ in 0..<30 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double.random(in: 0...3)) {
                let newEmoji = Emoji(
                    id: UUID(),
                    position: CGPoint(
                        x: centerX + CGFloat.random(in: -squareSize/2...squareSize/2),
                        y: centerY + CGFloat.random(in: -squareSize/2...squareSize/2)
                    ),
                    opacity: 0
                )

                self.emojis.append(newEmoji)

                withAnimation(.easeInOut(duration: 1)) {
                    if let index = self.emojis.firstIndex(where: { $0.id == newEmoji.id }) {
                        self.emojis[index].opacity = 1
                    }
                }

                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation(.easeInOut(duration: 1)) {
                        if let index = self.emojis.firstIndex(where: { $0.id == newEmoji.id }) {
                            self.emojis[index].opacity = 0
                        }
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        self.emojis.removeAll { $0.id == newEmoji.id }
                    }
                }
            }
        }
    }
}

struct EmojiOverlay: View {
    @ObservedObject var service: EmojiService
    var emojiType: String
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(service.emojis) { emoji in
                    Text(emojiType)
                        .font(.system(size: 40))
                        .opacity(emoji.opacity)
                        .position(emoji.position)
                        .animation(.easeInOut(duration: 1), value: emoji.opacity)
                }
            }
            .onAppear {
                service.startEmojiRain(in: geometry.size)
            }
        }
    }
}
