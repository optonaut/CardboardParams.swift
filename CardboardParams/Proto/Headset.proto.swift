/*
 * DO NOT EDIT.
 *
 * Generated by the protocol buffer compiler.
 * Source: Headset.proto
 *
 */

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that your are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _1: SwiftProtobuf.ProtobufAPIVersion_1 {}
  typealias Version = _1
}

struct Headset: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
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

  private var _vendor: String? = nil
  var vendor: String {
    get {return _vendor ?? ""}
    set {_vendor = newValue}
  }
  var hasVendor: Bool {
    return _vendor != nil
  }
  mutating func clearVendor() {
    return _vendor = nil
  }

  private var _model: String? = nil
  var model: String {
    get {return _model ?? ""}
    set {_model = newValue}
  }
  var hasModel: Bool {
    return _model != nil
  }
  mutating func clearModel() {
    return _model = nil
  }

  private var _screenToLensDistance: Float? = nil
  var screenToLensDistance: Float {
    get {return _screenToLensDistance ?? 0}
    set {_screenToLensDistance = newValue}
  }
  var hasScreenToLensDistance: Bool {
    return _screenToLensDistance != nil
  }
  mutating func clearScreenToLensDistance() {
    return _screenToLensDistance = nil
  }

  private var _interLensDistance: Float? = nil
  var interLensDistance: Float {
    get {return _interLensDistance ?? 0}
    set {_interLensDistance = newValue}
  }
  var hasInterLensDistance: Bool {
    return _interLensDistance != nil
  }
  mutating func clearInterLensDistance() {
    return _interLensDistance = nil
  }

  var leftEyeFieldOfViewAngles: [Float] = []

  private var _trayToLensDistance: Float? = nil
  var trayToLensDistance: Float {
    get {return _trayToLensDistance ?? 0}
    set {_trayToLensDistance = newValue}
  }
  var hasTrayToLensDistance: Bool {
    return _trayToLensDistance != nil
  }
  mutating func clearTrayToLensDistance() {
    return _trayToLensDistance = nil
  }

  var distortionCoefficients: [Float] = []

  private var _hasMagnet: Bool? = nil
  var hasMagnet: Bool {
    get {return _hasMagnet ?? false}
    set {_hasMagnet = newValue}
  }
  var hasHasMagnet: Bool {
    return _hasMagnet != nil
  }
  mutating func clearHasMagnet() {
    return _hasMagnet = nil
  }

  private var _verticalAlignment: Int32? = nil
  var verticalAlignment: Int32 {
    get {return _verticalAlignment ?? 0}
    set {_verticalAlignment = newValue}
  }
  var hasVerticalAlignment: Bool {
    return _verticalAlignment != nil
  }
  mutating func clearVerticalAlignment() {
    return _verticalAlignment = nil
  }

  private var _primaryButton: Int32? = nil
  var primaryButton: Int32 {
    get {return _primaryButton ?? 0}
    set {_primaryButton = newValue}
  }
  var hasPrimaryButton: Bool {
    return _primaryButton != nil
  }
  mutating func clearPrimaryButton() {
    return _primaryButton = nil
  }

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      switch fieldNumber {
      case 1: try decoder.decodeSingularStringField(value: &_vendor)
      case 2: try decoder.decodeSingularStringField(value: &_model)
      case 3: try decoder.decodeSingularFloatField(value: &_screenToLensDistance)
      case 4: try decoder.decodeSingularFloatField(value: &_interLensDistance)
      case 5: try decoder.decodeRepeatedFloatField(value: &leftEyeFieldOfViewAngles)
      case 6: try decoder.decodeSingularFloatField(value: &_trayToLensDistance)
      case 7: try decoder.decodeRepeatedFloatField(value: &distortionCoefficients)
      case 10: try decoder.decodeSingularBoolField(value: &_hasMagnet)
      case 11: try decoder.decodeSingularInt32Field(value: &_verticalAlignment)
      case 12: try decoder.decodeSingularInt32Field(value: &_primaryButton)
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if let v = _vendor {
      try visitor.visitSingularStringField(value: v, fieldNumber: 1)
    }
    if let v = _model {
      try visitor.visitSingularStringField(value: v, fieldNumber: 2)
    }
    if let v = _screenToLensDistance {
      try visitor.visitSingularFloatField(value: v, fieldNumber: 3)
    }
    if let v = _interLensDistance {
      try visitor.visitSingularFloatField(value: v, fieldNumber: 4)
    }
    if !leftEyeFieldOfViewAngles.isEmpty {
      try visitor.visitPackedFloatField(value: leftEyeFieldOfViewAngles, fieldNumber: 5)
    }
    if let v = _trayToLensDistance {
      try visitor.visitSingularFloatField(value: v, fieldNumber: 6)
    }
    if !distortionCoefficients.isEmpty {
      try visitor.visitPackedFloatField(value: distortionCoefficients, fieldNumber: 7)
    }
    if let v = _hasMagnet {
      try visitor.visitSingularBoolField(value: v, fieldNumber: 10)
    }
    if let v = _verticalAlignment {
      try visitor.visitSingularInt32Field(value: v, fieldNumber: 11)
    }
    if let v = _primaryButton {
      try visitor.visitSingularInt32Field(value: v, fieldNumber: 12)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  func _protobuf_generated_isEqualTo(other: Headset) -> Bool {
    if _vendor != other._vendor {return false}
    if _model != other._model {return false}
    if _screenToLensDistance != other._screenToLensDistance {return false}
    if _interLensDistance != other._interLensDistance {return false}
    if leftEyeFieldOfViewAngles != other.leftEyeFieldOfViewAngles {return false}
    if _trayToLensDistance != other._trayToLensDistance {return false}
    if distortionCoefficients != other.distortionCoefficients {return false}
    if _hasMagnet != other._hasMagnet {return false}
    if _verticalAlignment != other._verticalAlignment {return false}
    if _primaryButton != other._primaryButton {return false}
    if unknownFields != other.unknownFields {return false}
    return true
  }
}
