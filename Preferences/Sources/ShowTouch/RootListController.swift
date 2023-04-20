import Preferences
import ShowTouchC
import SwiftUI

class RootListController: UIViewController {
    let vc = UIHostingController(rootView: RootView())

    override func viewDidLoad() {
        super.viewDidLoad()

        addChild(vc)

        view.addSubview(vc.view)
        vc.didMove(toParent: self)

        vc.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            vc.view.leftAnchor.constraint(equalTo: view.leftAnchor),
            vc.view.rightAnchor.constraint(equalTo: view.rightAnchor),
            vc.view.topAnchor.constraint(equalTo: view.topAnchor),
            vc.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        title = Constant.tweakName

        navigationItem.largeTitleDisplayMode = .always
    }
}

extension RootListController {
    @objc func setRootController(_ controller: UIViewController?) { }
    @objc func setParentController(_ controller: UIViewController?) { }
    @objc func setSpecifier(_ specifier: AnyObject?) { }
}
