{-# LANGUAGE RecordWildCards #-}
module Systat.Driver (run) where

import Prelude hiding (mod)
import System.Exit

import Systat.Opts
import Systat.Module
import Systat.Modules.DateTime
import Systat.Modules.Battery

run :: SystatOpts -> IO ()
run SystatOpts {..} = do
  output <- case mod of
    Just a -> case a of
      DateTime -> runModule dateTime prefix
      Battery -> runModule battery prefix
    Nothing -> exitWith (ExitFailure 1)

  putStr output
  exitSuccess
