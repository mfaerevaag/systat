module Systat.Modules.DateTime where

import Systat.Processor

command = "date"
args = ["+%d/%m %H:%M:%S"]

dateTime = runCommand command args
