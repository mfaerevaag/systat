module Systat.Module.DateTime (dateTime) where

import Systat.Module

dateTime :: Module
dateTime = Module {
  name    = "datetime"
, prefix  = "🕐: "
, command = "date"
, args    = ["+%d/%m %H:%M:%S"]
, parse   = id
, state   = Nothing
}

--parseInput input =