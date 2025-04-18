import SwiftUI

struct OnboardingWorldView: View {
    @Environment(\.dismiss) var dismiss
    @State private var navigateToOnboardingUnicornScreen = false
    private let onboardingService = OnboardingService.shared
    
    var body: some View {
        VStack {
            Image("logo")
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 150)
            
            HStack {
                Image("star")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
                
                Text("Выберите мир")
                    .font(.title2.bold())
                    .foregroundColor(Color(hexString: "780083"))
                    .multilineTextAlignment(.center)
                
                Image("star")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }
            .padding(.bottom, 40)
            
            VStack(spacing: 10) {
                Button(action: {
                    onboardingService.saveWorldType(worldType: 1)
                    navigateToOnboardingUnicornScreen = true
                }) {
                    Image("main_background_1")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 250, height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white, lineWidth: 3)
                        )
                }
                
                Text("Романтичные горы")
                    .font(.headline)
                    .foregroundColor(Color(hexString: "780083"))
            }
            .padding(.bottom, 20)
            
            VStack(spacing: 10) {
                Button(action: {
                    onboardingService.saveWorldType(worldType: 2)
                    navigateToOnboardingUnicornScreen = true
                }) {
                    Image("main_background_2")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 250, height: 150)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color.white, lineWidth: 3)
                        )
                }
                
                Text("Загадочный лес")
                    .font(.headline)
                    .foregroundColor(Color(hexString: "780083"))
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hexString: "FFE3FF"))
        .navigationBarBackButtonHidden(true)
        .background(
            NavigationLink(destination: OnboardingUnicornView(), isActive: $navigateToOnboardingUnicornScreen) {
                EmptyView()
            }
            .hidden()
        )
    }
}

#Preview {
    OnboardingWorldView()
}
