import SwiftUI

struct BathroomView: View{
    @ObservedObject var tamagotchiService = TamagotchiService.shared
    @State private var unicornState: String = "normal"
    @State private var isLeftMenuVisible = false
    @State private var isRightMenuVisible = false
    
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
                    ZStack {
                        MenuRectangle()
                        
                        HStack {
                            ZStack {
                                MenuCircle()
                                MenuDragItem(imageName: "beauty1_\(worldType)") {
                                    tamagotchiService.increaseNeed(for: "care")
                                    tamagotchiService.increaseCoins(by: 10)
                                    tryShowEmomj()
                                }
                            }
                            ZStack {
                                MenuCircle()
                                MenuDragItem(imageName: "beauty2_\(worldType)") {
                                    tamagotchiService.increaseNeed(for: "care")
                                    tamagotchiService.increaseCoins(by: 10)
                                    tryShowEmomj()
                                }
                            }
                            ZStack {
                                MenuCircle()
                                MenuDragItem(imageName: "beauty3_\(worldType)") {
                                    tamagotchiService.increaseNeed(for: "care")
                                    tamagotchiService.increaseCoins(by: 10)
                                    tryShowEmomj()
                                }
                            }
                            ZStack {
                                MenuCircle()
                                MenuDragItem(imageName: "beauty4_\(worldType)") {
                                    tamagotchiService.increaseNeed(for: "care")
                                    tamagotchiService.increaseCoins(by: 10)
                                    tryShowEmomj()
                                }
                            }
                            
                        }
                    }
                    .opacity(isLeftMenuVisible ? 1.0 : 0.0)
                    .animation(.easeInOut(duration: 0.3), value: isLeftMenuVisible)
                    
                    ZStack {
                        MenuRectangle()
                        
                        HStack {
                            ZStack {
                                MenuCircle()
                                MenuDragItem(imageName: "grooming1_\(worldType)") {
                                    tamagotchiService.increaseNeed(for: "care")
                                    tamagotchiService.increaseCoins(by: 10)
                                    tryShowEmomj()
                                }
                            }
                            ZStack {
                                MenuCircle()
                                MenuDragItem(imageName: "grooming2_\(worldType)") {
                                    tamagotchiService.increaseNeed(for: "care")
                                    tamagotchiService.increaseCoins(by: 10)
                                    tryShowEmomj()
                                }
                            }
                            ZStack {
                                MenuCircle()
                                MenuDragItem(imageName: "grooming3_\(worldType)") {
                                    tamagotchiService.increaseNeed(for: "care")
                                    tamagotchiService.increaseCoins(by: 10)
                                    tryShowEmomj()
                                }
                            }
                            ZStack {
                                MenuCircle()
                                MenuDragItem(imageName: "grooming4_\(worldType)") {
                                    tamagotchiService.increaseNeed(for: "care")
                                    tamagotchiService.increaseCoins(by: 10)
                                    tryShowEmomj()
                                }
                            }
                            
                        }
                    }
                    .opacity(isRightMenuVisible ? 1.0 : 0.0)
                    .animation(.easeInOut(duration: 0.3), value: isRightMenuVisible)
                }
                
                HStack {
                    BackButton()
                    MainButton(imageName:"beauty_button") {
                        isLeftMenuVisible.toggle()
                        isRightMenuVisible = false
                    }
                    MainButton(imageName:"grooming_button") {
                        isRightMenuVisible.toggle()
                        isLeftMenuVisible = false
                    }
                }
            }
            
            if showEmoji {
                EmojiOverlay(service: emojiService, emojiType: "✨")
            }
        }
        .background(
            BackgroundImage(imageName: "bathroom_background_\(worldType)")
        )
        .navigationBarBackButtonHidden(true)
    }
    
    private func tryShowEmomj() {
        showEmoji = false
        if tamagotchiService.needs["care"] == 4 {
            showEmoji = true
            emojiService.startEmojiRain(in: UIScreen.main.bounds.size)
        }
    }
}

#Preview {
    BathroomView()
}
