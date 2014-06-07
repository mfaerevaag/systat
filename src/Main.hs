{-# LANGUAGE  RecordWildCards, DeriveDataTypeable #-}
module Main where

import Prelude hiding (mod)
import System.Console.CmdArgs

import Systat.Driver

data SystatArgs = SystatArgs {
  mod  :: String
, list :: Bool
} deriving (Data, Typeable, Show)

systatArgs = cmdArgsMode $ SystatArgs {
  mod = "" &= argPos 0 &= typ "module"
, list = False &= help "List aveliable modules"
}
       &= summary "Systat - System stats"

main = do
  SystatArgs {..} <- cmdArgsRun systatArgs

  if list
    then do
         putStrLn "Modules:"
         putStrLn "\tdatetime"
    else run mod
