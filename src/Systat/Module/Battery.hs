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

parseInput :: String -> IO (ModuleState, String)
parseInput input = do
  let out = tail $ head (input =~ pattern :: [[String]])
      charging = head out == "Charging"
      percent = read (out !! 1) :: Int
      time = " (" ++ out !! 2 ++ ")"
      result = (if charging then "+" else "-") ++ show percent ++ "%" ++ (if not charging then time else "")
      state = case percent of
        n | n < 10 -> Critical
          | n < 20 -> Warning
        _ -> Good

  return (state, result)

  where pattern = "Battery [0-9]: (.+), (.+)%, (.+) (remaining)?"
