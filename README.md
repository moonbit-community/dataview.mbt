# DataView for MoonBit

A comprehensive MoonBit implementation of JavaScript's DataView API for binary data manipulation. This library provides a way to read and write multi-byte numeric values in MutArrayView[Byte] with control over byte order (endianness).

## Features

- **Complete DataView API**: All standard JavaScript DataView methods
- **Endianness Support**: Read/write in both big-endian and little-endian byte order
- **Type Safety**: Full MoonBit type safety with proper error handling
- **Multiple Data Types**: Support for Int8, UInt8, Int16, UInt16, Int32, UInt32, Float32, Float64
- **Memory Efficient**: Uses MutArrayView[Byte] for writable zero-copy operations and ArrayView[Byte] for read-only views
- **Modular Design**: Clean separation of concerns across multiple files

## Installation

Add this package to your MoonBit project:

```bash
moon add illusory0x0/dataview
```

Then import it in your `moon.pkg.json`:

```json
{
  "import": ["illusory0x0/dataview"]
}
```

## Basic Usage

```moonbit
// Create some binary data
let data : Array[Byte] = [0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07]

// Create a DataView
let view = DataView::new(data.mut_view())

// Read/write 8-bit values
let byte_value = view.get_uint8(0)  // Returns 0
view.set_uint8(0, 255U)

// Read/write 16-bit values with endianness control
let value16_be = view.get_uint16(0, little_endian~=false)  // Big-endian
let value16_le = view.get_uint16(0, little_endian~=true)   // Little-endian

// Read/write 32-bit values
view.set_uint32(0, 0x12345678U, little_endian~=false)
let value32 = view.get_uint32(0, little_endian~=false)

// Read/write floating point values
view.set_float32(0, 3.14F, little_endian~=false)
let float_val = view.get_float32(0, little_endian~=false)

// Double precision floating point
view.set_float64(0, 3.141592653589793, little_endian~=false)
let double_val = view.get_float64(0, little_endian~=false)
```

## API Reference

### Constructor Methods

#### `DataView::new(data: MutArrayView[Byte], offset~: Int = 0) -> DataView`
Creates a new DataView from a MutArrayView[Byte] with optional offset.

#### `DataView::from_bytes(data: MutArrayView[Byte], offset~: Int = 0, length~: Int? = None) -> DataView`
Creates a DataView with specified offset and optional length limit.

### Properties

#### `DataView::byte_length(self: DataView) -> Int`
Returns the length of the DataView in bytes.

#### `DataView::byte_offset(self: DataView) -> Int`
Returns the offset of this DataView.

### 8-bit Integer Methods

#### `DataView::get_int8(self: DataView, byte_offset: Int) -> Int`
Reads a signed 8-bit integer at the specified offset.

#### `DataView::set_int8(self: DataView, byte_offset: Int, value: Int) -> Unit`
Writes a signed 8-bit integer at the specified offset.

#### `DataView::get_uint8(self: DataView, byte_offset: Int) -> UInt`
Reads an unsigned 8-bit integer at the specified offset.

#### `DataView::set_uint8(self: DataView, byte_offset: Int, value: UInt) -> Unit`
Writes an unsigned 8-bit integer at the specified offset.

### 16-bit Integer Methods

#### `DataView::get_int16(self: DataView, byte_offset: Int, little_endian~: Bool = false) -> Int`
Reads a signed 16-bit integer with specified endianness.

#### `DataView::set_int16(self: DataView, byte_offset: Int, value: Int, little_endian~: Bool = false) -> Unit`
Writes a signed 16-bit integer with specified endianness.

#### `DataView::get_uint16(self: DataView, byte_offset: Int, little_endian~: Bool = false) -> UInt`
Reads an unsigned 16-bit integer with specified endianness.

#### `DataView::set_uint16(self: DataView, byte_offset: Int, value: UInt, little_endian~: Bool = false) -> Unit`
Writes an unsigned 16-bit integer with specified endianness.

### 32-bit Integer Methods

#### `DataView::get_int32(self: DataView, byte_offset: Int, little_endian~: Bool = false) -> Int`
Reads a signed 32-bit integer with specified endianness.

#### `DataView::set_int32(self: DataView, byte_offset: Int, value: Int, little_endian~: Bool = false) -> Unit`
Writes a signed 32-bit integer with specified endianness.

#### `DataView::get_uint32(self: DataView, byte_offset: Int, little_endian~: Bool = false) -> UInt`
Reads an unsigned 32-bit integer with specified endianness.

#### `DataView::set_uint32(self: DataView, byte_offset: Int, value: UInt, little_endian~: Bool = false) -> Unit`
Writes an unsigned 32-bit integer with specified endianness.

### Floating Point Methods

#### `DataView::get_float32(self: DataView, byte_offset: Int, little_endian~: Bool = false) -> Float`
Reads a 32-bit IEEE 754 floating point number.

#### `DataView::set_float32(self: DataView, byte_offset: Int, value: Float, little_endian~: Bool = false) -> Unit`
Writes a 32-bit IEEE 754 floating point number.

#### `DataView::get_float64(self: DataView, byte_offset: Int, little_endian~: Bool = false) -> Double`
Reads a 64-bit IEEE 754 floating point number.

#### `DataView::set_float64(self: DataView, byte_offset: Int, value: Double, little_endian~: Bool = false) -> Unit`
Writes a 64-bit IEEE 754 floating point number.

### Utility Methods

#### `DataView::get_bytes(self: DataView, start: Int, length: Int) -> ArrayView[Byte]`
Returns a subview of bytes from the DataView.

#### `DataView::copy(self: DataView) -> DataView`
Creates an independent copy of the DataView.

#### `DataView::to_string(self: DataView) -> String`
Returns a string representation of the DataView.

## Endianness

All multi-byte read/write operations support endianness control:

- **Big-endian** (default): Most significant byte first
- **Little-endian**: Least significant byte first

```moonbit
let data = [0x12, 0x34, 0x56, 0x78]
let view = DataView::new(data.mut_view())

// Big-endian: 0x12345678
let big_endian = view.get_uint32(0, little_endian~=false)

// Little-endian: 0x78563412  
let little_endian = view.get_uint32(0, little_endian~=true)
```

## Error Handling

The DataView implementation includes comprehensive bounds checking. Operations that exceed the buffer boundaries will call `abort()` with descriptive error messages:

- "DataView offset out of bounds"
- "DataView access out of bounds" 
- "DataView length cannot be negative"
- "DataView byte_offset cannot be negative"
- "DataView byte_size must be positive"
- "DataView length + offset exceeds data bounds"
- "DataView get_bytes out of bounds"

## Project Structure

The implementation is organized across several focused modules:

- **`dataview.mbt`** - Core DataView struct definition and constructor methods
- **`integer_ops.mbt`** - All integer operations (8-bit, 16-bit, 32-bit)
- **`float_ops.mbt`** - Floating point operations (32-bit and 64-bit)
- **`endian_helpers.mbt`** - Endianness conversion helper functions
- **`utilities.mbt`** - Utility methods and string representation
- **`dataview.mbti`** - Type interface definitions

## Compatibility

This implementation aims to be compatible with JavaScript's DataView API while following MoonBit conventions and type safety principles. The API closely mirrors the JavaScript DataView specification with appropriate adaptations for MoonBit's type system.

## Contributing

Contributions are welcome! Please ensure that any changes maintain compatibility with the JavaScript DataView API and follow MoonBit best practices.

## License

Apache-2.0
