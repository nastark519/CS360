

-- Nathan Stark
--
-- CS 360 Winter 2018
-- Haskell lab 2

import Lab7

-- 5.1
gcdMine :: Integral a => a -> a -> a
gcdMine x y = if y == 0 then x else (gcdMine y (x `mod` y))

gcdCheck x y = (myAnswer, correctAnswer, comment)
  where 
    myAnswer      = gcdMine x y
    correctAnswer = gcd x y
    comment       = if myAnswer == correctAnswer then "Matches" else "Does not Match"
-- *Main> gcdCheck 45 3
-- (3,3,"Matches")
-- *Main> gcdCheck 3 45
-- (3,3,"Matches")
-- *Main> gcdCheck 7 45
-- (1,1,"Matches")
-- *Main> gcdCheck 45 7
-- (1,1,"Matches")

-- 5.2
fibonacci :: Int -> Int
fibonacci 0 = 0
fibonacci 1 = 1
fibonacci x = (fibonacci (x - 1) + fibonacci(x -2))

-- *Main> [fibonacci n | n <- [0..20]] == [0,1,1,2,3,5,8,13,21,34,55,89,144,233,377,610,987,1597,2584,4181,6765]
-- True
-- *Main> [fibonacci n | n <- [0..20]]
-- [0,1,1,2,3,5,8,13,21,34,55,89,144,233,377,610,987,1597,2584,4181,6765]

-- 5.3
count :: (Eq a, Num b) => a -> [a] -> b
count x [] = 0
count x xList
    | x == head xList  = 1 + (count x (tail xList))
    | otherwise = count x (tail xList)

-- *Main> count 7 [1,7,6,2,7,7,9] == 3
-- True
-- *Main> count 'w' "western oregon wolves" == 2
-- True
-- *Main> count 'h' "How was your day"
-- 0
-- the last one is because the H is uppercase in the list

-- 5.5
sanitize :: [Char] -> [Char]
sanitize p
    | length p == 0 = ""
    | length p == 1 = if(head p == ' ') then "%20" else p
    | head p == ' ' = sanitize ("%20" ++ (tail p))
    | otherwise = ((head p):(sanitize (tail p)))

-- *Main> sanitize "Do you think that this will work?"
-- "Do%20you%20think%20that%20this%20will%20work?"
-- *Main> sanitize "It            worked"
-- "It%20%20%20%20%20%20%20%20%20%20%20%20worked"

-- 6.1.b
function61b :: Int -> [Int]
function61b x = map (* 2) [1..x]
-- dont run this okay.
infinite2PwoerList = map (* 2) [1..]

-- *Main> function61b 3
-- [2,4,6]
-- *Main> function61b 10
-- [2,4,6,8,10,12,14,16,18,20]
-- *Main> function61b 20
-- [2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40]
-- *Main> function61b 40
-- [2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54,56,58,60,62,64,66,68,70,72,74,76,78,80]

-- 6.1.c
-- function61c :: [a] -> [a] again this heading I think should work
function61c x = map succ x

-- *Main> function61c [1,2,3,6,84,3,4,16]
-- [2,3,4,7,85,4,5,17]
-- *Main> function61c "Hello"
-- "Ifmmp"

-- 6.1.g
mod42Check :: Int -> Bool
mod42Check a = (a `mod` 42) == 0

-- function61g :: [Int] -> Bool I need to find out why these aren't working
function61g x = any mod42Check x

-- *Main> function61g [400,50,20,45]
-- False
-- *Main> function61g [400,50,20,84]
-- True

-- 6.1.k
checkForEven :: Int -> Bool
checkForEven x = (x `mod` 2) == 0

function61k :: [Int] -> Bool
function61k x = all checkForEven x

-- *Main> function61k [1,2,3,4]
-- False
-- *Main> function61k [2,4,44,50]
-- True

-- 6.1.l
function61l :: [String] -> [String]
function61l x = map ("not " ++) x

-- *Main> function61l ["Funny","cold","slow","dark"]
-- ["not Funny","not cold","not slow","not dark"]

-- 6.2.b
function62b :: (Num a) => a -> a
function62b y =(\x -> x * 4) y

-- *Main> function62b  5
-- 20

-- 6.2.c
function62c :: [a] -> a
function62c x = head ((\y -> tail y) x)

-- *Main> function62c [1,2,3,4,5,6]
-- 2
-- *Main> function62c [1,3,4,5,6]
-- 3

-- 6.4
findC :: (Double, Double) -> Double
findC a = sqrt ((fst a)^2 + (snd a)^2)

addToTuple :: (Double, Double) -> (Double, Double, Double)
addToTuple x = (fst x, snd x, findC x)

function64 :: [(Double, Double)] -> [(Double, Double, Double)]
function64 x = (\y -> map addToTuple y) x

-- *Main> function64 [(3,4),(5,16),(9.4,2)]
-- [(3.0,4.0,5.0),(5.0,16.0,16.76305461424021),(9.4,2.0,9.610411021387172)]
-- *Main> function64 [(3,4),(5,16),(9.4,2)] == [(3.0,4.0,5.0),(5.0,16.0,16.76305461424021),(9.4,2.0,9.610411021387172)]
-- True