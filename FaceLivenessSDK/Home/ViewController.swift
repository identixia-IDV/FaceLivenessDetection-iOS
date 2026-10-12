import UIKit
import FaceLivenessKit


/// Android `MainActivity` / `activity_main.xml` — logo, title, Liveness/Settings/About tiles, status.
final class ViewController: UIViewController {
    /// Paste Face Liveness key for bundle id `com.identixia.faceliveness.app` (product 741777).
    private let licenseKey =
        
        
        "pyyR2AECptG5lGOAzwv+bmiQPrFfO8G6EBX70b61E5BAVHgAAADH64PrYfamj7uclN6rIio4Rto8nEr9IxnxKPwAggo/2uSx+OuqqQgfpTY8c1tD5Hb6v+qrqDXZj2uCTdUYPOL49lJNhOGCUaGLljwUwE8rJ63KHfy2FsyJMqOaBVOYN7pGUok2AXs7+JDWIiD7iVx1oNy4f6ZKNzpnADBlAjAr3SfB6kxRYnomwEyewdMwwouFPQDy4ZwtA4Mz2/SpH5UDV53gmvC701HoARXtF7UCMQDYIUnm97uNLTD7X1Q445MiiIfCkns4lKuqu7DoGcLoPR6p2xZMozf2/CeWT7GJgXs="


    private let warningLabel = UILabel()
    private var sdkReady = false
    private var sdkActionButtons: [UIButton] = []


    override func viewDidLoad() {
        super.viewDidLoad()
        AppSettings.applyEngineDefaults()
        view.backgroundColor = IXColor.bg
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupUI()
        activateSDK()
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }


    private func setupUI() {
        // Android activity_main: wide Liveness (128) + Settings/About row (96).
        let logo = UIButton(type: .custom)
        logo.setImage(UIImage(named: "IdentixiaLogo")?.withRenderingMode(.alwaysOriginal), for: .normal)
        logo.imageView?.contentMode = .scaleAspectFit
        logo.contentHorizontalAlignment = .fill
        logo.contentVerticalAlignment = .fill
        logo.accessibilityLabel = "Identixia"
        logo.addTarget(self, action: #selector(openBrand), for: .touchUpInside)

        let titleLabel = UILabel()
        titleLabel.text = "Face Liveness"
        titleLabel.textColor = IXColor.text
        titleLabel.font = .systemFont(ofSize: 20, weight: .regular)
        titleLabel.textAlignment = .center

        let liveness = makePrimaryTile(title: "LIVENESS", assetName: "identify", action: #selector(openLiveness))
        let settings = makeTile(title: "SETTINGS", assetName: "settings", action: #selector(openSettings))
        let about = makeTile(title: "ABOUT", assetName: "information", action: #selector(openAbout))
        // Settings/About stay enabled; only Liveness needs SDK ready.
        sdkActionButtons = [liveness]
        setSdkActionsEnabled(false)
        settings.isEnabled = true
        settings.alpha = 1
        about.isEnabled = true
        about.alpha = 1

        let secondary = UIStackView(arrangedSubviews: [settings, about])
        secondary.axis = .horizontal
        secondary.spacing = 12
        secondary.distribution = .fillEqually

        warningLabel.text = "Starting SDK…"
        warningLabel.textColor = IXColor.text
        warningLabel.font = .systemFont(ofSize: 14, weight: .medium)
        warningLabel.textAlignment = .center
        warningLabel.backgroundColor = IXColor.statusInfo
        warningLabel.layer.cornerRadius = 8
        warningLabel.clipsToBounds = true
        warningLabel.numberOfLines = 2

        let content = UIStackView(arrangedSubviews: [logo, titleLabel, liveness, secondary])
        content.axis = .vertical
        content.alignment = .fill
        content.spacing = 16
        content.setCustomSpacing(28, after: titleLabel)
        content.setCustomSpacing(12, after: liveness)
        content.translatesAutoresizingMaskIntoConstraints = false

        let scroll = UIScrollView()
        scroll.alwaysBounceVertical = true
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.addSubview(content)
        warningLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scroll)
        view.addSubview(warningLabel)

        logo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            warningLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            warningLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            warningLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            warningLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 44),

            scroll.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroll.bottomAnchor.constraint(equalTo: warningLabel.topAnchor, constant: -12),

            content.topAnchor.constraint(equalTo: scroll.contentLayoutGuide.topAnchor, constant: 36),
            content.leadingAnchor.constraint(equalTo: scroll.contentLayoutGuide.leadingAnchor, constant: 16),
            content.trailingAnchor.constraint(equalTo: scroll.contentLayoutGuide.trailingAnchor, constant: -16),
            content.bottomAnchor.constraint(equalTo: scroll.contentLayoutGuide.bottomAnchor, constant: -16),
            content.widthAnchor.constraint(equalTo: scroll.frameLayoutGuide.widthAnchor, constant: -32),

            logo.heightAnchor.constraint(equalToConstant: 72),
            liveness.heightAnchor.constraint(equalToConstant: 128),
            secondary.heightAnchor.constraint(equalToConstant: 96),
        ])
    }


