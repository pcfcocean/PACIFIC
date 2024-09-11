import UIKit
import Lottie

enum AppAnimation {
    
    enum Behavior {
        /// По умолчанию не анимируется
        case none
        /// Отыгрывает анимацию один раз
        case run
        /// Отыгрывает половину и зацикливается на второй половине
        case runAndCycle
        /// Cycle animation
        case cycle
    }
    
    enum InteractionBehavior {
        case none
        /// Повторить анимацию
        case `repeat`
        /// Откатиться на начало со скоростью x2 и повторить анимацию
        case reverseAndRepeat
    }

    case manWithCloak
    case womanWithFlag
    case manWithQuestions
    case womanWithPhone
    case womanWithNews
    case manWithFiles
    case onboarding(step: Int)
    case searchLoader
    
    // просто картинка (для возможности переключения и обратной соместимости)
    case image(_ image: UIImage?)
    
    /// Lottie .json resource filename
    var filename: String {
        switch self {
        case .manWithCloak:
            return "manWithCloak"
        case .womanWithFlag:
            return "womanWithFlag"
        case .manWithQuestions:
            return "manWithQuestions"
        case .womanWithPhone:
            return "womanWithPhone"
        case .womanWithNews:
            return "womanWithNews"
        case .manWithFiles:
            return "manWithFiles"
        case .onboarding(let step):
            return "onboarding_step_\(step)"
        case .searchLoader:
            return "searchLoader"
        case .image:
            return ""
        }
    }
    
    var behavior: Behavior {
        switch self {
        case .searchLoader:
            return .cycle
        case .manWithCloak, .womanWithFlag:
            return .runAndCycle
        case .manWithQuestions, .manWithFiles, .womanWithNews, .womanWithPhone, .onboarding:
            return .run
        case .image:
            return .none
        }
    }
    
    var interactionBehavior: InteractionBehavior {
        switch self {
        case .manWithCloak, .womanWithFlag, .manWithQuestions,
             .manWithFiles, .womanWithNews, .womanWithPhone:
            return .reverseAndRepeat
        case .onboarding, .searchLoader:
            return .repeat
            
        case .image:
            return .none
        }
    }
    
    var isBackgroundNeeded: Bool {
        switch self {
        case .image:
            return true
        default:
            return false
        }
    }
}
