package main

import (
	"fmt"
	"strings"
)

func main() {
	fmt.Println(HighestScoringWord("a aa aaa") == "aaa")
	fmt.Println(HighestScoringWord2("a aa aaa") == "aaa")
}

// 0n^2
func HighestScoringWord(words string) string {
	wordList := strings.Split(words, " ")
	var topWord string
	var topScore int
	for _, word := range wordList {
		runes := []rune(word)
		score := 0
		for _, r := range runes {
			score += int(r)
			if score > topScore {
				topScore = score
				topWord = word
			}
		}
	}
	return topWord
}

// 0n
func HighestScoringWord2(words string) string {
	var topWord, currentWord []rune
	currentScore := 0
	topScore := 0
	lenWords := len(words)
	for i, r := range words {
		if r == ' ' || i == lenWords-1 {
			if i == lenWords-1 {
				currentWord = append(currentWord, r)
				currentScore += int(r)
			}
			if currentScore > topScore {
				topScore, topWord = currentScore, currentWord
				currentScore = 0
				currentWord = nil
			}
		} else {
			currentWord = append(currentWord, r)
			currentScore += int(r)
		}
	}
	return string(topWord)
}
