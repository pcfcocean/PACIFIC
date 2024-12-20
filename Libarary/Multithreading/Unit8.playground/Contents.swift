import UIKit
import PlaygroundSupport


// MARK: - Multithreading в swift с нуля: урок 8 - GCD Практика + Bonus, Sync-Async
// https://www.youtube.com/watch?v=pO2yEy57L1g

class Unit8ViewController: UIViewController {
    var button = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "vc 1"
        view.backgroundColor = .white
        button.addTarget(self, action: #selector(pressAction), for: .touchUpInside)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initButton()
    }

    func initButton() {
        button.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        button.center = view.center
        button.setTitle("Press", for: .normal)
        button.backgroundColor = .green
        button.layer.cornerRadius = 10
        button.setTitleColor(.white, for: .normal)
        view.addSubview(button)
    }

    @objc private func pressAction() {
        let vc2 = Unit8ViewController2()
        navigationController?.pushViewController(vc2, animated: true)
    }
}

class Unit8ViewController2: UIViewController {
    var image = UIImageView()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "vc 2"
        view.backgroundColor = .white

//        let imageURL: URL = URL(string: "https://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg")!
//        if let data: Data = try? Data(contentsOf: imageURL) {
//            self.image.image = UIImage(data: data)
//        }
        loadFoto()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        initImage()
    }

    private func initImage() {
        image.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
        image.center = view.center
        view.addSubview(image)
    }

    func loadFoto() {
        let imageURL: URL = URL(string: "https://www.planetware.com/photos-large/F/france-paris-eiffel-tower.jpg")!
        let queue = DispatchQueue.global(qos: .utility)
        queue.async {
            if let data: Data = try? Data(contentsOf: imageURL) {
                DispatchQueue.main.async {
                    self.image.image = UIImage(data: data)
                }
            }
        }
    }
}

let unit8VC = Unit8ViewController()
let navigationController = UINavigationController(rootViewController: unit8VC)

PlaygroundPage.current.liveView = navigationController
