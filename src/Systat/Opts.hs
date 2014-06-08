{-# LANGUAGE DeriveDataTypeable, RecordWildCards #-}
module Systat.Opts where

import Prelude hiding (mod)
import System.Console.CmdArgs
import System.Environment (getArgs, withArgs)

_NAME    = "systat"
_VERSION = "0.0.1"
_ABOUT   = "Tool for getting system stats"

data SystatOpts = SystatOpts {
  mod :: String
, prefix :: Bool
, list :: Bool
, color :: Bool
} deriving (Show, Data, Typeable)

systatOpts :: SystatOpts
systatOpts = SystatOpts {
  mod    = ""    &= typ "module" &= args
, prefix = False &= help "Prefix output with unicode symbol"
, list   = False &= help "List aveliable modules"
, color  = False &= help "Use color flag"
}
  &= summary (_NAME ++ " version " ++ _VERSION)
  &= help _ABOUT
  &= helpArg [explicit, name "help", name "h"]
  &= program _NAME

optHandler :: SystatOpts -> IO SystatOpts
optHandler opts@SystatOpts {..}  = do
  -- check opts

  return opts

getOpts :: IO SystatOpts
getOpts = do
  args <- getArgs

  -- print help if no arguments
  opts <- (if null args then withArgs ["--help"] else id) $ cmdArgs systatOpts

  -- check opts
  optHandler opts
