import Foundation
import SwiftUI

struct WardrobeView: View {
    @ObservedObject var wardrobeService = WardrobeService.shared
    @State private var unicornState: String = "normal"
    @State private var isMenuVisible = false
    
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
            
            VStack {
                if isMenuVisible {
                    HStack {
                        ArrowButton(imageName: "left_arrow") {
                            wardrobeService.setPreviousItem()
                        }
                        
                        Spacer()
                        // Отображение кнопки "купить" если элемент не куплен
                        if wardrobeService.purchasedItemStatus == false {
                            ItemPriceButton()
                            Spacer()
                        }
                        
                        ArrowButton(imageName: "right_arrow") {
                            wardrobeService.setNextItem()
                        }
                    }
                    .padding()
                    .transition(.move(edge: .bottom))
                }
                
                ZStack {
                    WardrobeMenu()
                    
                    HStack {
                        // Составление циклического меню
                        ForEach(0..<5) { index in
                            let item = wardrobeService.visibleItems[index]
                            let isChoosen = index == 2
                            WardrobeMenuItem(
                                imageName: item.imageName,
                                isChoosen: isChoosen,
                                isPurchased: isChoosen ? wardrobeService.purchasedItemStatus : item.isPurchased
                            )
                        }
                    }
                }
            }
            .opacity(isMenuVisible ? 1 : 0.0)
            .animation(.easeInOut(duration: 0.5), value: isMenuVisible)
            
            HStack {
                BackButton()
                MainButton(imageName:"wardrobe_button") {
                    wardrobeService.updateVisibleItems()
                    withAnimation(.easeInOut(duration: 0.5)) {
                        isMenuVisible.toggle()
                    }
                }
                .padding(.trailing, 100)
            }
        }
        .background(BackgroundImage(imageName: "wardrobe_background_\(worldType)"))
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    WardrobeView()
}
