import Lottie
import UIKit

struct AppAnimationManager {
    
    @discardableResult
    static func add(
        animation: AppAnimation,
        at root: UIView?
    ) -> UIView? {
        
        guard let root = root else { return nil }
        
        let view: AnimatableView = AnimatableView(animation: animation)
        view.translatesAutoresizingMaskIntoConstraints = false
        root.addSubview(view)
        
        if (root is UIStackView) == false {
            view.snp.makeConstraints { (maker) in
                maker.leading.trailing.top.bottom.equalTo(root)
            }
        }
        
        view.playDefault()
        
        return view
    }
}
