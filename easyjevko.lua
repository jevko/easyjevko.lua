-- easyjevko.lua

-- Copyright (c) 2022 Darius J Chuck

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

local jevko = require "jevko"

local escape = jevko.escape

local easyjevko = { _version = "0.1.0" }

local function is_whitespace(c)
  return c == ' ' or c == '\n' or c == '\r' or c == '\t'
end

local function trim3(str)
  local i = 1
  while i <= #str do
    if is_whitespace(str:sub(i,i)) == false then break end
    i = i + 1
  end

  local j = #str
  while j > i do
    if is_whitespace(str:sub(j,j)) == false then break end
    j = j - 1
  end
  return {str:sub(1, i - 1), str:sub(i, j), str:sub(j + 1, -1)}
end

local function to_jevko(value)
  local t = type(value)
  local ret = ""

  if t == "string" then return {subjevkos = {}, suffix = value} end

  if t ~= "table" then error("Value must be of type table or string, got "..t.."!") end
 
  local subjevkos = {}
  if value[1] ~= nil then
    for _, v in ipairs(value) do
      table.insert(subjevkos, {prefix = "", jevko = to_jevko(v)})
    end
  else
    if value[""] then error("Empty key in table!") end
    for k, v in pairs(value) do
      local kt = type(k)
      if (kt ~= "string") then error("Nonstring key type: "..kt.."!") end
      local tr = trim3(k)
      if tr[1] ~= "" or tr[3] ~= "" then error("Leading or trailing space in key: |"..k.."|") end
      table.insert(subjevkos, {prefix = k, jevko = to_jevko(v)})
    end
  end
  if #subjevkos == 0 then error("Empty table!") end
  return {subjevkos = subjevkos, suffix = ""}
end

local function from_jevko(jevko)
  local subjevkos = jevko.subjevkos
  local suffix = jevko.suffix

  if #subjevkos == 0 then return suffix end

  local tr = trim3(suffix)

  if tr[2] ~= "" then error("Nonempty suffix!") end

  local prefix = subjevkos[1].prefix
  local prefixTr = trim3(prefix)
  local ret = {}
  if prefixTr[2] == "" then
    for _, v in ipairs(subjevkos) do
      local prefix = v.prefix
      local jevko = v.jevko
      local prefixTr = trim3(prefix)
      if prefixTr[2] ~= "" then error("Nonempty prefix (jevko->array)!") end
      table.insert(ret, from_jevko(jevko, keys))
    end
  else
    for _, v in ipairs(subjevkos) do
      local prefix = v.prefix
      local jevko = v.jevko
      local prefixTr = trim3(prefix)
      local key = prefixTr[2]
      if ret[key] ~= nil then error("Duplicate key "..key.."!") end
      ret[key] = from_jevko(jevko, nkeys)
    end
  end

  return ret
end

local function escape_prefix(prefix)
  if prefix == "" then
    return ""
  else
    return escape(prefix).." "
  end
end

local function recur(jevko, indent, prevIndent)
  local subjevkos = jevko.subjevkos
  local ret = ""
  
  if #subjevkos > 0 then
    ret = ret.."\n"
    for _, v in ipairs(subjevkos) do
      local prefix = v.prefix
      local jevko = v.jevko
      ret = ret..indent..escape_prefix(prefix).."["..recur(jevko, indent.."  ", indent).."]\n"
    end
    ret = ret..prevIndent
  end

  return ret .. escape(jevko.suffix)
end

local function stringify_jevko_pretty(jevko, indent)
  local subjevkos = jevko.subjevkos
  local suffix = jevko.suffix

  local ret = ""
  for _, v in ipairs(subjevkos) do
    local prefix = v.prefix
    local jevko = v.jevko
    ret = ret..escape_prefix(prefix).."["..recur(jevko, "  ", "").."]\n"
  end
  return ret..escape(suffix)
end

local function to_string(value)
  return jevko.to_string(to_jevko(value))
end
local function to_pretty_string(value)
  return stringify_jevko_pretty(to_jevko(value))
end
local function from_string(str)
  return from_jevko(jevko.from_string(str))
end

easyjevko.from_jevko = from_jevko
easyjevko.to_jevko = to_jevko
easyjevko.to_string = to_string
easyjevko.to_pretty_string = to_pretty_string
easyjevko.from_string = from_string
easyjevko.encode_pretty = stringify_jevko_pretty

return easyjevko