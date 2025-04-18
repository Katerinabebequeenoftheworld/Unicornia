import SwiftUI

struct WardrobeMenuItem: View {
    let imageName: String
    let isChoosen: Bool
    let isPurchased: Bool
    
    var body: some View {
        ZStack {
            MenuCircle()
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .cornerRadius(10)
                .shadow(radius: 5)
            
            if isChoosen == false {
                Color.black.opacity(0.5)
                    .frame(width: 60, height: 60)
                    .cornerRadius(30)
            }
            
            if isPurchased == false {
                Image(systemName: "lock.fill")
                    .foregroundColor(.white)
                    .font(.system(size: 24))
            }
        }
    }
}
