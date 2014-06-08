module Systat.Module.DateTime (dateTime) where

import Systat.Module

dateTime :: Module
dateTime = Module {
  name    = "datetime"
, prefix  = "🕐: "
, command = "date"
, args    = ["+%d/%m %H:%M:%S"]
, parse   = \x -> return (Neutral, x)
}
