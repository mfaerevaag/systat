{-# LANGUAGE DeriveDataTypeable, RecordWildCards #-}
module Systat.Module where

import Systat.Processor

_GREEN  = "GREEN"
_YELLOW = "YELLOW"
_RED    = "RED"

data Module = Module {
  name    :: String
, prefix  :: String
, command :: String
, args    :: [String]
, parse   :: String -> String
, state   :: Maybe ModuleState
}

instance Show Module where
  show Module {..} = name

data ModuleState = Good
                 | Warning
                 | Critical
                 deriving (Show, Eq)

runModule :: Module -> Bool -> IO String
runModule Module {..} usePrefix = do
    output <- runCommand command args
    let parsed = parse output
    let prefixed = prefix ++ parsed

    -- let colored = if useColor
    --               then addColor state prefixed
    --               else prefixed

    return (if usePrefix then prefixed else output)

addColor :: Maybe ModuleState -> String -> String
addColor state input = color ++ " " ++ input ++ " " ++ color
  where color =  case state of
          Just a -> case a of
            Good     -> _GREEN
            Warning  -> _YELLOW
            Critical -> _RED
          Nothing -> ""
