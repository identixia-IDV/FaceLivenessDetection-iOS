import UIKit
import FaceLivenessKit


class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?


    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }
        let window = UIWindow(windowScene: windowScene)
        window.backgroundColor = IXColor.bg
        let nav = UINavigationController(rootViewController: ViewController())
        nav.view.backgroundColor = IXColor.bg
        window.rootViewController = nav
        window.tintColor = IXColor.accent
        window.overrideUserInterfaceStyle = .dark
        window.makeKeyAndVisible()
        self.window = window
    }
}


/// Identixia workbench palette (cool paper + teal).
enum IXColor {
    static let bg = UIColor(rgb: 0xE6E9EF)
    static let text = UIColor(rgb: 0x141A22)
    static let muted = UIColor(rgb: 0x5A6573)
    static let accent = UIColor(rgb: 0x0F766E)
    static let accentDim = UIColor(rgb: 0x0B4F4A)
    static let purple = UIColor(rgb: 0x0F766E)
    static let pinkTouch = UIColor(rgb: 0x0B4F4A)
    static let surface = UIColor(rgb: 0xF7F8FA)
    static let surfaceAlt = UIColor(rgb: 0xDFE4EC)
    static let stroke = UIColor(rgb: 0xC5CCD8)
    static let statusInfo = UIColor(rgb: 0x0B4F4A)
    static let statusOk = UIColor(rgb: 0x0F766E)
    static let statusError = UIColor(rgb: 0xB91C1C)
    static let danger = UIColor(rgb: 0xB91C1C)
    static let overlay = UIColor(rgb: 0xE6E9EF).withAlphaComponent(0.88)
    static let captureScrimStart = UIColor(rgb: 0x141A22).withAlphaComponent(0.55)
    static let captureScrimEnd = UIColor.black
    static let captureTertiary = UIColor(rgb: 0x5EEAD4)
    static let livenessReal = UIColor(rgb: 0x0F766E)
    static let livenessSpoof = UIColor(rgb: 0xB91C1C)
    static let livenessNeutral = UIColor(rgb: 0x141A22)
}


extension UIColor {
    convenience init(rgb: UInt32, alpha: CGFloat = 1) {
        self.init(
            red: CGFloat((rgb >> 16) & 0xFF) / 255,
            green: CGFloat((rgb >> 8) & 0xFF) / 255,
            blue: CGFloat(rgb & 0xFF) / 255,
            alpha: alpha
        )
    }
}


extension UIView {
    /// Android `bg_card.xml` — 16dp radius + 1dp stroke.
    func applyAndroidCardStyle(cornerRadius: CGFloat = 16) {
        backgroundColor = IXColor.surface
        layer.cornerRadius = cornerRadius
        layer.borderWidth = 1
        layer.borderColor = IXColor.stroke.cgColor
        clipsToBounds = true
    }
}


/// Shared nav bar so every pushed screen shows a labeled Back control.
enum ScreenChrome {
    static func showInnerBar(on viewController: UIViewController) {
        guard let navigationController = viewController.navigationController else { return }
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = IXColor.bg
        appearance.shadowColor = .clear
        appearance.titleTextAttributes = [
            .foregroundColor: IXColor.text,
            .font: UIFont.systemFont(ofSize: 17, weight: .semibold),
        ]
        let button = UIBarButtonItemAppearance()
        button.normal.titleTextAttributes = [.foregroundColor: IXColor.accent]
        appearance.buttonAppearance = button
        appearance.backButtonAppearance = button
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
        navigationController.navigationBar.tintColor = IXColor.accent
        navigationController.navigationBar.barStyle = .black
        viewController.navigationItem.largeTitleDisplayMode = .never
        navigationController.setNavigationBarHidden(false, animated: false)
    }
}
