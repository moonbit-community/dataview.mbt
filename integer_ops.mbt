// Integer operations for DataView

// 8-bit integer operations

///|
/// Get an 8-bit signed integer at the specified byte offset
pub fn DataView::get_int8(self : DataView, byte_offset : Int) -> Int {
  self.check_bounds(byte_offset, 1)
  let byte_val = self.data[byte_offset].to_int()
  if byte_val >= 128 {
    byte_val - 256
  } else {
    byte_val
  }
}

///|
/// Set an 8-bit signed integer at the specified byte offset
pub fn DataView::set_int8(
  self : DataView,
  byte_offset : Int,
  value : Int,
) -> Unit {
  self.check_bounds(byte_offset, 1)
  let byte_val = if value < 0 { value + 256 } else { value }
  self.data[byte_offset] = (byte_val & 0xFF).to_byte()
}

///|
/// Get an 8-bit unsigned integer at the specified byte offset
pub fn DataView::get_uint8(self : DataView, byte_offset : Int) -> UInt {
  self.check_bounds(byte_offset, 1)
  self.data[byte_offset].to_uint()
}

///|
/// Set an 8-bit unsigned integer at the specified byte offset
pub fn DataView::set_uint8(
  self : DataView,
  byte_offset : Int,
  value : UInt,
) -> Unit {
  self.check_bounds(byte_offset, 1)
  self.data[byte_offset] = (value & 0xFF).to_byte()
}

// 16-bit integer operations

///|
/// Get a 16-bit signed integer at the specified byte offset
pub fn DataView::get_int16(
  self : DataView,
  byte_offset : Int,
  little_endian? : Bool = false,
) -> Int {
  self.check_bounds(byte_offset, 2)
  let uint_val = if little_endian {
    read_uint16_le(self.data[:], byte_offset)
  } else {
    read_uint16_be(self.data[:], byte_offset)
  }
  // Convert unsigned 16-bit to signed 16-bit
  if uint_val >= 32768U {
    uint_val.reinterpret_as_int() - 65536
  } else {
    uint_val.reinterpret_as_int()
  }
}

///|
/// Set a 16-bit signed integer at the specified byte offset
pub fn DataView::set_int16(
  self : DataView,
  byte_offset : Int,
  value : Int,
  little_endian? : Bool = false,
) -> Unit {
  self.check_bounds(byte_offset, 2)
  // Convert signed 16-bit to unsigned 16-bit for storage
  let uint_val = if value < 0 {
    (value + 65536).reinterpret_as_uint()
  } else {
    value.reinterpret_as_uint()
  }
  if little_endian {
    write_uint16_le(self.data, byte_offset, uint_val)
  } else {
    write_uint16_be(self.data, byte_offset, uint_val)
  }
}

///|
/// Get a 16-bit unsigned integer at the specified byte offset
pub fn DataView::get_uint16(
  self : DataView,
  byte_offset : Int,
  little_endian? : Bool = false,
) -> UInt {
  self.check_bounds(byte_offset, 2)
  if little_endian {
    read_uint16_le(self.data[:], byte_offset)
  } else {
    read_uint16_be(self.data[:], byte_offset)
  }
}

///|
/// Set a 16-bit unsigned integer at the specified byte offset
pub fn DataView::set_uint16(
  self : DataView,
  byte_offset : Int,
  value : UInt,
  little_endian? : Bool = false,
) -> Unit {
  self.check_bounds(byte_offset, 2)
  if little_endian {
    write_uint16_le(self.data, byte_offset, value)
  } else {
    write_uint16_be(self.data, byte_offset, value)
  }
}

// 32-bit integer operations

///|
/// Get a 32-bit signed integer at the specified byte offset
pub fn DataView::get_int32(
  self : DataView,
  byte_offset : Int,
  little_endian? : Bool = false,
) -> Int {
  self.check_bounds(byte_offset, 4)
  let uint_val = if little_endian {
    read_uint32_le(self.data[:], byte_offset)
  } else {
    read_uint32_be(self.data[:], byte_offset)
  }
  // For 32-bit values, reinterpret_as_int handles the conversion correctly
  uint_val.reinterpret_as_int()
}

///|
/// Set a 32-bit signed integer at the specified byte offset
pub fn DataView::set_int32(
  self : DataView,
  byte_offset : Int,
  value : Int,
  little_endian? : Bool = false,
) -> Unit {
  self.check_bounds(byte_offset, 4)
  // For 32-bit values, reinterpret_as_uint handles the conversion correctly
  let uint_val = value.reinterpret_as_uint()
  if little_endian {
    write_uint32_le(self.data, byte_offset, uint_val)
  } else {
    write_uint32_be(self.data, byte_offset, uint_val)
  }
}

///|
/// Get a 32-bit unsigned integer at the specified byte offset
pub fn DataView::get_uint32(
  self : DataView,
  byte_offset : Int,
  little_endian? : Bool = false,
) -> UInt {
  self.check_bounds(byte_offset, 4)
  if little_endian {
    read_uint32_le(self.data[:], byte_offset)
  } else {
    read_uint32_be(self.data[:], byte_offset)
  }
}

///|
/// Set a 32-bit unsigned integer at the specified byte offset
pub fn DataView::set_uint32(
  self : DataView,
  byte_offset : Int,
  value : UInt,
  little_endian? : Bool = false,
) -> Unit {
  self.check_bounds(byte_offset, 4)
  if little_endian {
    write_uint32_le(self.data, byte_offset, value)
  } else {
    write_uint32_be(self.data, byte_offset, value)
  }
}
