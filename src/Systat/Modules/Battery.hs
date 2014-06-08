module Systat.Modules.Battery (battery) where

import Systat.Module

battery :: Module
battery = Module {
  prefix  = "⚡: "
, command = "acpi"
, args    = ["-b"]
, parse   = id
}
