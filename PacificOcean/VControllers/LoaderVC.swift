//
//  LoaderVC.swift
//  PacificOcaen
//
//  Created by Vlad Lesnichiy on 19.08.25.
//

import UIKit

class LoaderVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let loader = OverlappingSmoothGradientLoaderView(frame: CGRect(x: 50, y: 100, width: 150, height: 150))
        view.addSubview(loader)    }
}

class OverlappingSmoothGradientLoaderView: UIView {

    private let replicatorLayer = CAReplicatorLayer()
    private let shapeLayer = CAShapeLayer()
    private let gradientLayer = CAGradientLayer()

    private let colorsSets: [[CGColor]] = [
        [UIColor.red.cgColor, UIColor.orange.cgColor],
        [UIColor.orange.cgColor, UIColor.yellow.cgColor],
        [UIColor.yellow.cgColor, UIColor.red.cgColor]
    ]

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayers()
        startAnimations()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLayers()
        startAnimations()
    }

    private func setupLayers() {
        replicatorLayer.frame = bounds
        replicatorLayer.instanceCount = colorsSets.count
        replicatorLayer.instanceDelay = 0.4

        // Равномерный поворот каждой копии по кругу
        let angle = (2 * CGFloat.pi) / CGFloat(colorsSets.count)
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1)

        // Смещение прозрачности копий (делаем кажду копию прозрачнее)
        replicatorLayer.instanceAlphaOffset = -0.15

        layer.addSublayer(replicatorLayer)

        shapeLayer.fillColor = UIColor.black.cgColor // Маска для градиента
        shapeLayer.strokeColor = UIColor.white.withAlphaComponent(0.4).cgColor // Прозрачные границы
        shapeLayer.lineWidth = 2
        replicatorLayer.addSublayer(shapeLayer)

        gradientLayer.frame = bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.colors = colorsSets.first
        layer.addSublayer(gradientLayer)

        gradientLayer.mask = shapeLayer
    }

    private func smoothWavePath(progress: CGFloat) -> CGPath {
        let radius = bounds.height / 2 - 3
        let center = CGPoint(x: radius + 3, y: radius + 3)

        let waveCount = 6
        let waveAmplitude: CGFloat = 6
        let path = UIBezierPath()

        for i in 0...waveCount {
            let angle = (CGFloat(i) / CGFloat(waveCount)) * 2 * CGFloat.pi
            let nextAngle = (CGFloat(i + 1) / CGFloat(waveCount)) * 2 * CGFloat.pi
            let waveRadius = radius + sin(progress * 2 * .pi + angle * 4) * waveAmplitude
            let nextWaveRadius = radius + sin(progress * 2 * .pi + nextAngle * 4) * waveAmplitude

            let point = CGPoint(x: center.x + cos(angle) * waveRadius,
                                y: center.y + sin(angle) * waveRadius)
            let nextPoint = CGPoint(x: center.x + cos(nextAngle) * nextWaveRadius,
                                    y: center.y + sin(nextAngle) * nextWaveRadius)

            if i == 0 {
                path.move(to: point)
            }

            let midAngle = (angle + nextAngle) / 2
            let midRadius = radius + sin(progress * 2 * .pi + midAngle * 4) * waveAmplitude
            let controlPoint = CGPoint(x: center.x + cos(midAngle) * midRadius,
                                       y: center.y + sin(midAngle) * midRadius)

            path.addQuadCurve(to: nextPoint, controlPoint: controlPoint)
        }

        path.close()
        return path.cgPath
    }

    private func startAnimations() {
        let pathAnimation = CAKeyframeAnimation(keyPath: "path")
        pathAnimation.values = (0...40).map { i -> CGPath in
            smoothWavePath(progress: CGFloat(i) / 40.0)
        }
        pathAnimation.duration = 2.5
        pathAnimation.repeatCount = .infinity
        shapeLayer.add(pathAnimation, forKey: "smoothWavePathAnimation")

        let colorChangeAnim = CAKeyframeAnimation(keyPath: "colors")
        colorChangeAnim.values = colorsSets
        colorChangeAnim.duration = Double(colorsSets.count) * 0.7
        colorChangeAnim.calculationMode = .discrete
        colorChangeAnim.repeatCount = .infinity
        gradientLayer.add(colorChangeAnim, forKey: "colorChangeAnimation")

        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 0.4
        opacityAnimation.toValue = 1.0
        opacityAnimation.duration = 1.2
        opacityAnimation.repeatCount = .infinity
        opacityAnimation.autoreverses = true
        shapeLayer.add(opacityAnimation, forKey: "opacityAnimation")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        replicatorLayer.frame = bounds
        gradientLayer.frame = bounds
    }
}
