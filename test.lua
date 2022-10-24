local easyjevko = loadfile("./easyjevko.lua")()
local jevko = loadfile("./jevko.lua")()

local parsed = jevko.decode([[
first name [John]
last name [Smith]
is alive [true]
age [27]
address [
  street address [21 2nd Street]
  city [New York]
  state [NY]
  postal code [10021-3100]
]
phone numbers [
  [
    type [home]
    number [212 555-1234]
  ]
  [
    type [office]
    number [646 555-4567]
  ]
]
children []
spouse []
]])

local expected = [[

  street address [21 2nd Street]
  city [New York]
  state [NY]
  postal code [10021-3100]
]]

local actual = easyjevko.from_jevko(parsed, {})
assert(actual["first name"] == "John")
assert(actual["last name"] == "Smith")
local address = actual["address"]
assert(address["street address"] == "21 2nd Street")
assert(address["city"] == "New York")
assert(address["state"] == "NY")
assert(address["postal code"] == "10021-3100")
local phone_numbers = actual["phone numbers"]
assert(phone_numbers[1]["type"] == "home")
assert(phone_numbers[1]["number"] == "212 555-1234")
assert(phone_numbers[2]["type"] == "office")
assert(phone_numbers[2]["number"] == "646 555-4567")
assert(actual["children"] == "")
assert(actual["spouse"] == "")

local je = easyjevko.to_jevko(actual)
local pretty = easyjevko.encode_pretty(je)
local parsed_pretty = jevko.encode(parsed)

local lines = {}
for line in string.gmatch(pretty, "[^\n]+") do
  lines[line] = true
end
for line2 in string.gmatch(parsed_pretty, "[^\n]+") do
  assert(lines[line2] == true, "|"..line2.."|")
end
-- assert(actual == expected, actual)