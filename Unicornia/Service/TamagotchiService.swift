import Foundation
import Combine

class TamagotchiService: ObservableObject {
    static let shared = TamagotchiService()
    
    @Published var coins: Int
    @Published var needs: [String: Int]
    
    private let decreaseInterval: TimeInterval = 60 // интервал автоуменьшения значений (секунд)
    private let increaseInterval: TimeInterval = 15 // интервал автовосполнения значений (секунд)
    private var timers: [String: Timer?] = [:]
    private var decreaseTimers: [String: Timer?] = [:]
        private var increaseTimers: [String: Timer?] = [:]
        private var activeIncreases: Set<String> = []
    private var backgroundTimeKey = "lastActiveTime"
    private let maxNeedValue = OneNeedBar.totalSegmentsCount
    private let minNeedValue = 0
    private var userDefaults = UserDefaults.standard
    
    private init() {
        self.coins = userDefaults.integer(forKey: "coins")
        self.needs = userDefaults.dictionary(forKey: "needs") as? [String: Int] ?? [
            "food": 0,
            "care": 0,
            "energy": 0,
            "happiness": 0
        ]
        restoreNeedsAfterBackground()
        startDecreaseTimers()
    }
    
    // Сохранение всех значений в память
    private func saveData() {
        userDefaults.setValue(coins, forKey: "coins")
        userDefaults.setValue(needs, forKey: "needs")
    }
    
    // Старт таймера уменьшения значений жизнидеястельности
    private func startDecreaseTimers() {
        for key in needs.keys {
            startDecreaseTimer(for: key)
        }
    }
    
    private func startDecreaseTimer(for key: String) {
        guard decreaseTimers[key] == nil else { return }
        decreaseTimers[key] = Timer.scheduledTimer(withTimeInterval: decreaseInterval, repeats: true) { [weak self] _ in
            self?.decreaseNeed(for: key)
        }
    }
    
    private func stopDecreaseTimer(for key: String) {
        decreaseTimers[key]??.invalidate()
        decreaseTimers[key] = nil
    }
    
    
    // Восстановление данных после закрытия приложения
    private func restoreNeedsAfterBackground() {
        if let lastActive = userDefaults.object(forKey: backgroundTimeKey) as? Date {
            let elapsed = Date().timeIntervalSince(lastActive)
            let lostPoints = Int(elapsed / decreaseInterval)
            
            for key in needs.keys {
                needs[key] = max(minNeedValue, (needs[key] ?? 0) - lostPoints)
            }
            saveData()
        }
    }
    
    // Уменьшение значений
    func decreaseNeed(for key: String) {
        if let current = needs[key], current > minNeedValue {
            needs[key] = current - 1
            saveData()
        }
    }
    
    // Увеличение значений
    func increaseNeed(for key: String) {
        if let current = needs[key], current < maxNeedValue {
            needs[key] = current + 1
            saveData()
        }
    }
    
    // Старт увеличения значений жизнидеястельности
    func startAutoIncrease(for key: String) {
        stopAutoIncrease(for: key)
        stopDecreaseTimer(for: key)
        activeIncreases.insert(key)
        
        increaseTimers[key] = Timer.scheduledTimer(withTimeInterval: increaseInterval, repeats: true) { [weak self] _ in
            if let self = self, let current = self.needs[key], current < self.maxNeedValue {
                self.needs[key] = current + 1
                self.saveData()
            } else {
                self?.stopAutoIncrease(for: key)
            }
        }
    }
    
    // Остановка увеличения значений жизнидеястельности
    func stopAutoIncrease(for key: String) {
        increaseTimers[key]??.invalidate()
        increaseTimers[key] = nil
        activeIncreases.remove(key)
        startDecreaseTimer(for: key)
    }
    
    // Увеличение монет
    func increaseCoins(by amount: Int) {
        coins += amount
        saveData()
    }
    
    // Уменьшение монет
    func decreaseCoint(by amount: Int) {
        coins -= amount
        saveData()
    }
    
    // Сохранение данных при выходе
    func applicationDidEnterBackground() {
        userDefaults.setValue(Date(), forKey: backgroundTimeKey)
    }
}

