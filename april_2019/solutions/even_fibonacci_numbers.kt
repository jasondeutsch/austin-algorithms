fun main(args: Array<String>) {
  println(findEvenFibNumbers(4000000))
}

private fun findEvenFibNumbers(upperBound: Int) : Int {
  // https://kotlinlang.org/api/latest/jvm/stdlib/kotlin.sequences/generate-sequence.html

  val fib = generateSequence(1 to upperBound) {
      it.second to it.first + it.second
  }
  return fib.map { it.second }
    .filter { it % 2 == 0 }
    .sum()
}
