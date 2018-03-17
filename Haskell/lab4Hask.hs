{-
    CS 360 lab 4
    Emmet syntax HTML generator.
    Nathan Stark
    Worked with Dekoda, Korben, Jazmin, and Katie
    run from ghc -> ghc lab4Hask.hs -o lab4
-}

module Main
(
main
) where

import System.IO (hFlush, stdout)
import Data.Char

-- using the given code from class.
{-
    Split a string on a specific character, producing a list of strings, i.e.
    split "0c:4d:e9:a5:09:7b" ':' == ["0c","4d","e9","a5","09","7b"]
-}
split :: String -> Char -> [String]
split [] _  = []
split xs c  = splitH xs c ""

-- Helps the split function
splitH :: String -> Char -> String -> [String]
splitH []     _ ws  = [ws]
splitH (x:xs) c ws
    | x == c        = [ws] ++ splitH xs c []
    | otherwise     = splitH xs c (ws++[x])


textReturn :: String -> String
textReturn tex = ('<':tex) ++ ">" ++ "</" ++ tex ++ ">"

classReturn :: [String] -> String
classReturn textc =  concat ["<", head textc, " ", "class=", "\"", last textc, "\"", ">", "</", head textc, ">"]

idReturn :: [String] -> String
idReturn textc =  concat ["<", head textc, " ", "id=", "\"", last textc, "\"", ">", "</", head textc, ">"]

childReturn :: [String] -> String
childReturn textc =  concat ["<", head textc, ">", textReturn(last textc), "</", head textc, ">"]

multReturn :: [String] -> String
multReturn textc = concat $ replicate (digitToInt textm) ((textReturn (head textc)) ++ "\n")
    where textm = head (last textc)


check :: String -> Bool
check [] = True
check (x:xs)
    | isAlphaNum x = check xs
    | x == '.' = check xs
    | x == '#' = check xs
    | x == '>' = check xs
    | x == '*' = check xs
    | otherwise = False

-- result :: Bool -> Bool
-- result b = 

{-
    First processing function.  This function takes the entire
    line of text from the user.

    This one obviously doesn't do what is required for the lab,
    but is just here to show you the basic I/O
-}
process :: String -> String
process text 
    | all isAlphaNum text && result == True = textReturn text
    | '.' `elem` text && result == True = classReturn (split text '.')
    | '#' `elem` text && result == True = idReturn (split text '#')
    | '>' `elem` text && result == True = childReturn (split text '>')
    | '*' `elem` text && result == True = multReturn (split text '*')
    | otherwise = "must be alpha numeric or (.), (#), (>), (*) with 0-9 digit"
    where result = check text



-- | all isAlphaNum text == True = textReturn text
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