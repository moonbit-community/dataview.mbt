// Utility methods for DataView

///|
/// Get a range of bytes as an ArrayView
pub fn DataView::get_bytes(
  self : DataView,
  start : Int,
  length : Int,
) -> ArrayView[Byte] {
  if start < 0 || length < 0 || start + length > self.byte_length() {
    abort("DataView get_bytes out of bounds")
  }
  self.data[start:start + length]
}

///|
/// Create a copy of this DataView with independent underlying data
pub fn DataView::copy(self : DataView) -> DataView {
  let new_data = Array::make(self.byte_length(), b'\x00')
  for i = 0; i < self.byte_length(); i = i + 1 {
    new_data[i] = self.data[i]
  }
  { data: new_data.mut_view(), offset: 0, length: new_data.length() }
}

///|
/// Convert DataView to a string representation
pub fn DataView::to_string(self : DataView) -> String {
  let buffer = "DataView { length: " +
    self.byte_length().to_string() +
    ", data: ["
  let mut result = buffer
  for i = 0; i < self.byte_length() && i < 16; i = i + 1 {
    if i > 0 {
      result = result + ", "
    }
    result = result + "0x" + self.data[i].to_int().to_string()
  }
  if self.byte_length() > 16 {
    result = result + ", ..."
  }
  result = result + "] }"
  result
}

///|
pub impl Show for DataView with fn output(self, logger) {
  logger.write_string(self.to_string())
}
