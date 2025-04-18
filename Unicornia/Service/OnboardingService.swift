import Foundation

class OnboardingService: ObservableObject {
    static let shared = OnboardingService()
    private var userDefaults = UserDefaults.standard
    
    func saveUnicornType(unicornType: Int) {
        userDefaults.setValue(unicornType, forKey: "unicornType")
    }
    
    func getUnicornType() -> Int {
        userDefaults.integer(forKey: "unicornType")
    }
    
    func saveWorldType(worldType: Int) {
        userDefaults.setValue(worldType, forKey: "worldType")
    }
    
    func getWorlsType() -> Int {
        userDefaults.integer(forKey: "worldType")
    }
}
