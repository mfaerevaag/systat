{-# LANGUAGE DeriveDataTypeable, RecordWildCards #-}
module Systat.Module where

import System.Console.CmdArgs hiding (args)

import Systat.Processor

data ModuleType = Battery
                | DateTime
                deriving (Show, Data, Typeable)

class Run a where
  run :: a -> Bool -> IO String

instance Run Module where
  run Module {..} usePrefix = do
    output <- runCommand command args
    let parsed = parse output

    return $ parse $ if usePrefix
                     then prefix ++ parsed
                     else parsed

data Module = Module {
  prefix :: String
, command :: String
, args :: [String]
, parse :: String -> String
}
