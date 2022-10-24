![easyjevko.lua logo](logo.svg)

# easyjevko.lua

A single-file library for Easy Jevko, a simple format built on [Jevko](https://jevko.org). 

Transforms Jevko to Lua values and back.

# Features

* Simple
* Lightweight: ~ 4 KiB.

<!-- * provides error messages with line and column information. -->

# Usage

Copy the [easyjevko.lua](jevko.lua?raw=1) file into your project and require it:

```lua
easyjevko = require "easyjevko"
```

You can now use the following functions:

## easyjevko.from_jevko(jevko)

## easyjevko.to_jevko(value)

## easyjevko.encode_pretty(jev)

<!-- Same as [`jevko.encode`](#jevkoencode_prettyjev), except adds whitespace [[todo]]. -->

# License

[MIT](LICENSE)