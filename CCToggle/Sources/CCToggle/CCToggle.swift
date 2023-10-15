import CCToggleC

@objcMembers
class CCToggle: CCUIToggleModule {

    let preference = Preferences(path: Constant.preferencePlistPath)

    // Return the icon of your module here
    override var iconGlyph: UIImage {
        let configuration = UIImage.SymbolConfiguration(pointSize: 24, weight: .bold)
        let icon = UIImage(systemName: "hand.tap", withConfiguration: configuration) ?? UIImage()
        return icon
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
