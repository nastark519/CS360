{-
    CS 360 lab 4 winter 2018
    Emmet syntax HTML generator.
    Starting code
    Nathan Stark
-}

module Main
(
main
) where

import System.IO (hFlush, stdout)
-- importing Data.Char for isAlphaNum function will be useful.
import Data.Char

-- This function is first added to complete 4.2
textReturn :: String -> String
textReturn text = ('<':text) ++ ">" ++ "</" ++ text ++ ">"

-- first added for 4.3 class functionality.
-- This will be used for the other functions as well.
split :: String -> Char -> [String]
split [] _  = []
split xs c  = splitH xs c ""

-- Helps the split function
splitH :: String -> Char -> String -> [String]
splitH [] _ ws = [ws]
splitH (x:xs) c ws
    | x == c        = [ws] ++ splitH xs c []
    | otherwise     = splitH xs c (ws++[x])

-- 4.3 Function for id.
classReturn :: [String] -> String
classReturn textc =  concat ["<", head textc, " ", "class=", "\"", last textc, "\"", ">", "</", head textc, ">"]

-- 4.4 Function for id.
idReturn :: [String] -> String
idReturn textc =  concat ["<", head textc, " ", "id=", "\"", last textc, "\"", ">", "</", head textc, ">"]

-- 4.5 Function for child.
childReturn :: [String] -> String
childReturn textc =  concat ["<", head textc, ">", textReturn(last textc), "</", head textc, ">"]

-- 4.6 Function for multiplicity.
multReturn :: [String] -> String
multReturn textc = concat $ replicate (digitToInt textm) ((textReturn (head textc)) ++ "\n")
    where textm = head (last textc)

{-
    First processing function.  This function takes the entire
    line of text from the user.

    This one obviously doesn't do what is required for the lab,
    but is just here to show you the basic I/O
-}
process :: String -> String
process text 
    | all isAlphaNum text == True = textReturn text
    | elem '.' text == True = classReturn (split text '.')
    | elem '#' text == True = idReturn (split text '#')
    | elem '>' text == True = childReturn (split text '>')
    | elem '*' text == True = multReturn (split text '*')
    | otherwise = "Didn't work try only alpha numeric characters or excepted characters(.#>*)."

{-
    The main entry point function.  Interactively expand Emmet syntax
    abbreviations and generate HTML skeleton code.  Prints HTML to standard
    output.

    Enter an empty line to quit.
-}
main :: IO ()
main = do
  putStrLn "Type Emmet abbreviations and we'll generate HTML for you"
  putStrLn "  -- to quit, hit return on an empty line"
  -- invoke a recursive main to continue to prompt the user until they wish to quit
  mainR

-- Main interactive function
mainR :: IO ()
mainR = do
  putStr "\nemmet: "
  hFlush stdout   -- line buffering prevents the prompt from printing without the newline, so this sends it
  oneLine <- getLine
  if null oneLine
    then do
      putStrLn "Exiting ..."
      return ()
    else do
      putStrLn $ process oneLine
      mainR