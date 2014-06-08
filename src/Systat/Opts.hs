{-# LANGUAGE DeriveDataTypeable, RecordWildCards #-}
module Systat.Opts where

import Prelude hiding (mod)
import System.Console.CmdArgs
import System.Exit
import System.Environment (getArgs, withArgs)
import Control.Monad
import Text.Printf

import Systat.Module hiding (args)

_NAME    = "systat"
_VERSION = "0.0.1"
_ABOUT   = "Tool for getting system stats"
_MODULES = [ ("datetime", "system date and time"),
             ("battery",  "battery state") ]

data SystatOpts = SystatOpts {
  mod :: Maybe ModuleType
, prefix :: Bool
, list :: Bool
, color :: Bool
} deriving (Show, Data, Typeable)

systatOpts :: SystatOpts
systatOpts = SystatOpts {
  mod    = Nothing &= typ "module" &= args
, prefix = False   &= help "Prefix output with unicode symbol"
, list   = False   &= help "List aveliable modules"
, color  = False   &= help "Use color flag"
}
  &= summary (_NAME ++ " version " ++ _VERSION)
  &= help _ABOUT
  &= helpArg [explicit, name "help", name "h"]
  &= program _NAME

optHandler :: SystatOpts -> IO SystatOpts
optHandler opts@SystatOpts {..}  = do
  -- list modules
  when list $ do
    putStrLn "Modules:"
    mapM_ (uncurry (printf "\t%s - %s\n")) _MODULES
    exitSuccess

  return opts

getOpts :: IO SystatOpts
getOpts = do
  args <- getArgs

  -- print help if no arguments
  opts <- (if null args then withArgs ["--help"] else id) $ cmdArgs systatOpts

  -- check opts
  optHandler opts
