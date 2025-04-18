import SwiftUI

@main
struct UnicorniaApp: App {
    @Environment(\.scenePhase) private var scenePhase
    private let onboardingService = OnboardingService.shared
    
    var body: some Scene {
        WindowGroup {
            // Если пользователь уже выбирал (заходит не впервые), то открываем главный экран
            if onboardingService.getUnicornType() != 0 {
                MainView()
                    .onChange(of: scenePhase) { _, newPhase in
                        if newPhase == .background {
                            TamagotchiService.shared.applicationDidEnterBackground()
                        }
                    }
            } else { // Иначе открываем экраны онбординга
                OnboardingStartView()
            }
        }
    }
}
