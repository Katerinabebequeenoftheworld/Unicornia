import SwiftUI

struct OnboardingStartView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 150)
                
                Spacer()
                
                Text("Добро пожаловать в мир Unicornia! Заботьтесь о своем питомце, играйте с ним и наблюдайте, как он растет и расцветает!")
                    .font(.title2.bold())
                    .foregroundColor(Color(hexString: "780083"))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                
                Spacer()
                
                NavigationLink(destination: OnboardingWorldView()) {
                    Text("Далее")
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
}

#Preview {
    OnboardingStartView()
}
