import SwiftUI

struct BedroomView: View {
    @ObservedObject var tamagotchiService = TamagotchiService.shared
    @State private var isSleep = false
    @State private var unicornState: String = "normal"
    
    private let worldType = OnboardingService.shared.getWorlsType()
    
    var body: some View {
        ZStack{
            ZStack{
                UnicornView(unicornState: $unicornState)
                Rectangle()
                    .fill(Color.init(hexString: "000000"))
                    .opacity(isSleep ? 0.5 : 0)
                    .ignoresSafeArea()
                    .animation(.easeInOut(duration: 0.5), value: isSleep)
                
                VStack {
                    HStack {
                        MoneyCounter()
                        Spacer()
                        NeedsBar()
                    }
                    Spacer()
                    HStack {
                        BackButton()
                        MainButton(imageName:"sleep_button") {
                            isSleep.toggle()
                            
                            if isSleep {
                                tamagotchiService.startAutoIncrease(for: "energy") // Старт увеличения енергрии (начало сна)
                                unicornState = "sleep" // Изменение картинки единорога на сонное
                            } else {
                                tamagotchiService.stopAutoIncrease(for: "energy") // Прекращение увеличения енергрии (конец сна)
                                unicornState = "normal" // Изменение картинки единорога на обычное
                            }
                        }
                    }
                    .padding(.trailing, 100)
                }
            }
        }
        .background(
            BackgroundImage(imageName: "badroom_background_\(worldType)")
        )
        .navigationBarBackButtonHidden(true)
        .onDisappear { // Остановка сна при выходе с экрана на другие экраны
            if isSleep {
                tamagotchiService.stopAutoIncrease(for: "energy")
                isSleep = false
                unicornState = "normal"
            }
        }
    }
}

#Preview {
    BedroomView()
}
