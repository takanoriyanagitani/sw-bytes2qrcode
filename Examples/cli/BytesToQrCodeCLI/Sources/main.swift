import BytesToQrCode
import Foundation

import class CoreImage.CIImage

private func readData(
  from fileHandle: FileHandle,
  upTo limit: Int,
) -> Result<Data, Error> {
  Result(catching: {
    try fileHandle.read(upToCount: limit) ?? Data()
  })
}

func main() {
  let defaultByteLimit: Int = 32

  let sbyteLimit: String? = ProcessInfo.processInfo.environment["BYTE_LIMIT"]
  let obyteLimit: Int? = sbyteLimit.flatMap { Int($0) }
  let byteLimit: Int = obyteLimit ?? defaultByteLimit

  let rinputResult: Result<Data, Error> = readData(
    from: .standardInput,
    upTo: byteLimit,
  )
  let oinputResult: Data? = try? rinputResult.get()
  let inputData: Data = oinputResult ?? Data()

  guard !inputData.isEmpty else {
    fputs("invalid input: no valid input bytes available", stderr)
    exit(1)
  }

  let qrCodeImage: CIImage
  let qrCodeResult: Result<CIImage, _> = dataToQrCode(data: inputData)

  switch qrCodeResult {
  case .success(let image):
    qrCodeImage = image
  case .failure(let error):
    fputs("Error: Could not generate QR code image: \(error).\n", stderr)
    exit(1)
  }

  // Convert CIImage to PNG Data
  let pngResult: Result<Data, _> = ciImageToPngData(image: qrCodeImage)

  switch pngResult {
  case .success(let pngData):
    FileHandle.standardOutput.write(pngData)
  case .failure(let error):
    fputs(
      "Error: Could not convert QR code image to PNG data: \(error).\n",
      stderr,
    )
    exit(1)
  }
}

main()
