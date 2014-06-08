module Systat.Modules.DateTime (dateTime) where

import Systat.Processor

prefix  = "🕐: "
command = "date"
args    = ["+%d/%m %H:%M:%S"]

dateTime :: Bool -> IO String
dateTime usePrefix = do
  output <- runCommand command args
  return $ if usePrefix
           then prefix ++ output
           else output
