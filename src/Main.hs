{-# LANGUAGE  RecordWildCards, DeriveDataTypeable #-}
module Main where

import System.Console.CmdArgs

import Systat.Driver

data SystatArgs = SystatArgs {
  command :: String
} deriving (Data, Typeable, Show)

systatArgs = cmdArgsMode $ SystatArgs {
  command = "" &= argPos 0 &= typ "device"
}
       &= summary "Systat - System stats"

main = do
  SystatArgs {..} <- cmdArgsRun systatArgs

  run command
