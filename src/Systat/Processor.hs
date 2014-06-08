module Systat.Processor (runCommand) where

import System.Process hiding (runCommand)
import System.Exit
import Text.Printf
import Data.Text

processData :: String -> String
processData = unpack . strip . pack

runCommand :: String -> [String] -> IO String
runCommand command args = do
  (exit, out, err) <- readProcessWithExitCode command args ""
  case exit of
    ExitSuccess -> return $ processData out
    ExitFailure ret -> do
                       printf "Error (%i): %s" ret err
                       exitWith (ExitFailure 1)
