import UIKit
import Lottie
import SnapKit

protocol Animatable: AnyObject {
    func playDefault(animation: AppAnimation?)
    func performInteraction(with animation: AppAnimation?)
}

final class AnimatableView: UIView {
    
    enum Constant {
        static let delay: Double = 0.1
        static let cycleStartProgress: CGFloat = 0.5
    }
    
    
    private var animatableContainer = UIView()

    private let containerBuilder = { (animation: AppAnimation) -> UIView in
        let view: UIView
        if case .image(let image) = animation {
            view = UIImageView(image: image)
        } else {
            view = LottieAnimationView(name: animation.filename)
        }
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
    
    private let animation: AppAnimation
    
    init(animation: AppAnimation) {
        self.animation = animation
        super.init(frame: CGRect.zero)
        
        configureContainer()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContainer() {
        if case .image(let image) = animation {
            animatableContainer = UIImageView(image: image)
            let imageSize = getImageSize(image: image, container: animatableContainer)
            setupContainerConstraints(height: imageSize.height, width: imageSize.width)
        } else {
            animatableContainer = LottieAnimationView(name: animation.filename)
            let imageSize = getImageSize(image: nil, container: animatableContainer)
            setupContainerConstraints(height: imageSize.height, width: imageSize.width)
        }
        animatableContainer.backgroundColor = .clear
        animatableContainer.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func getImageSize(image: UIImage?, container: UIView) -> CGSize {
        guard let image = image else {
            return container.intrinsicContentSize
        }
        let ratio = image.size.width / image.size.height
        let height = animatableContainer.frame.width / ratio
        return CGSize(width: image.size.width, height: height)
    }
    
    func setupContainerConstraints(height: CGFloat, width: CGFloat) {
        addSubview(animatableContainer)
        
        self.snp.makeConstraints {
            $0.height.equalTo(height).priority(270)
        }
        animatableContainer.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(width)
            $0.centerX.equalToSuperview()
        }
        
        backgroundColor = .clear
        let tap = UITapGestureRecognizer(target: self, action: #selector(didTap))
        animatableContainer.addGestureRecognizer(tap)
    }
    
    @objc private func didTap() {
        guard let lottieView = animatableContainer as? Animatable else { return }
        lottieView.performInteraction(with: animation)
    }
}

extension AnimatableView {
    func playDefault() {
        guard let lottieView = animatableContainer as? Animatable else { return }
        lottieView.playDefault(animation: animation)
    }
}
