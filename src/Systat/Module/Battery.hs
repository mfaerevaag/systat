module Systat.Module.Battery (battery) where

import Text.Regex.Posix

import Systat.Module

battery :: Module
battery = Module {
  name    = "battery"
, prefix  = "⚡: "
, command = "acpi"
, args    = ["-b"]
, parse   = parseInput
}

parseInput :: String -> String
parseInput input =
  let out = tail $ head (input =~ pattern :: [[String]])
      state = if head out == "Charging" then "+" else "-"
      percent = out !! 1
      time = " (" ++ out !! 2 ++ ")"
  in state ++ percent ++ "%" ++ (if state == "-" then time else "")
  where pattern = "Battery [0-9]: (.+), (.+)%, (.+) (remaining)?"
