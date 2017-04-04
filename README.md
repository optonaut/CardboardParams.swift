# CardboardParams.swift

A library to parse parameters from [Google Cardboard QR codes](https://support.google.com/cardboard/manufacturers/answer/6321873?hl=en) and urls. 

<img src="http://i.imgur.com/PVQmYPB.jpg" width="200px" alt="Cardboard QR Code">

## How does it work

Google stores a URL in their Cardboard QR codes. The data that describes the headset's parameters is stored as base64 encoded parameter inside this URL. Sometimes, the QR code
refers to a shortened URL which needs to be resolved first.

## Usage Example

```
let url = "http://goo.gl/vvTUK3";

CardboardParams.fromUrl(url, onCompleted: { result in
    if let cardboard = result.value {
        print(cardboard.vendor) // Carl Zeiss AG
        print(cardboard.model) // VR One
        print(headset.distortionCoefficients) // [0.1, 1.0]
        print(headset.leftEyeFieldOfViewAngles) // [50.0, 50.0, 50.0, 50.0]
        print(headset.screenToLensDistance) // 0.037
        print(headset.interLensDistance) // 0.062
        print(headset.hasMagnet) // false
        print(headset.verticalAlignment) // 1
        print(headset.primaryButton) // 0
    } else {
        // Handle Error
    }
})
```

## Installing via Carthage

Add the following to your cartfile:

```
github "optonaut/CardboardParams.swift" >= 0.1.5
```
