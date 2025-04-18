import SwiftUI

struct MainView: View {
    @ObservedObject var tamagotchiService = TamagotchiService.shared
    @State private var unicornState: String = "normal"
    private let worldType = OnboardingService.shared.getWorlsType()
    
    @StateObject private var emojiService = EmojiService()
    @State private var showEmoji = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    HStack {
                        MoneyCounter()
                        Spacer()
                        NeedsBar()
                    }
                    
                    Spacer()
                    
                    UnicornView(unicornState: $unicornState)
                    
                    Spacer()
                    
                    HStack(spacing: -10) {
                        NavigationButton(
                            imageName: "kitchen_navigation",
                            destination: KitchenView()
                        )
                        NavigationButton(
                            imageName: "wardrobe_navigation",
                            destination: WardrobeView()
                        )
                        NavigationButton(
                            imageName: "livingroom_navigation",
                            destination: LivingroomView()
                        )
                        NavigationButton(
                            imageName: "bedroom_navigation",
                            destination: BedroomView()
                        )
                        NavigationButton(
                            imageName: "bathroom_navigation",
                            destination: BathroomView()
                        )
                    }
                }
                
                if showEmoji {
                    EmojiOverlay(service: emojiService, emojiType: "😢")
                }
            }
            .onAppear {
                tryShowEmomj()
            }
            .navigationBarBackButtonHidden(true)
            .background(
                BackgroundImage(imageName: "main_background_\(worldType)")
            )
        }
    }
    
    private func tryShowEmomj() {
        showEmoji = false
        if tamagotchiService.needs["food"] == 0
            && tamagotchiService.needs["care"] == 0
            && tamagotchiService.needs["energy"] == 0
            && tamagotchiService.needs["happiness"] == 0 {
            showEmoji = true
            emojiService.startLongEmojiRain(in: UIScreen.main.bounds.size)
        }
    }
}

#Preview {
    MainView()
}
