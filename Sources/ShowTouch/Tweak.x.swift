import Foundation
import Orion
import ShowTouchC
import SwiftUI

var localSettings: Configuration = .default

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

class TouchTrackView: TouchTrackingUIView {
    var displayLink: CADisplayLink?

    override init(
        radius: CGFloat = 20,
        color: UIColor = .red,
        offset: CGPoint = .zero,
        isBordered: Bool = false,
        borderColor: UIColor = .black,
        borderWidth: CGFloat = 1,
        isDropShadow: Bool = true,
        shadowColor: UIColor = .black,
        shadowRadius: CGFloat = 3,
        shadowOffset: CGPoint = .zero,
        image: UIImage? = nil,
        isShowLocation: Bool = false,
        displayMode: DisplayMode = .always
    ) {
        UIWindow.hooked = true
        UIWindow.hook2()

        super.init(
            radius: radius,
            color: color,
            offset: offset,
            isBordered: isBordered,
            borderColor: borderColor,
            borderWidth: borderWidth,
            isDropShadow: isDropShadow,
            shadowColor: shadowColor,
            shadowRadius: shadowRadius,
            shadowOffset: shadowOffset,
            image: image,
            isShowLocation: isShowLocation,
            displayMode: displayMode
        )

        displayLink = CADisplayLink(target: self, selector: #selector(update))
        displayLink?.add(to: .current, forMode: .common)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        displayLink?.invalidate()
        pointWindows.forEach {
            $0.isHidden = true
        }
    }

    override func updateLocations() {
        readSettings()
        super.updateLocations()
    }

    func readSettings() {
        isEnabled = localSettings.isEnabled
        radius = localSettings.radius
        color = UIColor(cgColor: .color(rgba: localSettings.color))
        offset = localSettings.offset
        isBordered = localSettings.isBordered
        borderColor = UIColor(cgColor: .color(rgba: localSettings.borderColor))
        borderWidth = localSettings.borderWidth
        isDropShadow = localSettings.isDropShadow
        shadowColor = UIColor(cgColor: .color(rgba: localSettings.shadowColor))
        shadowRadius = localSettings.shadowRadius
        shadowOffset = localSettings.shadowOffset
        isShowLocation = localSettings.isShowLocation
        displayMode = localSettings.displayMode
    }

    @objc
    func update() {
        self.updateLocations()
    }
}

extension UIWindow {
    func install() {
        let v = TouchTrackView(
            radius: localSettings.radius,
            color: UIColor(cgColor: .color(rgba: localSettings.color)),
            offset: localSettings.offset,
            isBordered: localSettings.isBordered,
            borderColor: UIColor(cgColor: .color(rgba: localSettings.borderColor)),
            borderWidth: localSettings.borderWidth,
            isDropShadow: localSettings.isDropShadow,
            shadowColor: UIColor(cgColor: .color(rgba: localSettings.shadowColor)),
            shadowRadius: localSettings.shadowRadius,
            shadowOffset: localSettings.shadowOffset,
            isShowLocation: localSettings.isShowLocation,
            displayMode: localSettings.displayMode
        )
        v.shouldPropagateEventAcrossWindows = true
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

    static public var hooked2 = false

    static func hook2() {
        if Self.hooked2 { return }
        Self.swizzle(orig: #selector(sendEvent(_:)), hooked: #selector(hooked_sendEvent2(_:)))
        Self.hooked2 = true
    }

    @objc
    func hooked_sendEvent2(_ event: UIEvent) {
        hooked_sendEvent2(event)

        guard case .touches = event.type,
              let touches = event.allTouches else {
            return
        }

        let began = touches.filter { $0.phase == .began }
        let moved = touches.filter { $0.phase == .moved }
        let ended = touches.filter { $0.phase == .cancelled || $0.phase == .ended }

        let touchLocationViews: [any TouchTrackable] = find(for: TouchLocationCocoaView.self) + find(for: TouchTrackingUIView.self)

        touchLocationViews
            .filter {
                if let superview = $0.superview {
                    return !superview.isHidden
                }
                return true
            }
            .forEach { view in
                if !began.isEmpty {
                    view.touchesBegan(began, with: self)
                }
                if !moved.isEmpty {
                    view.touchesMoved(moved, with: self)
                }
                if !ended.isEmpty {
                    view.touchesEndedOrCancelled(ended, with: self)
                }
            }
    }
}

func readPrefs() {
    let path = "/var/mobile/Library/Preferences/com.p-x9.showtouch.pref.plist"
    let url = URL(fileURLWithPath: path)

    // Reading values
    guard let data = try? Data(contentsOf: url) else {
        return
    }
    let decoder = PropertyListDecoder()
    localSettings =  (try? decoder.decode(Configuration.self, from: data)) ?? .default
}

func settingChanged() {
    readPrefs()
}

func observePrefsChange() {
    let NOTIFY = "com.p-x9.showtouch.prefschanged" as CFString

    CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
                                    nil, { _, _, _, _, _ in
        settingChanged()
    }, NOTIFY, nil, CFNotificationSuspensionBehavior.deliverImmediately)
}

struct ShowTouch: Tweak {
    init() {
        readPrefs()
        observePrefsChange()
        tweak().activate()
    }
}
