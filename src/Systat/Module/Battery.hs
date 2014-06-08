module Systat.Module.Battery (battery) where

--import Text.Regex.Posix

import Systat.Module

battery :: Module
battery = Module {
  name    = "battery"
, prefix  = "⚡: "
, command = "acpi"
, args    = ["-b"]
, parse   = id
, state   = Nothing
}

-- parseInput :: String -> String
-- parseInput input = do
--   reg <- input =~ pattern :: String
--   putStrLn reg
--   return input
--   where pattern = "Battery [0-9]: (.+), (.+)%, (.+) (remaining)?"
