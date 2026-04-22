// Helper functions for endianness conversion

///|
pub fn read_uint16_le(data : ArrayView[Byte], offset : Int) -> UInt {
  let b0 = data[offset].to_uint()
  let b1 = data[offset + 1].to_uint()
  b0 | (b1 << 8)
}

///|
pub fn read_uint16_be(data : ArrayView[Byte], offset : Int) -> UInt {
  let b0 = data[offset].to_uint()
  let b1 = data[offset + 1].to_uint()
  (b0 << 8) | b1
}

///|
pub fn write_uint16_le(
  data : MutArrayView[Byte],
  offset : Int,
  value : UInt,
) -> Unit {
  data[offset] = (value & 0xFF).to_byte()
  data[offset + 1] = ((value >> 8) & 0xFF).to_byte()
}

///|
pub fn write_uint16_be(
  data : MutArrayView[Byte],
  offset : Int,
  value : UInt,
) -> Unit {
  data[offset] = ((value >> 8) & 0xFF).to_byte()
  data[offset + 1] = (value & 0xFF).to_byte()
}

///|
pub fn read_uint32_le(data : ArrayView[Byte], offset : Int) -> UInt {
  let b0 = data[offset].to_uint()
  let b1 = data[offset + 1].to_uint()
  let b2 = data[offset + 2].to_uint()
  let b3 = data[offset + 3].to_uint()
  b0 | (b1 << 8) | (b2 << 16) | (b3 << 24)
}

///|
pub fn read_uint32_be(data : ArrayView[Byte], offset : Int) -> UInt {
  let b0 = data[offset].to_uint()
  let b1 = data[offset + 1].to_uint()
  let b2 = data[offset + 2].to_uint()
  let b3 = data[offset + 3].to_uint()
  (b0 << 24) | (b1 << 16) | (b2 << 8) | b3
}

///|
pub fn write_uint32_le(
  data : MutArrayView[Byte],
  offset : Int,
  value : UInt,
) -> Unit {
  data[offset] = (value & 0xFF).to_byte()
  data[offset + 1] = ((value >> 8) & 0xFF).to_byte()
  data[offset + 2] = ((value >> 16) & 0xFF).to_byte()
  data[offset + 3] = ((value >> 24) & 0xFF).to_byte()
}

///|
pub fn write_uint32_be(
  data : MutArrayView[Byte],
  offset : Int,
  value : UInt,
) -> Unit {
  data[offset] = ((value >> 24) & 0xFF).to_byte()
  data[offset + 1] = ((value >> 16) & 0xFF).to_byte()
  data[offset + 2] = ((value >> 8) & 0xFF).to_byte()
  data[offset + 3] = (value & 0xFF).to_byte()
}
