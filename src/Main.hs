{-# LANGUAGE RecordWildCards #-}
module Main where

import Prelude hiding (mod)
import System.Environment (getArgs, withArgs)

import Systat.Opts
import Systat.Driver

main :: IO ()
main = do
    args <- getArgs

    -- print help if no arguments
    opts <- (if null args then withArgs ["--help"] else id) getOpts

    optHandler opts

    run opts
