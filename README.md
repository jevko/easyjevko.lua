![easyjevko.lua logo](logo.svg)

# easyjevko.lua

A library for Easy Jevko, a simple format built on [Jevko](https://jevko.org). 

Transforms Jevko to Lua values and back.

# Dependencies

[jevko.lua](https://github.com/jevko/jevko.lua) `0.1.0` -- [a copy](jevko.lua?raw=1) is included.

# Features

* Simple
* Lightweight: ~ 4 KiB.

<!-- * provides error messages with line and column information. -->

# Usage

Copy the [easyjevko.lua](easyjevko.lua?raw=1) file into your project and require it:

```lua
easyjevko = require "easyjevko"
```

You can now use the following functions:

## easyjevko.from_string(str)

Input: string which contains a Jevko.

Description:

* A Jevko without subjevkos is converted to a string.
* A Jevko with subjevkos is converted to a table. The first subjevko decides the kind of table:
  * If the first subjevko has empty or whitespace-only prefix then the Jevko will be converted to an array.
  * Otherwise the Jevko will be converted to a map.
* Leading and trailing spaces in object keys are ignored.

Output: Lua table/string.

```js
easyjevko.from_string("a [b]") // -> {a = "b"}
```

## easyjevko.to_string(value)

## easyjevko.to_pretty_string(value)

## easyjevko.from_jevko(jevko)

## easyjevko.to_jevko(value)

## easyjevko.encode_pretty(jev)

<!-- Same as [`jevko.encode`](#jevkoencode_prettyjev), except adds whitespace [[todo]]. -->

# License

[MIT](LICENSE)