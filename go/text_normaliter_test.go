package textnormalizer

import (
	"testing"
)

func TestNormalizeText(t *testing.T) {
	normalizer := NewTextNormalizer()
	
	tests := []struct {
		input    string
		expected string
	}{
		{"Hellooo how areee you *cough* today?", "Hello how are you today?"},
		{"HeLLo ThERe, HOw Are YOu?", "Hello There, How Are You?"},
		{"It's a niiice *laughs* day!", "It's a nice day!"},
		{"", ""},
		{"Regular text with no issues.", "Regular text with no issues."},
	}
	
	for _, test := range tests {
		result := normalizer.NormalizeText(test.input)
		if result != test.expected {
			t.Errorf("NormalizeText(%q) = %q, expected %q", test.input, result, test.expected)
		}
	}
}

func TestNormalizeRepeatedCharacters(t *testing.T) {
	normalizer := NewTextNormalizer()
	
	tests := []struct {
		input    string
		expected string
	}{
		{"Hellooo", "Hello"},
		{"goooood moooorning", "good morning"},
		{"normal text", "normal text"},
		{"", ""},
	}
	
	for _, test := range tests {
		result := normalizer.NormalizeRepeatedCharacters(test.input)
		if result != test.expected {
			t.Errorf("NormalizeRepeatedCharacters(%q) = %q, expected %q", test.input, result, test.expected)
		}
	}
}

func TestRemoveAsterisks(t *testing.T) {
	normalizer := NewTextNormalizer()
	
	tests := []struct {
		input    string
		expected string
	}{
		{"Hello *cough* there", "Hello there"},
		{"*laughs* This is funny *smiles*", "This is funny"},
		{"No asterisks here", "No asterisks here"},
		{"*starts* and *ends* with asterisks", "and with asterisks"},
		{"", ""},
	}
	
	for _, test := range tests {
		result := normalizer.RemoveAsterisks(test.input)
		if result != test.expected {
			t.Errorf("RemoveAsterisks(%q) = %q, expected %q", test.input, result, test.expected)
		}
	}
}

func TestNormalizeCasing(t *testing.T) {
	normalizer := NewTextNormalizer()
	
	tests := []struct {
		input    string
		expected string
	}{
		{"HeLLo", "Hello"},
		{"ALL CAPS", "ALL CAPS"},
		{"all lowercase", "all lowercase"},
		{"MiXeD CaSiNg TeXt", "Mixed Casing Text"},
		{"", ""},
	}
	
	for _, test := range tests {
		result := normalizer.NormalizeCasing(test.input)
		if result != test.expected {
			t.Errorf("NormalizeCasing(%q) = %q, expected %q", test.input, result, test.expected)
		}
	}
}

func TestHasMixedCasing(t *testing.T) {
	normalizer := NewTextNormalizer()
	
	tests := []struct {
		input    string
		expected bool
	}{
		{"HeLLo", true},
		{"HELLO", false},
		{"hello", false},
		{"Hello", false}, // First capital letter only is not considered mixed case
		{"a", false},     // Single character
		{"", false},      // Empty string
	}
	
	for _, test := range tests {
		result := normalizer.hasMixedCasing(test.input)
		if result != test.expected {
			t.Errorf("hasMixedCasing(%q) = %v, expected %v", test.input, result, test.expected)
		}
	}
}