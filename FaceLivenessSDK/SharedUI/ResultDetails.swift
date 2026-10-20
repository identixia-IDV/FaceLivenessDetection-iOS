import Foundation

/// Liveness + deepfake helpers (parity with Android / FaceRecognition ResultDetails).
enum ResultDetails {
    /// Map engine deepfake.value (bool / 0-1 / REAL|FAKE) to fake|real|"".
    static func deepfakeKind(_ raw: String?) -> String {
        var text = (raw ?? "").trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        if text.isEmpty { return "" }
        if let range = text.range(of: " · ") {
            text = String(text[..<range.lowerBound])
        }
        if let range = text.range(of: " (") {
            text = String(text[..<range.lowerBound]).trimmingCharacters(in: .whitespaces)
        }
        if ["fake", "true", "1", "yes"].contains(text) { return "fake" }
        if ["real", "false", "0", "no"].contains(text) { return "real" }
        if text.contains("fake") { return "fake" }
        if text.contains("real") { return "real" }
        return ""
    }

    static func deepfakeText(_ raw: String?) -> String {
        let kind = deepfakeKind(raw)
        if kind.isEmpty { return "" }
        let heading = kind == "fake" ? "FAKE" : "REAL"
        guard let raw, let open = raw.firstIndex(of: "("), let close = raw.firstIndex(of: ")") else {
            return heading
        }
        let conf = String(raw[raw.index(after: open)..<close]).trimmingCharacters(in: .whitespaces)
        return conf.isEmpty ? heading : "\(heading) · \(conf)"
    }

    /// REAL only when both liveness and deepfake say real (Windows parity).
    static func authenticityPassed(score: Float, liveLabel: String?, deepfakeRaw: String?) -> Bool {
        if !AppSettings.livenessPassed(score: score, label: liveLabel) { return false }
        let kind = deepfakeKind(deepfakeRaw)
        return kind.isEmpty || kind == "real"
    }

    static func authenticityHeading(score: Float, liveLabel: String?, deepfakeRaw: String?) -> String {
        let liveOk = AppSettings.livenessPassed(score: score, label: liveLabel)
        let kind = deepfakeKind(deepfakeRaw)
        let liveHeading = liveOk ? "REAL" : "FAKE"
        let dfHeading: String
        switch kind {
        case "real": dfHeading = "REAL"
        case "fake": dfHeading = "FAKE"
        default: dfHeading = ""
        }
        if dfHeading.isEmpty { return liveHeading }
        return liveHeading == "REAL" && dfHeading == "REAL" ? "REAL" : "FAKE"
    }
}
