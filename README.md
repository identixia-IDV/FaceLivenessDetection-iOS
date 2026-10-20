<div align="center">
<img alt="Identixia" src="https://raw.githubusercontent.com/identixia-IDV/identixia-assets/main/brand/logo.png" width="320"/>

<a href="https://identixia.com"><img src="https://img.shields.io/badge/Website-0F766E?style=for-the-badge&logo=googlechrome&logoColor=white" alt="Website" /></a>
<a href="https://docs.identixia.com"><img src="https://img.shields.io/badge/Docs-0F766E?style=for-the-badge&logo=gitbook&logoColor=white" alt="Docs" /></a>
<a href="https://huggingface.co/Identixia"><img src="https://img.shields.io/badge/HuggingFace-FFD21E?style=for-the-badge&logo=huggingface&logoColor=black" alt="Hugging Face" /></a>
<a href="https://hub.docker.com/u/identixia"><img src="https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white" alt="Docker Hub" /></a>
<a href="https://playground.identixia.com/"><img src="https://img.shields.io/badge/Playground-0F766E?style=for-the-badge&logo=cloudplayground&logoColor=white" alt="Playground" /></a>
</div>

<div align="center">

# <img src="https://cdn.simpleicons.org/apple/000000" width="32" height="32" alt="" /> Face Liveness Detection SDK for iOS — Sample App | Identixia

</div>

Integrate **face liveness detection and anti-spoofing** with the **Identixia iOS SDK**. This repository provides a native iOS sample app for passive face liveness detection and deepfake detection. Use presentation attack detection (PAD) to check for face spoofing and deepfake detection to check for manipulated face images. The combined authenticity result is REAL only when both checks pass. Face recognition and matching are not included.

Use the sample to add selfie liveness checks to remote onboarding and biometric identity verification alongside a separate face matching service. Processing runs on the device; images are not sent to the Identixia cloud.

