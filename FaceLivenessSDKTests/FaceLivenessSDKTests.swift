import XCTest
@testable import FaceLivenessSDK

final class FaceLivenessSDKTests: XCTestCase {
    func testAppSettingsDefaults() {
        AppSettings.restoreDefaults()
        XCTAssertTrue(AppSettings.useFrontCamera)
        XCTAssertEqual(AppSettings.livenessThreshold, 0.5, accuracy: 0.001)
        XCTAssertEqual(AppSettings.livenessLevel, 0)
    }

    func testUseFrontCameraBackLens() {
        AppSettings.restoreDefaults()
        AppSettings.useFrontCamera = false
        XCTAssertFalse(AppSettings.useFrontCamera)
        AppSettings.useFrontCamera = true
        XCTAssertTrue(AppSettings.useFrontCamera)
    }

    func testLivenessPassed() {
        AppSettings.restoreDefaults()
        XCTAssertFalse(AppSettings.livenessPassed(score: 0.99, label: "spoof"))
        XCTAssertFalse(AppSettings.livenessPassed(score: 0.99, label: "Fake"))
        XCTAssertTrue(AppSettings.livenessPassed(score: 0.5, label: "real"))
        XCTAssertFalse(AppSettings.livenessPassed(score: 0.49, label: nil))
    }

    func testAuthenticityRequiresDeepfakeReal() {
        AppSettings.restoreDefaults()
        XCTAssertTrue(ResultDetails.authenticityPassed(score: 0.9, liveLabel: "real", deepfakeRaw: nil))
        XCTAssertTrue(ResultDetails.authenticityPassed(score: 0.9, liveLabel: "real", deepfakeRaw: "REAL (0.88)"))
        XCTAssertFalse(ResultDetails.authenticityPassed(score: 0.9, liveLabel: "real", deepfakeRaw: "FAKE (0.91)"))
        XCTAssertFalse(ResultDetails.authenticityPassed(score: 0.9, liveLabel: "spoof", deepfakeRaw: "REAL"))
        XCTAssertEqual(
            ResultDetails.authenticityHeading(score: 0.9, liveLabel: "real", deepfakeRaw: "FAKE"),
            "FAKE"
        )
    }
}