    private func makePrimaryTile(title: String, assetName: String, action: Selector) -> UIButton {
        let button = HomeTileButton(title: title, assetName: assetName, primary: true)
        button.addTarget(self, action: action, for: .touchUpInside)
        button.addTarget(self, action: #selector(tileTouchDown(_:)), for: .touchDown)
        button.addTarget(self, action: #selector(tileTouchUp(_:)), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        return button
    }

    private func makeTile(title: String, assetName: String, action: Selector) -> UIButton {
        let button = HomeTileButton(title: title, assetName: assetName, primary: false)
        button.addTarget(self, action: action, for: .touchUpInside)
        button.addTarget(self, action: #selector(tileTouchDown(_:)), for: .touchDown)
        button.addTarget(self, action: #selector(tileTouchUp(_:)), for: [.touchUpInside, .touchUpOutside, .touchCancel])
        return button
    }


    @objc private func tileTouchDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.08) { sender.alpha = 0.75 }
    }


    @objc private func tileTouchUp(_ sender: UIButton) {
        UIView.animate(withDuration: 0.12) { sender.alpha = 1 }
    }


    private func setSdkActionsEnabled(_ enabled: Bool) {
        for button in sdkActionButtons {
            button.isEnabled = enabled
            button.alpha = enabled ? 1 : 0.45
        }
    }


    private func activateSDK() {
        FaceLivenessClient.shared.activate(license: licenseKey) { [weak self] code in
            guard let self else { return }
            self.sdkReady = code == 0
            let verdict: String
            if self.licenseKey.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                verdict = "Empty"
            } else if code == 0 {
                verdict = "Correct"
            } else if code == 2 {
                verdict = "Expired"
            } else {
                verdict = "Failed"
            }
            LicenseStatus.verdict = verdict
            if self.sdkReady {
                self.warningLabel.text = "Ready · License: \(verdict)"
                self.warningLabel.backgroundColor = IXColor.statusOk
                self.setSdkActionsEnabled(true)
            } else {
                self.warningLabel.text = "License: \(verdict)"
                self.warningLabel.backgroundColor = IXColor.statusError
                self.setSdkActionsEnabled(false)
            }
        }
    }


    private func licenseMessage(_ code: Int) -> String {
        switch code {
        case 1: return "Invalid license"
        case 2: return "License expired"
        case 3: return "SDK not activated"
        case 4: return "Engine failed to start"
        default: return "SDK failed: \(code)"
        }
    }


    private func ensureReady() -> Bool {
        if sdkReady { return true }
        let alert = UIAlertController(title: nil, message: "SDK is not ready", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
        return false
    }


    @objc private func openLiveness() {
        guard ensureReady() else { return }
        navigationController?.pushViewController(LivenessCameraViewController(), animated: true)
    }


    @objc private func openSettings() {
        navigationController?.pushViewController(SettingsViewController(), animated: true)
    }


    @objc private func openAbout() {
        navigationController?.pushViewController(AboutViewController(), animated: true)
    }


    @objc private func openBrand() {
        if let url = URL(string: "https://identixia.com") {
            UIApplication.shared.open(url)
        }
    }
}


/// Android home tiles: primary uses accent fill; secondary uses surface card.
private final class HomeTileButton: UIButton {
    private let iconView = UIImageView()
    private let caption = UILabel()

    init(title: String, assetName: String, primary: Bool) {
        super.init(frame: .zero)
        backgroundColor = primary ? IXColor.accent : IXColor.surface
        layer.cornerRadius = 16
        clipsToBounds = true
        if !primary {
            layer.borderWidth = 1
            layer.borderColor = IXColor.stroke.cgColor
        }

        iconView.image = UIImage(named: assetName)?.withRenderingMode(.alwaysTemplate)
        iconView.tintColor = primary ? .white : IXColor.accent
        iconView.contentMode = .scaleAspectFit
        iconView.isUserInteractionEnabled = false

        caption.text = title
        caption.textColor = primary ? .white : IXColor.text
        caption.font = .systemFont(ofSize: primary ? 14 : 12, weight: .bold)
        caption.textAlignment = .center
        caption.adjustsFontSizeToFitWidth = true
        caption.minimumScaleFactor = 0.75
        caption.isUserInteractionEnabled = false

        let stack = UIStackView(arrangedSubviews: [iconView, caption])
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = primary ? 10 : 8
        stack.isUserInteractionEnabled = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stack)
        let icon = primary ? 40.0 : 32.0
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: centerYAnchor),
            stack.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 4),
            stack.trailingAnchor.constraint(lessThanOrEqualTo: trailingAnchor, constant: -4),
            iconView.widthAnchor.constraint(equalToConstant: icon),
            iconView.heightAnchor.constraint(equalToConstant: icon),
        ])
    }

    required init?(coder: NSCoder) { nil }
}
