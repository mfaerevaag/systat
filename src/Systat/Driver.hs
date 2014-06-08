{-# LANGUAGE RecordWildCards #-}
module Systat.Driver (exec) where

import Prelude hiding (mod)
import System.Exit
import Data.List
import Control.Monad

import Systat.Opts
import Systat.Module
import Systat.Module.DateTime
import Systat.Module.Battery

modules :: [Module]
modules = [ dateTime, battery ]

exec :: SystatOpts -> IO ()
exec SystatOpts {..} = do
  -- list modules
  when list $ listModules >> exitSuccess

  -- run module
  (state, output) <- case find ((== mod) . show) modules of
    Just m -> runModule m prefix
    Nothing -> exitWith (ExitFailure 1)

  putStrLn $ if color then addColor state output else output
  exitSuccess

listModules :: IO ()
listModules = do
  putStrLn "Modules:"
  mapM_ (\m -> putStrLn $ "\t- " ++ show m) modules
