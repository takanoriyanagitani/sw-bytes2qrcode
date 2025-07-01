import CoreFoundation
import Foundation
import Testing

import enum BytesToQrCode.QrCorrectionLevel
import class CoreImage.CIImage

@testable import BytesToQrCode

@Test func stringToQrCode() throws {
  let qrCodeResult = stringToQrCode(stringValue: "hello")
  _ = try qrCodeResult.get()
}

@Test func dataToQrCode() throws {
  let data = "hello".data(using: .utf8)!
  let qrCodeResult = dataToQrCode(data: data)
  _ = try qrCodeResult.get()
}

@Test func qrCodeWithLowCorrectionLevel() throws {
  let qrCodeResult = stringToQrCode(stringValue: "hello", correctionLevel: .low)
  _ = try qrCodeResult.get()
}

@Test func ciImageToPngData() throws {
  let qrCodeResult = stringToQrCode(stringValue: "test")
  let qrCode = try qrCodeResult.get()
  let pngResult = ciImageToPngData(image: qrCode)
  let pngData = try pngResult.get()
  #expect(pngData.count > 0)
}
