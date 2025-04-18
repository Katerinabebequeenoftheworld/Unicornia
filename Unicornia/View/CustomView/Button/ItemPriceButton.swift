import SwiftUI

struct ItemPriceButton: View {
    @ObservedObject var wardrobeService = WardrobeService.shared
    @ObservedObject var tamagotchiService = TamagotchiService.shared
    
    var body: some View {
        Button(action: {
            if tamagotchiService.coins >= wardrobeService.getItemPrice() {
                wardrobeService.setItemPurchasedStatus()
                tamagotchiService.decreaseCoint(by: wardrobeService.getItemPrice())
                VibrationsService.shared.notificationFeedback(type: .success)
            } else {
                VibrationsService.shared.notificationFeedback(type: .error)
            }
        }) {
            ZStack {
                ZStack {
                    Rectangle()
                        .fill(Color.black)
                        .opacity(0.4)
                        .cornerRadius(8)
                        .frame(width: 110, height: 36)
                    HStack(spacing: 0) {
                        Text("\(wardrobeService.getItemPrice())")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                            .foregroundColor(tamagotchiService.coins >= wardrobeService.getItemPrice() ? .white : .red)
                            .padding(.leading, 10)
                        Image("money")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 20, height: 20)
                    }
                    .padding(.trailing, -20)
                }
                
                ZStack {
                    Circle()
                        .fill(Color.init(hexString: "EE40D7"))
                        .frame(width: 40, height: 40)
                    Image(systemName: "lock.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                }
                .padding(.trailing, 80)
            }
            .padding()
        }
    }
}
