package textnormalizer

import (
	"regexp"
	"strings"
	"unicode"
)

// TextNormalizer is a struct for normalizing text containing unusual writing styles,
// such as repeated characters, text in asterisks, or unusual capitalization.
type TextNormalizer struct{}

// NewTextNormalizer creates a new instance of TextNormalizer.
func NewTextNormalizer() *TextNormalizer {
	return &TextNormalizer{}
}

// NormalizeText normalizes text by applying multiple normalization rules.
func (tn *TextNormalizer) NormalizeText(input string) string {
	if input == "" {
		return input
	}

	result := input

	// Normalize stretched words (e.g., "hellooo" -> "hello")
	result = tn.NormalizeRepeatedCharacters(result)

	// Remove text in asterisks (e.g., "*cough*")
	result = tn.RemoveAsterisks(result)

	// Normalize capitalization (e.g., "HeLLo" -> "Hello")
	result = tn.NormalizeCasing(result)

	return result
}

// NormalizeRepeatedCharacters normalizes repeated characters in text.
func (tn *TextNormalizer) NormalizeRepeatedCharacters(input string) string {
	if input == "" {
		return input
	}

	// Define word boundaries to identify words
	re := regexp.MustCompile(`\b\w+\b`)

	return re.ReplaceAllStringFunc(input, func(word string) string {
		var normalized strings.Builder
		var lastChar rune
		var isFirst = true

		for _, char := range word {
			if isFirst || char != lastChar {
				normalized.WriteRune(char)
				lastChar = char
				isFirst = false
			}
		}

		return normalized.String()
	})
}

// RemoveAsterisks removes text surrounded by asterisks and fixes any resulting extra spaces.
func (tn *TextNormalizer) RemoveAsterisks(input string) string {
	if input == "" {
		return input
	}

	// Remove text between asterisks completely
	re := regexp.MustCompile(`\*[^*]*\*`)
	result := re.ReplaceAllString(input, "")

	// Fix any resulting double spaces or more
	spaceRe := regexp.MustCompile(`\s{2,}`)
	result = spaceRe.ReplaceAllString(result, " ")

	return result
}

// NormalizeCasing normalizes capitalization of words.
func (tn *TextNormalizer) NormalizeCasing(input string) string {
	if input == "" {
		return input
	}

	// Define word boundaries to identify words
	re := regexp.MustCompile(`\b\w+\b`)

	return re.ReplaceAllStringFunc(input, func(word string) string {
		// If the word has mixed capitalization
		if tn.hasMixedCasing(word) {
			// Convert everything to lowercase
			normalized := strings.ToLower(word)

			// First letter uppercase if the original was uppercase
			if len(normalized) > 0 && unicode.IsUpper([]rune(word)[0]) {
				runes := []rune(normalized)
				runes[0] = unicode.ToUpper(runes[0])
				normalized = string(runes)
			}

			return normalized
		}

		return word
	})
}

// hasMixedCasing checks if a word contains mixed capitalization.
func (tn *TextNormalizer) hasMixedCasing(word string) bool {
	if len(word) <= 1 {
		return false
	}

	hasUpper := false
	hasLower := false

	for _, char := range word {
		if unicode.IsUpper(char) {
			hasUpper = true
		} else if unicode.IsLower(char) {
			hasLower = true
		}

		if hasUpper && hasLower {
			return true
		}
	}

	return false
}