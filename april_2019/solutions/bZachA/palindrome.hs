-- A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.
--
-- Find the largest palindrome made from the product of two 3-digit numbers.


-- 906609 is the largest
-- biggest question would be, am I multiplying these in the correct order?

import Control.Monad.State
import Data.Int
import Data.List

-- naive way: multiply every relevant combination of numbers together, then check if the product is a palindrome

-- what do we know about the products from the numbers being multiplied together?
-- we know if one or more of them is even, then the product is even

-- we know that last digit is function of last digit of both numbers product
-- but every subsequent digit depends more and more on previous digits
-- because there's more possible "carrying" happening

-- or we could search the other way:
-- we could lazily generate all the palindromes starting from
-- 999,999
-- so,
-- 999999, 998899, 989989, 899998, 997799, .... 888888 ...
-- and just pick the first one that we could prove was the product of
-- two three digit numbers - the tricky question is how to test for that
-- naively generate the prime factors and find if there's some permutation of
-- them between two sets that results in two three digit numbers when multiplied together

-- that would probably be slower than just multiplying two three digit numbers together and checking if they result in a palindrome starting from the largest three digit numbers; or at least it wouldn't scale as well to really high numbers



multiplyAndCheckForPalindrome :: (Int, Int) -> Bool
multiplyAndCheckForPalindrome (inputNumber1, inputNumber2) =
  let stringRepresentation = show $ inputNumber1 * inputNumber2 in
  (stringRepresentation == reverse stringRepresentation)

multiply2Tuple :: (Int, Int) -> Int
multiply2Tuple (inputNumber1, inputNumber2) = inputNumber1 * inputNumber2

-- 999 * 999 998 * 999 997 * 999 996 * 999
-- 999 * 998 998 * 998 997 * 998 996 * 998
-- 999 * 997 998 * 997 997 * 997 996 * 997
-- 999 * 996 998 * 996 997 * 996 996 * 996

-- 9 * 9   8 * 9   7 * 9   6 * 9  ...
-- 9 * 8   8 * 8   7 * 8   6 * 8  ... 1 interval
--                 7 * 7   6 * 7  ... 2 interval
--                                ... 0 interval
-- 4,4 3,4 2,4 1,4 0,4
--     3,3 2,3 1,3 0,3 4
--         2,2 1,2 0,2 3
--             1,1 0,1 2
--                 0,0 1
--                     0

  -- 1,2,3,4,5,6,7
-- 999 * 999 998 * 999 997 * 999 996 * 999
--           998 * 998 997 * 998 996 * 998
--                     997 * 997 996 * 997
--                               996 * 996
-- generatePairsOfThreeDigitNumbersOrderedByProductSize :: Int -> Int -> Int -> [(Int, Int)]
-- generatePairsOfThreeDigitNumbersOrderedByProductSize hundredsPlaceCounter tensPlaceCounter onesPlaceCounter =
-- decreaseX :: [(Int, Int)] -> [(Int, Int)]
-- decreaseX

