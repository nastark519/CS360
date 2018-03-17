
module Lab7
(length'
, convertIntToStringLeft
, convertIntToStringRight
) where

import Data.Char

-- 7.1
-- foldl (*) 6 [5,3,8]
-- 6 * 5 = 30, [5,3,8]
-- 30 * 3 = 90, [3,8]
-- 90 * 8 = 720, [8]
-- thus the return is 720

-- foldr (*) 6 [5,3,8]
-- 6 * 8 = 48, [5,3,8]
-- 48 * 3 = 144, [5,3]
-- 144 * 5 = 720, [5]
-- thus the return is 720

-- note that the _ tells the functions to ignore the type being passed.
-- 7.2
length' :: [a] -> Int
length' a = foldr (\_ x -> 1 + x) 0 a

-- I could only get it to work if I called the length function somthing other than length so I added the ' to mine.
-- *Main> length' "abcdefghijklmnopqrstuvwxyz"
-- 26
-- *Main> length "abcdefghijklmnopqrstuvwxyz"
-- 26

-- 7.3
convertIntToStringLeft :: [Int] -> [Char]
convertIntToStringLeft a = foldl (\acc x -> acc ++ [intToDigit x]) [] a

-- Prelude Data.Char> :l nStarkHaskell_2
-- [1 of 2] Compiling Lab7             ( Lab7.hs, interpreted )
-- [2 of 2] Compiling Main             ( nStarkHaskell_2.hs, interpreted )
-- Ok, 2 modules loaded.
-- *Main Data.Char> import Lab7
-- *Main Data.Char Lab7> convertIntoStringLeft [5,2,8,3,4]
-- "52834"
-- *Main Data.Char Lab7> convertIntoStringLeft []
-- ""

convertIntToStringRight :: [Int] -> [Char]
convertIntToStringRight a = foldr (\acc x -> [intToDigit acc] ++ x) [] a

-- *Main Data.Char Lab7> convertIntToStringRight [5,2,8,3,4]
-- "52834"
-- *Main Data.Char Lab7> convertIntToStringRight []
-- ""

-- 7.4
-- *Main Data.Char Lab7> length $ filter (<20) [1..100]
-- 19
-- *Main Data.Char Lab7> length (filter (<20) [1..100])
-- 19

-- *Main Data.Char Lab7> sum $ map length $ zipWith (flip (++)) ["love you", "love me"] ["i ", "you "]
-- 21
-- *Main Data.Char Lab7> sum (map length (zipWith (flip (++)) ["love you", "love me"] ["i ", "you "]))
-- 21

-- 7.5
-- mystery n x = scanr (\y acc -> (acc + y/acc)/2) 1 (replicate n x)
-- Heres what happens first we do the left most function, (replicate n x).
-- which gives us a list of length n consisting entirely of x values.
-- We then fold 1 on to the end of the list giving [...x,x,1].
-- Now we start the lambda function where we take the last value and
-- insert it in for y and the value that we want to replace in for acc.
-- thus we will have [...(x_3 + newXsub2 / x_3) / 2,newXsub2 = (x_2 + newXsub1 / x_2) / 2,newXsub1 = (x_1 + 1 / x_1) / 2,1].
