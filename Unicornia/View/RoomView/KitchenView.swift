import SwiftUI

struct KitchenView: View {
    @ObservedObject var tamagotchiService = TamagotchiService.shared // подключение сервиса логики жизнидеятельности
    @State private var isMenuVisible = false
    @State private var unicornState: String = "normal"
    
    @StateObject private var emojiService = EmojiService()
    @State private var showEmoji = false
    
    private let worldType = OnboardingService.shared.getWorlsType()
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    MoneyCounter()
                    Spacer()
                    NeedsBar()
                }
                
                Spacer()
                
                UnicornView(unicornState: $unicornState)
                
                ZStack {
                    MenuRectangle()
                    
                    HStack {
                        ZStack {
                            MenuCircle()
                            MenuDragItem(imageName: "food1_\(worldType)") {
                                tamagotchiService.increaseNeed(for: "food") // пополнение нужды food
                                tamagotchiService.increaseCoins(by: 10) // пополнение монет на 10
                                tryShowEmomj()
                            }
                        }
                        ZStack {
                            MenuCircle()
                            MenuDragItem(imageName: "food2_\(worldType)") {
                                tamagotchiService.increaseNeed(for: "food")
                                tamagotchiService.increaseCoins(by: 50)
                                tryShowEmomj()
                            }
                        }
                        ZStack {
                            MenuCircle()
                            MenuDragItem(imageName: "food3_\(worldType)") {
                                tamagotchiService.increaseNeed(for: "food")
                                tamagotchiService.increaseCoins(by: 15)
                                tryShowEmomj()
                            }
                        }
                        ZStack {
                            MenuCircle()
                            MenuDragItem(imageName: "food4_\(worldType)") {
                                tamagotchiService.increaseNeed(for: "food")
                                tamagotchiService.increaseCoins(by: 5)
                                tryShowEmomj()
                            }
                        }
                    }
                }
                .opacity(isMenuVisible ? 1 : 0.0)
                .animation(.easeInOut(duration: 0.5), value: isMenuVisible)
                
                HStack {
                    BackButton()
                    MainButton(imageName:"hungry_button") {
                        isMenuVisible.toggle()
                    }
                }
                .padding(.trailing, 100)
            }
            
            if showEmoji {
                EmojiOverlay(service: emojiService, emojiType: "❤️")
            }
        }
        .background(
            BackgroundImage(imageName: "kitchen_background_\(worldType)")
        )
        .navigationBarBackButtonHidden(true)
    }
    
    private func tryShowEmomj() {
        showEmoji = false
        if tamagotchiService.needs["food"] == 4 {
            showEmoji = true
            emojiService.startEmojiRain(in: UIScreen.main.bounds.size)
        }
    }
}

#Preview {
    KitchenView()
}
