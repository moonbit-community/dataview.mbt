// Black box tests for endian_helpers module

///|
test "read_uint16_le basic functionality" {
  let data = Array::make(4, b'\x00')
  data[0] = b'\x34' // 0x34
  data[1] = b'\x12' // 0x12
  let view = data[:]
  let result = @dataview.read_uint16_le(view, 0)
  inspect(result.to_string(radix=16), content="1234") // 0x1234
}

///|
test "read_uint16_be basic functionality" {
  let data = Array::make(4, b'\x00')
  data[0] = b'\x12' // 0x12
  data[1] = b'\x34' // 0x34
  let view = data[:]
  let result = @dataview.read_uint16_be(view, 0)
  inspect(result.to_string(radix=16), content="1234") // 0x1234
}

///|
test "write_uint16_le basic functionality" {
  let data = Array::make(4, b'\x00')
  @dataview.write_uint16_le(data.mut_view(), 0, 0x1234U)
  inspect(data[0], content="b'\\x34'") // 0x34
  inspect(data[1], content="b'\\x12'") // 0x12
}

///|
test "write_uint16_be basic functionality" {
  let data = Array::make(4, b'\x00')
  @dataview.write_uint16_be(data.mut_view(), 0, 0x1234U)
  inspect(data[0], content="b'\\x12'") // 0x12
  inspect(data[1], content="b'\\x34'") // 0x34
}

///|
test "read_uint32_le basic functionality" {
  let data = Array::make(8, b'\x00')
  data[0] = b'\x78' // 0x78
  data[1] = b'\x56' // 0x56
  data[2] = b'\x34' // 0x34
  data[3] = b'\x12' // 0x12
  let view = data[:]
  let result = @dataview.read_uint32_le(view, 0)
  inspect(result.to_string(radix=16), content="12345678") // 0x12345678
}

///|
test "read_uint32_be basic functionality" {
  let data = Array::make(8, b'\x00')
  data[0] = b'\x12' // 0x12
  data[1] = b'\x34' // 0x34
  data[2] = b'\x56' // 0x56
  data[3] = b'\x78' // 0x78
  let view = data[:]
  let result = @dataview.read_uint32_be(view, 0)
  inspect(result.to_string(radix=16), content="12345678") // 0x12345678
}

///|
test "write_uint32_le basic functionality" {
  let data = Array::make(8, b'\x00')
  @dataview.write_uint32_le(data.mut_view(), 0, 0x12345678U)
  inspect(data[0], content="b'\\x78'") // 0x78
  inspect(data[1], content="b'\\x56'") // 0x56
  inspect(data[2], content="b'\\x34'") // 0x34
  inspect(data[3], content="b'\\x12'") // 0x12
}

///|
test "write_uint32_be basic functionality" {
  let data = Array::make(8, b'\x00')
  @dataview.write_uint32_be(data.mut_view(), 0, 0x12345678U)
  inspect(data[0], content="b'\\x12'") // 0x12
  inspect(data[1], content="b'\\x34'") // 0x34
  inspect(data[2], content="b'\\x56'") // 0x56
  inspect(data[3], content="b'\\x78'") // 0x78
}

///|
test "read_uint16_le with offset" {
  let data = Array::make(8, b'\x00')
  data[2] = b'\xCD' // 0xCD
  data[3] = b'\xAB' // 0xAB
  let view = data[:]
  let result = @dataview.read_uint16_le(view, 2)
  inspect(result.to_string(radix=16), content="abcd") // 0xABCD
}

///|
test "read_uint16_be with offset" {
  let data = Array::make(8, b'\x00')
  data[2] = b'\xAB' // 0xAB
  data[3] = b'\xCD' // 0xCD
  let view = data[:]
  let result = @dataview.read_uint16_be(view, 2)
  inspect(result.to_string(radix=16), content="abcd") // 0xABCD
}

///|
test "write_uint16_le with offset" {
  let data = Array::make(8, b'\x00')
  @dataview.write_uint16_le(data.mut_view(), 3, 0xABCDU)
  inspect(data[3], content="b'\\xCD'") // 0xCD
  inspect(data[4], content="b'\\xAB'") // 0xAB
}

