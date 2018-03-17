
-- haskell Lab 1
-- Nathan Stark

-- lab 1.3
lab13 = sqrt 818281336460929553769504384519009121840452831049
-- *Main> lab13
-- 9.045890428592033e23
-- *Main>

-- lab 1.4
-- What is the ASCII character that comes before uppercase A?
-- nextY :: Char -> Char
lastY y = pred y
-- *Main> 

-- lab 1.5
isEven aNumber = (3 * aNumber + 1) `mod` 2 == 0
-- *Main> isEven 9
-- True
-- *Main> isEven 4
-- False


-- lab 2.2
lab22 = product [1,3..100]
-- *Main> lab22
-- 2725392139750729502980713245400918633290796330545803413734328823443106201171875


-- lab 2.3
-- Use list operation functions like head, tail, last, etc. to find the greatest number in the following list, that is not the first or last number.
-- i.e. if the first and last numbers don't count, then what is the largest number in the "middle" of the list?
-- [99,23,4,2,67,82,49,-40]
lab23 = maximum (init (tail [99, 23, 4, 2, 67, 82, 49, -40]))
-- *Main> lab23
-- 82

-- lab 2.4
lab24 = 6:19:41:(-3):[]
-- *Main> lab24
-- [6,19,41,-3]

-- lab 2.5.1
lab251 = take 27 [x * 2| x <- [0..]]
-- *Main> lab251
-- [0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46,48,50,52,54]

-- lab 2.5.2
-- Provide a list of all odd numbers less than 200 that are divisible by 3 and 7.
lab252 = [ x | x <- [1..200], odd x, x `mod` 3 == 0, x `mod` 7 == 0]
-- *Main> lab252
-- [21,63,105,147,189]

-- lab 2.5.3
lab253 = length [ x | x <- [100..200], odd x, x `mod` 9 == 0]
-- *Main> lab253
-- 5

-- lab 2.5.5
lab255 what = length [ x | x  <- what, x < 0]
-- *Main> lab255 []
-- 0
-- *Main> lab255 [2,4,21,6,545,25]
-- 0
-- *Main> lab255 [2,4,21,-6,545,-25]
-- 2

-- lab 2.6
lab26 = zip [0..15] (['0'..'9'] ++ ['A'..'F'])
-- *Main> lab26
-- [(0,'0'),(1,'1'),(2,'2'),(3,'3'),(4,'4'),(5,'5'),(6,'6'),(7,'7'),(8,'8'),(9,'9'),(10,'A'),(11,'B'),(12,'C'),(13,'D'),(14,'E'),(15,'F')]

-- lab 3.1
makeList manyList = if(manyList < 1) then [] else [[1..x] | x <- [1..manyList]]
-- *Main> makeList 5
-- [[1],[1,2],[1,2,3],[1,2,3,4],[1,2,3,4,5]]

-- lab 3.2
sanitize aString = [ x | v <- aString, x <- if(v == ' ') then "%20" else [v]]
-- *Main> sanitize "http://wou.edu/my homepage/I love spaces.html"
-- "http://wou.edu/my%20homepage/I%20love%20spaces.html"
-- *Main> sanitize "http://wou       .edu/my homepage/I love spaces.html"
-- "http://wou%20%20%20%20%20%20%20.edu/my%20homepage/I%20love%20spaces.html"

-- lab 3.4
-- *Main> :t (++)
-- (++) :: [a] -> [a] -> [a]
-- a stand for a generic type that can be any type therefore (++) can take
-- "string" == [Char], [1,2,4], [(1,2),(3,5),(8,9)]
-- *Main> :t (*)
-- (*) :: Num a => a -> a -> a
-- a is type bound to a Num data type and will work with
-- 1.2 and 1
-- *Main> :t length
-- length :: Foldable t => t a -> Int
-- The Foldable type class provides a generalisation of lists so see the (++) section
-- *Main> :t take
-- take :: Int -> [a] -> [a]
-- so you have to put in a whole number and takes a list generic and out puts list
-- of the same type of the orginal list.
-- *Main> :t sqrt
-- sqrt :: Floating a => a -> a
-- a is type bound to a Floating type class and returns one
-- *Main> :t min
-- min :: Ord a => a -> a -> a
-- The Ord class is used for ordered datatypes.

-- lab 4.1a
getSuit :: Int -> String
getSuit 0 = "Heart"
getSuit 1 = "Diamond"
getSuit 2 = "Spade"
getSuit 3 = "Club"
getSuit x = error "only exepted 0..3" -- error will throw an exception
-- *Main> getSuit 2
-- "Spade"
-- *Main> getSuit 23
-- "only exepted 0..3" I have made changes therefore the result will be differant.
-- *Main> getSuit 3
-- "Club"

-- lab 4.1b
dotProduct :: (Double,Double,Double) -> (Double,Double,Double) -> Double
dotProduct (x1,x2,x3) (y1,y2,y3) = x1 * y1 + x2 * y2 + x3 * y3
-- *Main> dotProduct (2, 3.4, 5) (2, 3 ,5.8)
-- 43.2

-- lab 4.1c
reverseFirstThree :: [a] -> [a]
reverseFirstThree [] = []
reverseFirstThree [b] = [b]
reverseFirstThree [a,b] = [b,a]
reverseFirstThree (a:b:c:aList) = [c,b,a] ++ aList
-- *Main> reverseFirstThree [1,2,3,4,5,6]
-- [3,2,1,4,5,6]

-- lab 4.2a
feelsLike :: Double -> String
feelsLike tempt
    | tempt <= 32 = "frostbite central!"
    | tempt <= 42 = "I'm don't want to leaving my house."
    | tempt <= 70 = "Its still pretty cold."
    | tempt <= 82 = "Ten degrees more and it'd be perfect."
    | otherwise = "Its pretty hot out here."
-- *Main> feelsLike 30
-- "frostbite central!"
-- *Main> feelsLike 300
-- "Its pretty hot out here."
-- *Main> feelsLike 33
-- "I'm don't want to leaving my house."
-- *Main> feelsLike 73
-- "Ten degrees more and it'd be perfect."
-- *Main> feelsLike 63
-- "Its still pretty cold."

-- lab 4.2b
feelsLike2 :: Double -> (Double,String)
feelsLike2 temptC
    | temptC <= 0 = (tempF, "frostbite central!")
    | temptC <= 5.55556 = (tempF, "I'm don't want to leaving my house.")
    | temptC <= 21.1111 = (tempF, "Its still pretty cold.")
    | temptC <= 27.7778 = (tempF, "Ten degrees more and it'd be perfect.")
    | otherwise = (tempF, "Its pretty hot out here.")
    where tempF = (temptC * 1.8) + 32
-- *Main> feelsLike2 0
-- (32.0,"frostbite central!")
-- *Main> feelsLike2 4
-- (39.2,"I'm don't want to leaving my house.")
-- *Main> feelsLike2 34
-- (93.2,"Its pretty hot out here.")

-- lab 4.3
cylinderToVolume :: [(Double,Double)] -> [Double]
cylinderToVolume tupleList = let volume r h = (pi * r ^2) * h in [ volume rad hi | (rad,hi) <- tupleList ]
-- *Main> cylinderToVolume [(2,3),(2,3),(2,3)]
-- [37.69911184307752,37.69911184307752,37.69911184307752]
-- *Main> cylinderToVolume [(2,5.3),(4.2,9),(1,1),(100.3,94)]
-- [66.6017642561036,498.7592496839155,3.141592653589793,2970842.2548145014]

-- let {this function exist} in {something.. above we used a list comprehention.}


