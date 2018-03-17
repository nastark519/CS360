



-- Nathan Stark
-- Winter CS360
-- Haskell Lab 1

-- 1.3
lab13 = sqrt 818281336460929553769504384519009121840452831049
-- *Maint> lab13
-- 9.045890428592033e23

-- 1.4
lab14 = pred 'A'
-- *Main> lab14
-- '@'

-- 1.5
lab15 :: Int -> Bool
lab15 a = ( 3 * a + 1) `mod` 2 == 0
-- *Main> lab15 4
-- False
-- *Main> lab15 3
-- True

-- 2.2
lab22 = product [1,3..100]
-- *Main> lab22
-- 2725392139750729502980713245400918633290796330545803413734328823443106201171875

-- 2.3
lab23 :: Ord t => [t] -> t
lab23 a = maximum ( tail ( init a))
-- *Main> lab23 [99,23,4,2,67,82,49,-40]
-- 82
-- *Main>

-- 2.4
lab24 = 6:19:41:(-3):[]
-- *Main> lab24
-- [6,19,41,-3]

-- 2.5.1
lab25_1 = take 27 [x | x <- [1..], even x]
-- *Main> lab25_1
-- [2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54]

-- 2.5.2
lab25_2 = [x | x <- [200,199..1], odd x, x `mod` 3 == 0, x `mod` 7 == 0]
-- *Main> lab25_2
-- [189,147,105,63,21]
-- with the assumption that you ment all the numbers between 200 and 1.
-- Otherwise it is an infinite list. and the code is below
-- dontRun = [x | x <- [200,199..], odd x, x `mod` 3 == 0, x `mod` 7 == 0]

-- 2.5.3
lab25_3 = length ([x | x<- [100,101..200], odd x, x `mod` 9 == 0])
-- *Main> lab25_3
-- 5

-- 2.5.5
lab25_4 y = length ([x | x <- y, x < 0])
-- *Main> lab25_4 [2,-3,3,5.2,-4]
-- 2

-- 2.6
lab26 = zip [0..15] (['0'..'9'] ++ ['A'..'F'])
-- *Main> lab26
-- [(0,'0'),(1,'1'),(2,'2'),(3,'3'),(4,'4'),(5,'5'),(6,'6'),(7,'7'),(8,'8'),(9,'9'),(10,'A'),(11,'B'),(12,'C'),(13,'D'),(14,'E'),(15,'F')]

-- makeList :: Int a => a -> [a] don't know why this wont work
makeList y = if (y >= 1) then [[1..x] | x <- [1..y]] else []
-- *Main> makeList 4
-- [[1],[1,2],[1,2,3],[1,2,3,4]]
-- *Main> makeList -2

-- <interactive>:23:1: error:
--    * Non type-variable argument in the constraint: Num (a -> [[a]])
--      (Use FlexibleContexts to permit this)
--    * When checking the inferred type
--        it :: forall a.
--              (Ord a, Num (a -> [[a]]), Num a, Enum a) =>
--              a -> [[a]]
-- *Main> makeList (-2)
-- []

-- 3.2
sanitize :: [Char] -> [Char]
sanitize p = [ x | w <- p, x <- if(w == ' ') then "%20" else [w]]
-- *Main> sanitize "http://wou.edu/my homepage/I love spaces.html" == "http://wou.edu/my%20homepage/I%20love%20spaces.html"
-- True
-- *Main> sanitize "http://wou.edu/my homepage/I love spaces.html"
-- "http://wou.edu/my%20homepage/I%20love%20spaces.html"

-- 3.4

-- Prelude Data.List> :t intersperse
-- intersperse :: a -> [a] -> [a]

-- Prelude Data.List> :t null
-- null :: Foldable t => t a -> Bool

-- Prelude Data.List> :t (++)
-- (++) :: [a] -> [a] -> [a]

-- Prelude> :t div
-- div :: Integral a => a -> a -> a

-- Prelude> :t take
-- take :: Int -> [a] -> [a]