///|
test "write_uint16_be with offset" {
  let data = Array::make(8, b'\x00')
  @dataview.write_uint16_be(data.mut_view(), 3, 0xABCDU)
  inspect(data[3], content="b'\\xAB'") // 0xAB
  inspect(data[4], content="b'\\xCD'") // 0xCD
}

///|
test "read_uint32_le with offset" {
  let data = Array::make(12, b'\x00')
  data[4] = b'\xF0' // 0xF0
  data[5] = b'\xDE' // 0xDE
  data[6] = b'\xBC' // 0xBC
  data[7] = b'\x9A' // 0x9A
  let view = data[:]
  let result = @dataview.read_uint32_le(view, 4)
  inspect(result.to_string(radix=16), content="9abcdef0") // 0x9ABCDEF0
}

///|
test "read_uint32_be with offset" {
  let data = Array::make(12, b'\x00')
  data[4] = b'\x9A' // 0x9A
  data[5] = b'\xBC' // 0xBC
  data[6] = b'\xDE' // 0xDE
  data[7] = b'\xF0' // 0xF0
  let view = data[:]
  let result = @dataview.read_uint32_be(view, 4)
  inspect(result.to_string(radix=16), content="9abcdef0") // 0x9ABCDEF0
}

///|
test "write_uint32_le with offset" {
  let data = Array::make(12, b'\x00')
  @dataview.write_uint32_le(data.mut_view(), 5, 0x9ABCDEF0U)
  inspect(data[5], content="b'\\xF0'") // 0xF0
  inspect(data[6], content="b'\\xDE'") // 0xDE
  inspect(data[7], content="b'\\xBC'") // 0xBC
  inspect(data[8], content="b'\\x9A'") // 0x9A
}

///|
test "write_uint32_be with offset" {
  let data = Array::make(12, b'\x00')
  @dataview.write_uint32_be(data.mut_view(), 5, 0x9ABCDEF0U)
  inspect(data[5], content="b'\\x9A'") // 0x9A
  inspect(data[6], content="b'\\xBC'") // 0xBC
  inspect(data[7], content="b'\\xDE'") // 0xDE
  inspect(data[8], content="b'\\xF0'") // 0xF0
}

///|
test "read_uint16_le boundary values" {
  let data = Array::make(4, b'\x00')

  // Test with 0
  data[0] = b'\x00'
  data[1] = b'\x00'
  let view = data[:]
  let result = @dataview.read_uint16_le(view, 0)
  inspect(result.to_string(radix=16), content="0") // 0x0

  // Test with maximum value (0xFFFF)
  data[0] = b'\xFF'
  data[1] = b'\xFF'
  let result2 = @dataview.read_uint16_le(view, 0)
  inspect(result2.to_string(radix=16), content="ffff") // 0xFFFF
}

///|
test "read_uint16_be boundary values" {
  let data = Array::make(4, b'\x00')

  // Test with 0
  data[0] = b'\x00'
  data[1] = b'\x00'
  let view = data[:]
  let result = @dataview.read_uint16_be(view, 0)
  inspect(result.to_string(radix=16), content="0") // 0x0

  // Test with maximum value (0xFFFF)
  data[0] = b'\xFF'
  data[1] = b'\xFF'
  let result2 = @dataview.read_uint16_be(view, 0)
  inspect(result2.to_string(radix=16), content="ffff") // 0xFFFF
}

///|
test "write_uint16_le boundary values" {
  let data = Array::make(4, b'\x00')

  // Test with 0
  @dataview.write_uint16_le(data.mut_view(), 0, 0U)
  inspect(data[0], content="b'\\x00'") // 0x00
  inspect(data[1], content="b'\\x00'") // 0x00

  // Test with maximum value (0xFFFF)
  @dataview.write_uint16_le(data.mut_view(), 0, 0xFFFFU)
  inspect(data[0], content="b'\\xFF'") // 0xFF
  inspect(data[1], content="b'\\xFF'") // 0xFF
}

///|
test "write_uint16_be boundary values" {
  let data = Array::make(4, b'\x00')

  // Test with 0
  @dataview.write_uint16_be(data.mut_view(), 0, 0U)
  inspect(data[0], content="b'\\x00'") // 0x00
  inspect(data[1], content="b'\\x00'") // 0x00

  // Test with maximum value (0xFFFF)
  @dataview.write_uint16_be(data.mut_view(), 0, 0xFFFFU)
  inspect(data[0], content="b'\\xFF'") // 0xFF
  inspect(data[1], content="b'\\xFF'") // 0xFF
}

