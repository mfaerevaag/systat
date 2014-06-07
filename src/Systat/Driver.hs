module Systat.Driver ( run ) where

import Systat.Processor

run :: String -> IO ()
run command = do
  output <- runCommand command []

  putStr output
