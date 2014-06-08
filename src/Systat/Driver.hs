{-# LANGUAGE RecordWildCards #-}
module Systat.Driver (exec) where

import Prelude hiding (mod)
import System.Exit

import Systat.Opts
import Systat.Module
import Systat.Modules.DateTime
import Systat.Modules.Battery

exec :: SystatOpts -> IO ()
exec SystatOpts {..} = do
  output <- case mod of
    Just a -> case a of
      DateTime -> run dateTime prefix
      Battery -> run battery prefix
    Nothing -> exitWith (ExitFailure 1)

  putStr output
  exitSuccess
