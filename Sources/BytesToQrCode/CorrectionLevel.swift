/// Represents the error correction level for a QR code.
///
/// The error correction level determines the amount of data that can be recovered if the QR code is damaged.
/// Higher correction levels result in larger QR codes but offer better resilience to damage.
public enum QrCorrectionLevel: String {
  /// Low error correction level (L): Approximately 7% of data can be recovered.
  case low = "L"
  /// Medium error correction level (M): Approximately 15% of data can be recovered.
  case medium = "M"
  /// Quartile error correction level (Q): Approximately 25% of data can be recovered.
  case quartile = "Q"
  /// High error correction level (H): Approximately 30% of data can be recovered.
  case high = "H"
}
