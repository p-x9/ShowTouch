import CCToggleC

@objcMembers
class CCToggle: CCUIToggleModule {

    let preference = Preferences(path: Constant.preferencePlistPath)

    // Return the icon of your module here
    override var iconGlyph: UIImage {
        .init(systemName: "hand.tap")!
    }

    //Return the color selection color of your module here
    override var selectedColor: UIColor {
        .black
    }

    override var isSelected: Bool {
        get {
            preference.isEnabled
        }
        set {
            preference.isEnabled = newValue
        }
    }
}
