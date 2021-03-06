// DO NOT EDIT.
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: Headset.proto
//
// For information on using the generated types, please see the documenation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that your are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

struct Headset {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var vendor: String {
    get {return _vendor ?? String()}
    set {_vendor = newValue}
  }
  /// Returns true if `vendor` has been explicitly set.
  var hasVendor: Bool {return self._vendor != nil}
  /// Clears the value of `vendor`. Subsequent reads from it will return its default value.
  mutating func clearVendor() {self._vendor = nil}

  var model: String {
    get {return _model ?? String()}
    set {_model = newValue}
  }
  /// Returns true if `model` has been explicitly set.
  var hasModel: Bool {return self._model != nil}
  /// Clears the value of `model`. Subsequent reads from it will return its default value.
  mutating func clearModel() {self._model = nil}

  var screenToLensDistance: Float {
    get {return _screenToLensDistance ?? 0}
    set {_screenToLensDistance = newValue}
  }
  /// Returns true if `screenToLensDistance` has been explicitly set.
  var hasScreenToLensDistance: Bool {return self._screenToLensDistance != nil}
  /// Clears the value of `screenToLensDistance`. Subsequent reads from it will return its default value.
  mutating func clearScreenToLensDistance() {self._screenToLensDistance = nil}

  var interLensDistance: Float {
    get {return _interLensDistance ?? 0}
    set {_interLensDistance = newValue}
  }
  /// Returns true if `interLensDistance` has been explicitly set.
  var hasInterLensDistance: Bool {return self._interLensDistance != nil}
  /// Clears the value of `interLensDistance`. Subsequent reads from it will return its default value.
  mutating func clearInterLensDistance() {self._interLensDistance = nil}

  var leftEyeFieldOfViewAngles: [Float] = []

  var trayToLensDistance: Float {
    get {return _trayToLensDistance ?? 0}
    set {_trayToLensDistance = newValue}
  }
  /// Returns true if `trayToLensDistance` has been explicitly set.
  var hasTrayToLensDistance: Bool {return self._trayToLensDistance != nil}
  /// Clears the value of `trayToLensDistance`. Subsequent reads from it will return its default value.
  mutating func clearTrayToLensDistance() {self._trayToLensDistance = nil}

  var distortionCoefficients: [Float] = []

  var hasMagnet_p: Bool {
    get {return _hasMagnet_p ?? false}
    set {_hasMagnet_p = newValue}
  }
  /// Returns true if `hasMagnet_p` has been explicitly set.
  var hasHasMagnet_p: Bool {return self._hasMagnet_p != nil}
  /// Clears the value of `hasMagnet_p`. Subsequent reads from it will return its default value.
  mutating func clearHasMagnet_p() {self._hasMagnet_p = nil}

  var verticalAlignment: Int32 {
    get {return _verticalAlignment ?? 0}
    set {_verticalAlignment = newValue}
  }
  /// Returns true if `verticalAlignment` has been explicitly set.
  var hasVerticalAlignment: Bool {return self._verticalAlignment != nil}
  /// Clears the value of `verticalAlignment`. Subsequent reads from it will return its default value.
  mutating func clearVerticalAlignment() {self._verticalAlignment = nil}

  var primaryButton: Int32 {
    get {return _primaryButton ?? 0}
    set {_primaryButton = newValue}
  }
  /// Returns true if `primaryButton` has been explicitly set.
  var hasPrimaryButton: Bool {return self._primaryButton != nil}
  /// Clears the value of `primaryButton`. Subsequent reads from it will return its default value.
  mutating func clearPrimaryButton() {self._primaryButton = nil}

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _vendor: String? = nil
  fileprivate var _model: String? = nil
  fileprivate var _screenToLensDistance: Float? = nil
  fileprivate var _interLensDistance: Float? = nil
  fileprivate var _trayToLensDistance: Float? = nil
  fileprivate var _hasMagnet_p: Bool? = nil
  fileprivate var _verticalAlignment: Int32? = nil
  fileprivate var _primaryButton: Int32? = nil
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

extension Headset: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "Headset"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "vendor"),
    2: .same(proto: "model"),
    3: .same(proto: "screenToLensDistance"),
    4: .same(proto: "interLensDistance"),
    5: .same(proto: "leftEyeFieldOfViewAngles"),
    6: .same(proto: "trayToLensDistance"),
    7: .same(proto: "distortionCoefficients"),
    10: .same(proto: "hasMagnet"),
    11: .same(proto: "verticalAlignment"),
    12: .same(proto: "primaryButton"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &self._vendor)
      case 2: try decoder.decodeSingularStringField(value: &self._model)
      case 3: try decoder.decodeSingularFloatField(value: &self._screenToLensDistance)
      case 4: try decoder.decodeSingularFloatField(value: &self._interLensDistance)
      case 5: try decoder.decodeRepeatedFloatField(value: &self.leftEyeFieldOfViewAngles)
      case 6: try decoder.decodeSingularFloatField(value: &self._trayToLensDistance)
      case 7: try decoder.decodeRepeatedFloatField(value: &self.distortionCoefficients)
      case 10: try decoder.decodeSingularBoolField(value: &self._hasMagnet_p)
      case 11: try decoder.decodeSingularInt32Field(value: &self._verticalAlignment)
      case 12: try decoder.decodeSingularInt32Field(value: &self._primaryButton)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = self._vendor {
      try visitor.visitSingularStringField(value: v, fieldNumber: 1)
    }
    if let v = self._model {
      try visitor.visitSingularStringField(value: v, fieldNumber: 2)
    }
    if let v = self._screenToLensDistance {
      try visitor.visitSingularFloatField(value: v, fieldNumber: 3)
    }
    if let v = self._interLensDistance {
      try visitor.visitSingularFloatField(value: v, fieldNumber: 4)
    }
    if !self.leftEyeFieldOfViewAngles.isEmpty {
      try visitor.visitPackedFloatField(value: self.leftEyeFieldOfViewAngles, fieldNumber: 5)
    }
    if let v = self._trayToLensDistance {
      try visitor.visitSingularFloatField(value: v, fieldNumber: 6)
    }
    if !self.distortionCoefficients.isEmpty {
      try visitor.visitPackedFloatField(value: self.distortionCoefficients, fieldNumber: 7)
    }
    if let v = self._hasMagnet_p {
      try visitor.visitSingularBoolField(value: v, fieldNumber: 10)
    }
    if let v = self._verticalAlignment {
      try visitor.visitSingularInt32Field(value: v, fieldNumber: 11)
    }
    if let v = self._primaryButton {
      try visitor.visitSingularInt32Field(value: v, fieldNumber: 12)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  func _protobuf_generated_isEqualTo(other: Headset) -> Bool {
    if self._vendor != other._vendor {return false}
    if self._model != other._model {return false}
    if self._screenToLensDistance != other._screenToLensDistance {return false}
    if self._interLensDistance != other._interLensDistance {return false}
    if self.leftEyeFieldOfViewAngles != other.leftEyeFieldOfViewAngles {return false}
    if self._trayToLensDistance != other._trayToLensDistance {return false}
    if self.distortionCoefficients != other.distortionCoefficients {return false}
    if self._hasMagnet_p != other._hasMagnet_p {return false}
    if self._verticalAlignment != other._verticalAlignment {return false}
    if self._primaryButton != other._primaryButton {return false}
    if unknownFields != other.unknownFields {return false}
    return true
  }
}
