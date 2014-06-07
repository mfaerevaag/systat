module Systat.Driver ( run ) where

import Prelude hiding (mod)
import System.Exit

import Systat.Modules.DateTime

run :: String -> IO ()
run mod = do
  output <- case mod of
    "datetime" -> dateTime
    _ -> do
      putStrLn "Module not found"
      putStrLn "use --list option to get possible modules"
      exitWith (ExitFailure 1)

  putStr output
  exitSuccess
