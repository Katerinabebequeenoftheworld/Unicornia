import SwiftUI

struct OnboardingUnicornView: View {
    @Environment(\.dismiss) var dismiss
    @State private var navigateToMainScreen = false
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
                
                Text("Выбери своего единорога!")
                    .font(.title2.bold())
                    .foregroundColor(Color(hexString: "780083"))
                    .multilineTextAlignment(.center)
                
                Image("star")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 20, height: 20)
            }
            
            Spacer()
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: -40), count: 2), spacing: 20) {
                ForEach(1...4, id: \.self) { index in
                    Button(action: {
                        onboardingService.saveUnicornType(unicornType: index)
                        navigateToMainScreen = true
                    }) {
                        Image("unicorn_\(index)_normal")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .padding()
                            .background(Color(hexString: "FCB2FF"))
                            .cornerRadius(16)
                            .shadow(radius: 5)
                    }
                    .background(
                        NavigationLink(destination: MainView(), isActive: $navigateToMainScreen) {
                            EmptyView()
                        }
                        .hidden()
                    )
                }
            }
            .padding()
            
            Spacer()
            
            Button(action: {
                dismiss()
            }) {
                Text("Назад")
                    .font(.title2.bold())
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(hexString: "FB84FF"))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding(.horizontal, 20)
            }
            .padding(.bottom, 40)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(hexString: "FFE3FF"))
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    OnboardingUnicornView()
}
