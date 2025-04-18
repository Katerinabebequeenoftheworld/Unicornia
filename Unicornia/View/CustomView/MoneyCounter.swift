import SwiftUI

struct MoneyCounter: View {
    @ObservedObject var tamagotchiService = TamagotchiService.shared
    
    var body: some View {
        ZStack {
            ZStack {
                Rectangle()
                    .fill(Color.init(hexString: "6C6C6C"))
                    .opacity(0.4)
                    .cornerRadius(8)
                    .frame(width: 80, height: 36)
                Text("\(tamagotchiService.coins)") // Получение значения монет из памяти телефона
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding(.leading, 10)
            }
            
            Image("money")
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .padding(.trailing, 80)
        }
        .padding()
    }
}
