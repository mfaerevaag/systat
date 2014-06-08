{-# LANGUAGE DeriveDataTypeable, RecordWildCards #-}
module Systat.Module where

import Systat.Processor

_RED    = "\x1b[1;31m"
_GREEN  = "\x1b[1;32m"
_YELLOW = "\x1b[1;33m"
_NOC    = "\x1b[1;0m"

data Module = Module {
  name    :: String
, prefix  :: String
, command :: String
, args    :: [String]
, parse   :: String -> String
}

instance Show Module where
  show Module {..} = name

data ModuleState = Neutral
                 | Good
                 | Warning
                 | Critical
                 deriving (Show, Eq)

runModule :: Module -> Bool -> IO (ModuleState, String)
runModule Module {..} usePrefix = do
    output <- runCommand command args
    let parsed = parse output
    let prefixed = prefix ++ parsed
    let state = Good

    return (state, if usePrefix then prefixed else output)

addColor :: ModuleState -> String -> String
addColor state input = color ++ input ++ _NOC
  where color = case state of
          Good     -> _GREEN
          Warning  -> _YELLOW
          Critical -> _RED
          Neutral  -> ""
