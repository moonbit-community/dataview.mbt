// Floating point operations for DataView

///|
/// Get a 32-bit float at the specified byte offset
pub fn DataView::get_float32(
  self : DataView,
  byte_offset : Int,
  little_endian? : Bool = false,
) -> Float {
  let uint_val = self.get_uint32(byte_offset, little_endian~)
  Float::reinterpret_from_uint(uint_val)
}

///|
/// Set a 32-bit float at the specified byte offset
pub fn DataView::set_float32(
  self : DataView,
  byte_offset : Int,
  value : Float,
  little_endian? : Bool = false,
) -> Unit {
  let uint_val = value.reinterpret_as_uint()
  self.set_uint32(byte_offset, uint_val, little_endian~)
}

///|
/// Get a 64-bit double at the specified byte offset
pub fn DataView::get_float64(
  self : DataView,
  byte_offset : Int,
  little_endian? : Bool = false,
) -> Double {
  self.check_bounds(byte_offset, 8)
  let high = self.get_uint32(byte_offset, little_endian~)
  let low = self.get_uint32(byte_offset + 4, little_endian~)
  let bits = if little_endian {
    (high.to_int64() << 32) | low.to_int64()
  } else {
    (low.to_int64() << 32) | high.to_int64()
  }
  bits.reinterpret_as_double()
}

///|
/// Set a 64-bit double at the specified byte offset
pub fn DataView::set_float64(
  self : DataView,
  byte_offset : Int,
  value : Double,
  little_endian? : Bool = false,
) -> Unit {
  self.check_bounds(byte_offset, 8)
  let bits = value.reinterpret_as_int64()
  let high = (bits >> 32).to_int().reinterpret_as_uint()
  let low = (bits & 0xFFFFFFFFL).to_int().reinterpret_as_uint()
  if little_endian {
    self.set_uint32(byte_offset, low, little_endian~)
    self.set_uint32(byte_offset + 4, high, little_endian~)
  } else {
    self.set_uint32(byte_offset, high, little_endian~)
    self.set_uint32(byte_offset + 4, low, little_endian~)
  }
}
