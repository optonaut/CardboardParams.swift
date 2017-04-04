# CardboardParams.swift

A library to parse parameter from Google Cardboard QR codes. 

## How does it work

Google stores a URL in their Cardboard QR codes. The data that describes the device parameters is stored as base64 encoded parameter inside this URL. Sometimes, the QR code
refers to a shortened URL which needs to be resolved first. 

## Usage Example

```
let url = "http://goo.gl/vvTUK3";
CardboardParams.fromUrl(url, onCompleted: { result in
    if let cardboard = result.value {
        print(cardboard.vendor) // Carl Zeiss AG
        print(cardboard.model) // VR One
    } else {
        // Handle Error
    }
})
```
