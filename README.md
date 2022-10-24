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

## easyjevko.to_string(value)

## easyjevko.to_pretty_string(value)

## easyjevko.from_jevko(jevko)

## easyjevko.to_jevko(value)

## easyjevko.encode_pretty(jev)

<!-- Same as [`jevko.encode`](#jevkoencode_prettyjev), except adds whitespace [[todo]]. -->

# License

[MIT](LICENSE)