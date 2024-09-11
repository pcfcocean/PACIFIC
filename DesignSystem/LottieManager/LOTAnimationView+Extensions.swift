import UIKit
import Lottie

extension LottieAnimationView: Animatable {

    func playDefault(animation: AppAnimation?) {
        guard let animation = animation else {
            return
        }
        
        switch animation.behavior {
        case .none:
            return
            
        case .runAndCycle, .run, .cycle:
            DispatchQueue.main.asyncAfter(deadline: .now() + AnimatableView.Constant.delay) { [weak self] in
                switch animation.behavior {
                case .none:
                    return
                case .run:
                    self?.loopMode = .playOnce
                    self?.play()
                    
                case .runAndCycle:
                    self?.loopMode = .playOnce
                    self?.play(fromProgress: 0, toProgress: 1) { [weak self] _ in
                        self?.loopMode = .loop
                        self?.play(fromProgress: 0, toProgress: 1)
                    }
                case .cycle:
                    self?.loopMode = .loop
                    self?.play()
                }
            }
        }
    }
    
    func performInteraction(with animation: AppAnimation?) {
        guard let animation = animation else {
            return
        }
        didTap(with: animation)
    }
    
    func didTap(with animation: AppAnimation?) {
        guard let animation = animation else {
            return
        }
        
        switch animation.interactionBehavior {
        case .none:
            return
            
        case .repeat:
            if isAnimationPlaying && loopMode == .loop {
                stop()
            }
            playDefault(animation: animation)
            
        case .reverseAndRepeat:
            if isAnimationPlaying && loopMode == .loop {
                stop()
            }
            loopMode = .playOnce
            animationSpeed = 2
            play(fromProgress: AnimatableView.Constant.cycleStartProgress, toProgress: 0) { [weak self] _ in
                self?.animationSpeed = 1
                self?.playDefault(animation: animation)
            }
        }
    }
}