> For setup, integration, and API guides, see the [Face Liveness Detection SDK documentation for iOS](https://docs.identixia.com/developers/face-sdk/liveness-ios). This page covers the sample repository.

## <img src="https://api.iconify.design/lucide/clipboard-list.svg?color=%230F766E" width="24" height="24" alt="" /> SDK overview

The sample includes a demo license. Your own application requires a key issued for its application identifier.

| Topic | Basic information |
| --- | --- |
| **Product** | On-device **face liveness detection** for iOS |
| **Demo tiles** | Liveness · Settings · About |
| **Runtime** | `facelivenesssdk.framework`, `FaceLivenessEngine.framework`, `onnxruntime.framework` plus database packs from the Release |
| **Demo bundle id** | `com.identixia.faceliveness.app` |
| **Tools** | Xcode · physical iPhone |
| **Privacy** | All processing on device — no Identixia cloud |

---

## <img src="https://api.iconify.design/lucide/terminal.svg?color=%230F766E" width="24" height="24" alt="" /> Quick start

### <img src="https://img.shields.io/badge/-1-0F766E?style=for-the-badge" alt="" /> Clone and download the SDK libraries

```bash
git clone https://github.com/identixia-IDV/FaceLivenessDetection-iOS.git
cd FaceLivenessDetection-iOS
```

Download [`faceliveness.zip`](https://github.com/identixia-IDV/FaceLivenessDetection-iOS/releases/tag/runtime) from this repository’s [Releases](https://github.com/identixia-IDV/FaceLivenessDetection-iOS/releases/tag/runtime). Unzip it at the repository root so the frameworks and database packs land in the sample folders, not inside an extra directory.

### <img src="https://img.shields.io/badge/-2-0F766E?style=for-the-badge" alt="" /> Run the demo

Open `FaceLivenessSDK.xcodeproj` in **Xcode**, set your Team, and run on a physical iPhone. Home status should show ready, then **Liveness / Settings / About** unlock.

### <img src="https://img.shields.io/badge/-3-0F766E?style=for-the-badge" alt="" /> Activate / license

1. Copy the id of your own app. On Android this is the application id. On iOS this is the bundle id. The sample id is `com.identixia.faceliveness.app`.
2. Email that id and the product name to [contact@identixia.com](mailto:contact@identixia.com).
3. Replace the demo key in `FaceLivenessSDK/Home/ViewController.swift` with the key you receive.
4. Rebuild, then continue with the next step.

### <img src="https://img.shields.io/badge/-4-0F766E?style=for-the-badge" alt="" /> First capture

Wait for the Home screen to show **Ready**, then select a demo feature. Check the license status on the Result or About screen before integrating the SDK into your own app.

---

## <img src="https://api.iconify.design/lucide/list-checks.svg?color=%230F766E" width="24" height="24" alt="" /> Features

| Capability | What it does |
| --- | --- |
| **Liveness** | Live camera PAD + deepfake with face overlay and authenticity metrics |
| **Settings** | Camera lens and liveness threshold |
| **About** | SDK status and on-device anti-spoofing summary |

## <img src="https://api.iconify.design/lucide/pc-case.svg?color=%230F766E" width="24" height="24" alt="" /> System requirements

| | |
| --- | --- |
| Device | Physical iPhone |
| Tools | Xcode with your signing Team |
| Demo bundle id | `com.identixia.faceliveness.app` |

---

## <img src="https://api.iconify.design/lucide/package.svg?color=%230F766E" width="24" height="24" alt="" /> SDK installation

Download [`faceliveness.zip`](https://github.com/identixia-IDV/FaceLivenessDetection-iOS/releases/tag/runtime) from this repository’s [Releases](https://github.com/identixia-IDV/FaceLivenessDetection-iOS/releases/tag/runtime). Unzip it at the repository root so the frameworks and database packs land in the sample folders, not inside an extra directory.

After you unzip the Release, the frameworks and database packs should sit at the repository root (or under `Frameworks/` / `databases/`).

---

## <img src="https://api.iconify.design/lucide/rocket.svg?color=%230F766E" width="24" height="24" alt="" /> Run

Open `FaceLivenessSDK.xcodeproj` in **Xcode**, set your Team, and run on a physical iPhone. Home status should show ready, then **Liveness / Settings / About** unlock.

---

## <img src="https://api.iconify.design/lucide/key-round.svg?color=%230F766E" width="24" height="24" alt="" /> SDK license and activation

1. Run the sample with the bundled key and the sample id below.
2. For your own app, email [contact@identixia.com](mailto:contact@identixia.com) with the platform, your application id or bundle id, and the features you need.
3. Put the key you receive in the same place as the demo key.
4. Rebuild. Activation runs before SDK init. If it fails, the key does not match that id.

Sample id:

- `com.identixia.faceliveness.app`

Set the key, then activate:

https://github.com/identixia-IDV/FaceLivenessDetection-iOS/blob/af8ac9a280416afcd184873918bc17d4aec2e723/FaceLivenessSDK/Home/ViewController.swift#L8-L11

https://github.com/identixia-IDV/FaceLivenessDetection-iOS/blob/af8ac9a280416afcd184873918bc17d4aec2e723/FaceLivenessSDK/Home/ViewController.swift#L154-L154

## <img src="https://api.iconify.design/lucide/braces.svg?color=%230F766E" width="24" height="24" alt="" /> API

The following SDK methods are used by the sample and can also be called from your application.

| API | Purpose |
| --- | --- |
| `activate(license)` then `init()` | Activate the license, then initialize the engine. Run these calls in order on one background thread. |
| `getLicenseStatus()` | Check the license status and enabled features before opening the camera. |
| `liveness` / `deepfake` | Run presentation attack detection and deepfake checks. Report REAL only when both pass. |
| Enroll / 1:N | Not included. Use a Face Recognition repository for templates. |

Keep camera preview updates on the UI thread. Run SDK operations sequentially on a single background thread; the engine does not support simultaneous calls.

---

## <img src="https://api.iconify.design/lucide/layers.svg?color=%230F766E" width="24" height="24" alt="" /> SDKs for other platforms

| | Platform | Repo |
| --- | --- | --- |
| <img src="https://cdn.simpleicons.org/android/3DDC84" width="18" height="18" alt="" /> | Android | [FaceLivenessDetection-Android](https://github.com/identixia-IDV/FaceLivenessDetection-Android) |
| <img src="https://cdn.simpleicons.org/apple/000000" width="18" height="18" alt="" /> | iOS ← this repo | [FaceLivenessDetection-iOS](https://github.com/identixia-IDV/FaceLivenessDetection-iOS) |
| <img src="https://cdn.simpleicons.org/flutter/02569B" width="18" height="18" alt="" /> | Flutter | [FaceLivenessDetection-Flutter](https://github.com/identixia-IDV/FaceLivenessDetection-Flutter) |
| <img src="https://cdn.simpleicons.org/react/61DAFB" width="18" height="18" alt="" /> | React Native | [FaceLivenessDetection-React-Native](https://github.com/identixia-IDV/FaceLivenessDetection-React-Native) |
| <img src="https://cdn.simpleicons.org/ionic/3880FF" width="18" height="18" alt="" /> | Ionic Capacitor | [FaceLivenessDetection-Ionic-Capacitor](https://github.com/identixia-IDV/FaceLivenessDetection-Ionic-Capacitor) |
| <img src="https://cdn.simpleicons.org/apachecordova/E8E8E8" width="18" height="18" alt="" /> | Ionic Cordova | [FaceLivenessDetection-Ionic-Cordova](https://github.com/identixia-IDV/FaceLivenessDetection-Ionic-Cordova) |
| <img src="https://cdn.simpleicons.org/windows/0078D4" width="18" height="18" alt="" /> | Windows | [FaceLivenessDetection-Windows](https://github.com/identixia-IDV/FaceLivenessDetection-Windows) |
| <img src="https://cdn.simpleicons.org/docker/2496ED" width="18" height="18" alt="" /> | Linux / Docker | [FaceLivenessDetection-Docker](https://github.com/identixia-IDV/FaceLivenessDetection-Docker) |

---

## <img src="https://api.iconify.design/lucide/mail.svg?color=%230F766E" width="24" height="24" alt="" /> Contact

<div align="center">

<a href="mailto:contact@identixia.com"><img alt="Email contact@identixia.com" src="https://img.shields.io/badge/Email-contact%40identixia.com-0F766E?style=for-the-badge&logo=gmail&logoColor=white" /></a>
<a href="https://wa.me/17018854218"><img alt="WhatsApp +1 (701) 885-4218" src="https://img.shields.io/badge/WhatsApp-%2B1_(701)_885--4218-25D366?style=for-the-badge&logo=whatsapp&logoColor=white" /></a>
<a href="https://t.me/identixia"><img alt="Telegram @identixia" src="https://img.shields.io/badge/Telegram-%40identixia-26A5E4?style=for-the-badge&logo=telegram&logoColor=white" /></a>

</div>

---
