import SwiftUI

struct LivingroomView: View {
    @ObservedObject var tamagotchiService = TamagotchiService.shared
    @State private var unicornState: String = "normal"
    @State private var isTalk = false
    @State private var isWatch = false
    
    private let worldType = OnboardingService.shared.getWorlsType()
    
    var body: some View {
        VStack {
            HStack {
                MoneyCounter()
                Spacer()
                NeedsBar()
            }
            
            Spacer()
            UnicornView(unicornState: $unicornState)
            
            HStack {
                BackButton()
                
                MainButton(imageName:"phone_button") {
                    isTalk.toggle()
                    
                    if isTalk {
                        tamagotchiService.startAutoIncrease(for: "happiness")
                        unicornState = "phone"
                    } else {
                        tamagotchiService.stopAutoIncrease(for: "happiness")
                        unicornState = "normal" 
                    }
                }
                
                MainButton(imageName:"TV_button") {
                    isWatch.toggle()
                    
                    if isWatch {
                        tamagotchiService.startAutoIncrease(for: "happiness")
                        unicornState = "tv"
                    } else {
                        tamagotchiService.stopAutoIncrease(for: "happiness")
                        unicornState = "normal"
                    }
                }
            }
        }
        .background(
            BackgroundImage(imageName: "livingroom_background_\(worldType)")
        )
        .navigationBarBackButtonHidden(true)
        .onDisappear {
            if isTalk {
                tamagotchiService.stopAutoIncrease(for: "happiness")
                isTalk = false
                unicornState = "normal"
            }
        }
        .onDisappear {
            if isWatch{
                tamagotchiService.stopAutoIncrease(for: "happiness")
                isWatch = false
                unicornState = "normal"
            }
        }
    }
}

#Preview {
    LivingroomView()
}