-- 4.1.a
getSuit :: Int -> String
getSuit 0 = "Heart"
getSuit 1 = "Diamond"
getSuit 2 = "Spade"
getSuit 3 = "Club"
getSuit x = error "try 0,1,2, or 3"
-- *Main Data.List> getSuit 7
-- "*** Exception: try 0,1,2, or 3
-- CallStack (from HasCallStack):
--   error, called at nStarkHaskell_1.hs:112:13 in main:Main
-- *Main Data.List> getSuit 2
-- "Spade"
-- *Main Data.List> getSuit 3
-- "Club"
-- *Main Data.List> getSuit 0
-- "Heart"
-- *Main Data.List> getSuit 1
-- "Diamond"

-- 4.1.b
dotProduct :: (Double,Double,Double) -> (Double,Double,Double) -> Double
dotProduct (xa,xb,xc) (ya,yb,yc) = xa * ya + xb * yb + xc * yc
-- *Main Data.List> dotProduct (3,4,5) (2,7,3)
-- 49.0

-- 4.1.c
reverseFirstThree :: [a] -> [a]
reverseFirstThree [] = []
reverseFirstThree [b] = [b]
reverseFirstThree [a,b] = [b,a]
reverseFirstThree (a:b:c:aList) = [c,b,a] ++ aList
-- *Main Data.List> reverseFirstThree []
-- []
-- *Main Data.List> reverseFirstThree [3]
-- [3]
-- *Main Data.List> reverseFirstThree [3,5]
-- [5,3]
-- *Main Data.List> reverseFirstThree [3,5,7]
-- [7,5,3]
-- *Main Data.List> reverseFirstThree [3,5,7,9,8,6,4,2,1]
-- [7,5,3,9,8,6,4,2,1]

--4.2.a
feelsLike :: Double -> String
feelsLike tmpt
    | tmpt <= 32 = "frostbite central!"
    | tmpt <= 42 = "Its cold."
    | tmpt <= 70 = "Its not as cold."
    | tmpt <= 82 = "Feels good good here."
    | otherwise = "Its hot, as not in a sexual way."
-- *Main Data.List> feelsLike 4
-- "frostbite central!"
-- *Main Data.List> feelsLike 40
-- "Its cold."
-- *Main Data.List> feelsLike 49
-- "Its not as cold."
-- *Main Data.List> feelsLike 460
-- "Its hot, as not in a sexual way."

-- 4.2.b
feelsLike2 :: Double -> (Double,String)
feelsLike2 tmptC
    | tmptC <= 0 = (tmpF, "frostbite central!")
    | tmptC <= 5.55556 = (tmpF, "Its cold.")
    | tmptC <= 21.1111 = (tmpF, "Its still pretty cold.")
    | tmptC <= 27.7778 = (tmpF, "Its not as cold.")
    | otherwise = (tmpF, "Its hot, as not in a sexual way.")
    where tmpF = (tmptC * 1.8) + 32
-- *Main Data.List> feelsLike2 4
-- (39.2,"Its cold.")
-- *Main Data.List> feelsLike2 446
-- (834.8000000000001,"Its hot, as not in a sexual way.")
-- *Main Data.List> feelsLike2 46
-- (114.8,"Its hot, as not in a sexual way.")
-- *Main Data.List> feelsLike2 20
-- (68.0,"Its still pretty cold.")
-- *Main Data.List> feelsLike2 28
-- (82.4,"Its hot, as not in a sexual way.")
-- *Main Data.List> feelsLike2 22
-- (71.6,"Its not as cold.")

--2.4 I needed help from my previous lab to complete this one.
cylinderToVolume :: [(Double,Double)] -> [Double]
cylinderToVolume tupleList = let volume r h = (pi * r ^2) * h in [ volume rad hi | (rad,hi) <- tupleList ]
-- *Main Data.List> cylinderToVolume [(1,2),(24,25)]
-- [6.283185307179586,45238.93421169302]



