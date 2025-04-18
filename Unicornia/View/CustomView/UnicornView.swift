import SwiftUI

struct UnicornView: View {
    @ObservedObject var wardrobeService = WardrobeService.shared
    @Binding var unicornState: String
    private let onboardingService = OnboardingService.shared
    
    var body: some View {
        ZStack {
            // Изображение единорога
            Image("unicorn_\(onboardingService.getUnicornType())_\(unicornState)")
                .resizable()
                .scaledToFill()
                .frame(width: 300, height: 300)
            
            // Изображение аксессуара в разных состояниях в координатах x y
            if unicornState == "sleep" {
                Image(wardrobeService.itemName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 80, height: 80)
                    .scaleEffect(x: -1)
                    .offset(x: 0)
                    .offset(y: -100)
            } else if unicornState == "phone" {
                Image(wardrobeService.itemName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .offset(x: -50)
                    .offset(y: -90)
            } else if unicornState == "tv" {
                Image(wardrobeService.itemName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .offset(x: 30)
                    .offset(y: -30)
            } else {
                Image(wardrobeService.itemName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130, height: 130)
                    .offset(x: -50)
                    .offset(y: -130)
            }
        }
    }
}
