main = putStrLn $ show solution

solution = sum $ filter even $ takeWhile (<= 4000000) fibs
  where fibs = 0:1:zipWith (+) fibs (tail fibs)
