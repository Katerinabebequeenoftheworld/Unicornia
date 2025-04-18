import SwiftUI

class VibrationsService {
    static let shared = VibrationsService()
    
    //    .light – лёгкий удар
    //    .medium – средний удар
    //    .heavy – сильный удар
    //    .soft – мягкий удар
    //    .rigid – жёсткий удар
    func notificationFeedback(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(type)
    }
    
    //    .success – успех
    //    .warning – предупреждение
    //    .error – ошибка
    func impactFeedback(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.prepare()
        generator.impactOccurred()
    }
}
