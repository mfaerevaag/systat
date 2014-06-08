{-# LANGUAGE RecordWildCards #-}
module Systat.Driver (run) where

import Prelude hiding (mod)
import System.Exit

import Systat.Opts
import Systat.Modules.DateTime
import Systat.Modules.Battery

run :: SystatOpts -> IO ()
run SystatOpts {..} = do
  output <- case mod of
    "datetime" -> dateTime prefix
    "battery" -> battery prefix
    _ -> exitWith (ExitFailure 1)

  putStr output
  exitSuccess
