{-# LANGUAGE DeriveDataTypeable, RecordWildCards #-}
module Systat.Opts where

import Prelude hiding (mod)
import System.Console.CmdArgs
import System.Exit
import System.Environment (getArgs, withArgs)
import Control.Monad (when, unless)
import Text.Printf

_NAME    = "systat"
_VERSION = "0.0.1"
_ABOUT   = "Tool for getting system stats"
_MODULES = [ ("datetime", "system date and time") ]

data SystatOpts = SystatOpts {
  mod :: String
, list :: Bool
, color :: Bool
} deriving (Data, Typeable, Show)

systatOpts :: SystatOpts
systatOpts = SystatOpts {
  mod   = def   &= typ "module" &= args
, list  = False &= help "List aveliable modules"
, color = False &= help "Use color"
}
  &= summary (_NAME ++ " version " ++ _VERSION)
  &= help _ABOUT
  &= helpArg [explicit, name "help", name "h"]
  &= program _NAME

optHandler :: SystatOpts -> IO ()
optHandler SystatOpts {..}  = do
  when list $ do
    putStrLn "Modules:"
    mapM_ (uncurry (printf "\t%s - %s\n")) _MODULES
    exitSuccess

  when (null mod) $ putStrLn "Error: No module given" >> exitWith (ExitFailure 1)

  unless (mod `elem` map fst _MODULES) $ do
    putStrLn $ "Error: Module '" ++ mod ++ "' not found"
    putStrLn "use --list option to get possible modules"
    exitWith (ExitFailure 1)

getOpts :: IO SystatOpts
getOpts = do
  args <- getArgs

  -- print help if no arguments
  opts <- (if null args then withArgs ["--help"] else id) $ cmdArgs systatOpts

  -- check opts
  optHandler opts

  return opts
