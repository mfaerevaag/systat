{-# LANGUAGE DeriveDataTypeable, RecordWildCards #-}
module Systat.Module (
  Module (..)
, ModuleType (..)
, runModule
) where

import System.Console.CmdArgs hiding (args)

import Systat.Processor

data ModuleType = Battery
                | DateTime
                deriving (Show, Data, Typeable)

data Module = Module {
  prefix :: String
, command :: String
, args :: [String]
, parse :: String -> String
}

runModule :: Module -> Bool -> IO String
runModule Module {..} usePrefix = do
  output <- runCommand command args
  let parsed = parse output

  return $ parse $ if usePrefix
                   then prefix ++ parsed
                   else parsed
