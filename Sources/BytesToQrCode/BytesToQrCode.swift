import CoreGraphics
import CoreImage.CIFilterBuiltins
import Foundation
import ImageIO
import UniformTypeIdentifiers

import class CoreImage.CIFilter
import class CoreImage.CIImage
import protocol CoreImage.CIQRCodeGenerator

public enum ImageConversionError: Error {
  case failedToCreateCGImage
  case failedToCreatePNGRepresentation
  case failedToCreateColorSpace
}

public enum ImageGenerationError: Error {
  case failedToGenerateQRCode
}

public func stringToQrCode(
  stringValue: String,
  correctionLevel: QrCorrectionLevel = .high
) -> Result<CIImage, ImageGenerationError> {
  let data: Data = Data(stringValue.utf8)

  return dataToQrCode(data: data, correctionLevel: correctionLevel)
}

public func dataToQrCode(
  data: Data,
  correctionLevel: QrCorrectionLevel = .high
) -> Result<CIImage, ImageGenerationError> {
  let qrCodeGen: CIFilter & CIQRCodeGenerator = CIFilter.qrCodeGenerator()
  qrCodeGen.correctionLevel = correctionLevel.rawValue
  qrCodeGen.message = data

  guard let outputImage = qrCodeGen.outputImage else {
    return .failure(.failedToGenerateQRCode)
  }
  return .success(outputImage)
}

public func ciImageToPngData(
  image: CIImage,
  context: CIContext = CIContext(),
) -> Result<Data, ImageConversionError> {
  let ospace: CGColorSpace? = CGColorSpace(name: CGColorSpace.sRGB)
  guard let colorSpace = ospace else {
    return .failure(.failedToCreateColorSpace)
  }

  let optionalPngData: Data? = context.pngRepresentation(
    of: image,
    format: .ARGB8,
    colorSpace: colorSpace,
    options: [:]
  )
  guard let pngData = optionalPngData else {
    return .failure(.failedToCreatePNGRepresentation)
  }

  return .success(pngData)
}
