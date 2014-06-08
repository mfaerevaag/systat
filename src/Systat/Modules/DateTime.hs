module Systat.Modules.DateTime (dateTime) where

import Systat.Module

dateTime :: Module
dateTime = Module {
  prefix  = "🕐: "
, command = "date"
, args    = ["+%d/%m %H:%M:%S"]
, parse   = id
}