///|
test "read_uint32_le boundary values" {
  let data = Array::make(8, b'\x00')
  let view = data[:]

  // Test with 0
  for i = 0; i < 4; i = i + 1 {
    data[i] = b'\x00'
  }
  let result = @dataview.read_uint32_le(view, 0)
  inspect(result.to_string(radix=16), content="0") // 0x0

  // Test with maximum value (0xFFFFFFFF)
  for i = 0; i < 4; i = i + 1 {
    data[i] = b'\xFF'
  }
  let result2 = @dataview.read_uint32_le(view, 0)
  inspect(result2.to_string(radix=16), content="ffffffff") // 0xFFFFFFFF
}

///|
test "read_uint32_be boundary values" {
  let data = Array::make(8, b'\x00')
  let view = data[:]

  // Test with 0
  for i = 0; i < 4; i = i + 1 {
    data[i] = b'\x00'
  }
  let result = @dataview.read_uint32_be(view, 0)
  inspect(result.to_string(radix=16), content="0") // 0x0

  // Test with maximum value (0xFFFFFFFF)
  for i = 0; i < 4; i = i + 1 {
    data[i] = b'\xFF'
  }
  let result2 = @dataview.read_uint32_be(view, 0)
  inspect(result2.to_string(radix=16), content="ffffffff") // 0xFFFFFFFF
}

///|
test "write_uint32_le boundary values" {
  let data = Array::make(8, b'\x00')

  // Test with 0
  @dataview.write_uint32_le(data.mut_view(), 0, 0U)
  for i = 0; i < 4; i = i + 1 {
    inspect(data[i], content="b'\\x00'") // 0x00
  }

  // Test with maximum value (0xFFFFFFFF)
  @dataview.write_uint32_le(data.mut_view(), 0, 0xFFFFFFFFU)
  for i = 0; i < 4; i = i + 1 {
    inspect(data[i], content="b'\\xFF'") // 0xFF
  }
}

///|
test "write_uint32_be boundary values" {
  let data = Array::make(8, b'\x00')

  // Test with 0
  @dataview.write_uint32_be(data.mut_view(), 0, 0U)
  for i = 0; i < 4; i = i + 1 {
    inspect(data[i], content="b'\\x00'") // 0x00
  }

  // Test with maximum value (0xFFFFFFFF)
  @dataview.write_uint32_be(data.mut_view(), 0, 0xFFFFFFFFU)
  for i = 0; i < 4; i = i + 1 {
    inspect(data[i], content="b'\\xFF'") // 0xFF
  }
}

///|
test "round trip uint16_le" {
  let data = Array::make(4, b'\x00')
  let view = data[:]
  let original_value = 0x1A2BU
  @dataview.write_uint16_le(data.mut_view(), 0, original_value)
  let read_value = @dataview.read_uint16_le(view, 0)
  inspect(read_value.to_string(radix=16), content="1a2b") // 0x1A2B
}

///|
test "round trip uint16_be" {
  let data = Array::make(4, b'\x00')
  let view = data[:]
  let original_value = 0x1A2BU
  @dataview.write_uint16_be(data.mut_view(), 0, original_value)
  let read_value = @dataview.read_uint16_be(view, 0)
  inspect(read_value.to_string(radix=16), content="1a2b") // 0x1A2B
}

///|
test "round trip uint32_le" {
  let data = Array::make(8, b'\x00')
  let view = data[:]
  let original_value = 0x1A2B3C4DU
  @dataview.write_uint32_le(data.mut_view(), 0, original_value)
  let read_value = @dataview.read_uint32_le(view, 0)
  inspect(read_value.to_string(radix=16), content="1a2b3c4d") // 0x1A2B3C4D
}

///|
test "round trip uint32_be" {
  let data = Array::make(8, b'\x00')
  let view = data[:]
  let original_value = 0x1A2B3C4DU
  @dataview.write_uint32_be(data.mut_view(), 0, original_value)
  let read_value = @dataview.read_uint32_be(view, 0)
  inspect(read_value.to_string(radix=16), content="1a2b3c4d") // 0x1A2B3C4D
}
