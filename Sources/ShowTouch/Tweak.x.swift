import Foundation
import Orion
import ShowTouchC

struct tweak: HookGroup {}

class UIViewController_Hook: ClassHook<UIViewController> {
    typealias Group = tweak

    func viewDidLoad() {
        orig.viewDidLoad()

        if let window = target.view.window,
           window.find(for: TouchTrackingUIView.self).isEmpty {
            window.install()
        }
    }

    func viewDidAppear(_ animated: Bool) {
        orig.viewDidAppear(animated)

        if let window = target.view.window,
           window.find(for: TouchTrackingUIView.self).isEmpty {
            window.install()
        }
    }
}

extension UIWindow {
    func install() {
        let v = TouchTrackingUIView(
            radius: 30,
            color: .purple,
            offset: .init(x: 0, y: -10),
            isBordered: true,
            borderColor: .white,
            isDropShadow: true,
            shadowColor: .yellow,
            shadowRadius: 4,
            isShowLocation: true
        )
        v.isHidden = true

        let window = self
        window.insertSubview(v, at: 0)
        v.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            v.topAnchor.constraint(equalTo: window.topAnchor),
            v.bottomAnchor.constraint(equalTo: window.bottomAnchor),
            v.leftAnchor.constraint(equalTo: window.leftAnchor),
            v.rightAnchor.constraint(equalTo: window.rightAnchor),
        ])
    }
}


struct ShowTouch: Tweak {
    init() {
        tweak().activate()
    }
}
