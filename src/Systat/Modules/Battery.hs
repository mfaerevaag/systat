module Systat.Modules.Battery (battery) where

import Systat.Processor

prefix  = "⚡: "
command = "acpi"
args    = ["-b"]

battery :: Bool -> IO String
battery usePrefix = do
  output <- runCommand command args
  return $ if usePrefix
           then prefix ++ output
           else output