--   2, 4, 8, 16
generatePairsOfThreeDigitNumbersOrderedByProductSize :: Int -> [Int] -> [(Int, Int)]
generatePairsOfThreeDigitNumbersOrderedByProductSize xAxisCounter yAxisCounters =
  -- if xAxisCounter == 0 && head yAxisCounters == 0 then
  --   [(0,0)]
  if xAxisCounter == 0 then
    map (\yAxisCounter ->
                (xAxisCounter, yAxisCounter)
                         ) yAxisCounters
  else
    map (\yAxisCounter ->
                (xAxisCounter, yAxisCounter)
                         ) yAxisCounters ++ generatePairsOfThreeDigitNumbersOrderedByProductSize (xAxisCounter - 1) (head yAxisCounters - 1 : yAxisCounters)
    -- ++ generatePairsOfThreeDigitNumbersOrderedByProductSize (xAxisCounter - 1) (yAxisCounter - 1)
    -- ++ generatePairsOfThreeDigitNumbersOrderedByProductSize (xAxisCounter - 1) yAxisCounter
  -- else if xAxisCounter == 0 then
  --   -- (xAxisCounter, yAxisCounter) :
  --   generatePairsOfThreeDigitNumbersOrderedByProductSize xAxisCounter (yAxisCounter - 1)
  -- else if yAxisCounter ==  0 then
  --   -- (xAxisCounter, yAxisCounter) :
  --   generatePairsOfThreeDigitNumbersOrderedByProductSize (xAxisCounter - 1) yAxisCounter
  -- else -- if xAxisCounter == yAxisCounter then
  --   [(xAxisCounter, yAxisCounter)]
  --   ++ generatePairsOfThreeDigitNumbersOrderedByProductSize (xAxisCounter - 1) (yAxisCounter - 1)
  --   ++ generatePairsOfThreeDigitNumbersOrderedByProductSize (xAxisCounter - 1) yAxisCounter
  -- else
  --   [(xAxisCounter, yAxisCounter)]
    -- ++ generatePairsOfThreeDigitNumbersOrderedByProductSize (xAxisCounter - 1) (yAxisCounter - 1)
    -- ++ generatePairsOfThreeDigitNumbersOrderedByProductSize xAxisCounter (yAxisCounter - 1)
    -- ++ generatePairsOfThreeDigitNumbersOrderedByProductSize (xAxisCounter - 1) yAxisCounter

  -- let counterDecreaser = (\counter -> generatePairsOfThreeDigitNumbersOrderedByProductSize )
  --  until ((==) 0) counter


-- 999 * 999, 998 * 999, 998 * 998, 997 * 999, 997 * 998, 997 * 997
-- problem, this skips generating duplicate numbers (999, 999), (998, 998)
-- not only that it also skips all multiplications of number with a difference greater than one ...
-- e.g. 997 * 999, 888 * 999
-- though interestingly 539 * 538 was the first product of one number pair that resulted in a palindrome (289982)
-- generatePairsOfThreeDigitNumbersOrderedByProductSize :: Int -> Int -> Int -> [(Int, Int)]
-- generatePairsOfThreeDigitNumbersOrderedByProductSize hundredsPlaceCounter tensPlaceCounter onesPlaceCounter =
--   if onesPlaceCounter == 0 then
--     if tensPlaceCounter == 0 then
--       if hundredsPlaceCounter == 0 then
--         [(000, 000)]
--       else
--         (hundredsPlaceCounter * 100 + tensPlaceCounter * 10 + onesPlaceCounter, (hundredsPlaceCounter - 1) * 100 + 90  + 9 ) : generatePairsOfThreeDigitNumbersOrderedByProductSize (hundredsPlaceCounter - 1) 9 9
--       -- [hundredsPlaceCounter tensPlaceCounter onesPlaceCounter]  ++ generatePairsOfThreeDigitNumbersOrderedByProductSize (hundredsPlaceCounter) 9 9
--     else
--       (hundredsPlaceCounter * 100 + tensPlaceCounter * 10 + onesPlaceCounter, hundredsPlaceCounter * 100 + (tensPlaceCounter - 1) * 10 + 9) : generatePairsOfThreeDigitNumbersOrderedByProductSize hundredsPlaceCounter (tensPlaceCounter - 1) 9
--   else
--     (hundredsPlaceCounter * 100 + tensPlaceCounter * 10 + onesPlaceCounter, hundredsPlaceCounter * 100 + tensPlaceCounter * 10 + onesPlaceCounter - 1)  : generatePairsOfThreeDigitNumbersOrderedByProductSize hundredsPlaceCounter tensPlaceCounter (onesPlaceCounter - 1)

main :: IO ()
main = do
  putStrLn "generatePairsOfThreeDigitNumbersOrderedByProductSize 9 9"
  print $ generatePairsOfThreeDigitNumbersOrderedByProductSize 9 [9]
  theAnswer <- pure $ sort $ map multiply2Tuple $ filter multiplyAndCheckForPalindrome (generatePairsOfThreeDigitNumbersOrderedByProductSize 999 [999])
  putStrLn "Da largest palindrome product of two three digit numbers is the last item in this list + 1: "
  print $ theAnswer
