module Main where

import Prelude hiding (mod)

import Systat.Opts
import Systat.Driver

main :: IO ()
main = do
    opts <- getOpts

    run opts
