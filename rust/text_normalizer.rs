use regex::Regex;
use std::borrow::Cow;

/// A struct for normalizing text containing unusual writing styles,
/// such as repeated characters, text in asterisks, or
/// unusual capitalization.
pub struct TextNormalizer;

impl TextNormalizer {
    /// Creates a new instance of TextNormalizer.
    pub fn new() -> Self {
        TextNormalizer
    }

    /// Normalizes text by applying multiple normalization rules.
    ///
    /// # Arguments
    ///
    /// * `input` - The text to normalize.
    ///
    /// # Returns
    ///
    /// The normalized text.
    pub fn normalize_text<'a>(&self, input: &'a str) -> Cow<'a, str> {
        if input.is_empty() {
            return Cow::Borrowed(input);
        }

        let result = self.normalize_repeated_characters(input);
        let result = self.remove_asterisks(&result);
        let result = self.normalize_casing(&result);

        result
    }

    /// Normalizes repeated characters in text.
    ///
    /// # Arguments
    ///
    /// * `input` - The text to normalize.
    ///
    /// # Returns
    ///
    /// The text with normalized repeated characters.
    pub fn normalize_repeated_characters<'a>(&self, input: &'a str) -> Cow<'a, str> {
        if input.is_empty() {
            return Cow::Borrowed(input);
        }

        // Define word boundaries to identify words
        let re = Regex::new(r"\b\w+\b").unwrap();
        
        let result = re.replace_all(input, |caps: &regex::Captures| {
            let word = &caps[0];
            let mut normalized = String::with_capacity(word.len());
            let mut chars = word.chars().peekable();
            
            while let Some(current) = chars.next() {
                normalized.push(current);
                
                // Skip all subsequent identical characters
                while chars.peek() == Some(&current) {
                    chars.next();
                }
            }
            
            normalized
        });

        result
    }

    /// Removes text surrounded by asterisks and fixes any resulting extra spaces.
    ///
    /// # Arguments
    ///
    /// * `input` - The text to normalize.
    ///
    /// # Returns
    ///
    /// The text without asterisk content and no extra spaces.
    pub fn remove_asterisks<'a>(&self, input: &'a str) -> Cow<'a, str> {
        if input.is_empty() {
            return Cow::Borrowed(input);
        }
        
        // Remove text between asterisks completely
        let re = Regex::new(r"\*[^*]*\*").unwrap();
        let result = re.replace_all(input, "");
        
        // Fix any resulting double spaces or more
        let space_re = Regex::new(r"\s{2,}").unwrap();
        let result = space_re.replace_all(&result, " ");
        
        result
    }

    /// Normalizes capitalization of words.
    ///
    /// # Arguments
    ///
    /// * `input` - The text to normalize.
    ///
    /// # Returns
    ///
    /// The text with normalized capitalization.
    pub fn normalize_casing<'a>(&self, input: &'a str) -> Cow<'a, str> {
        if input.is_empty() {
            return Cow::Borrowed(input);
        }

        // Define word boundaries to identify words
        let re = Regex::new(r"\b\w+\b").unwrap();
        
        let result = re.replace_all(input, |caps: &regex::Captures| {
            let word = &caps[0];
            
            // If the word has mixed capitalization
            if self.has_mixed_casing(word) {
                // Convert everything to lowercase
                let normalized = word.to_lowercase();
                
                // First letter uppercase if the original was uppercase
                if let Some(first_char) = word.chars().next() {
                    if first_char.is_uppercase() {
                        let mut chars: Vec<char> = normalized.chars().collect();
                        if !chars.is_empty() {
                            chars[0] = chars[0].to_uppercase().next().unwrap_or(chars[0]);
                        }
                        return chars.iter().collect::<String>();
                    }
                }
                
                normalized
            } else {
                word.to_string()
            }
        });
        
        result
    }

    /// Checks if a word contains mixed capitalization.
    ///
    /// # Arguments
    ///
    /// * `word` - The word to check.
    ///
    /// # Returns
    ///
    /// True if the word has mixed capitalization, otherwise False.
    fn has_mixed_casing(&self, word: &str) -> bool {
        if word.len() <= 1 {
            return false;
        }
        
        let mut has_upper = false;
        let mut has_lower = false;
        
        for c in word.chars() {
            if c.is_uppercase() {
                has_upper = true;
            } else if c.is_lowercase() {
                has_lower = true;
            }
            
            if has_upper && has_lower {
                return true;
            }
        }
        
        false
    }
}

impl Default for TextNormalizer {
    fn default() -> Self {
        Self::new()
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_normalize_text() {
        let normalizer = TextNormalizer::new();
        
        assert_eq!(
            normalizer.normalize_text("Hellooo how areee you *cough* today?"),
            "Hello how are you today?"
        );
        
        assert_eq!(
            normalizer.normalize_text("HeLLo ThERe, HOw Are YOu?"),
            "Hello There, How Are You?"
        );
        
        assert_eq!(
            normalizer.normalize_text("It's a niiice *laughs* day!"),
            "It's a nice day!"
        );
        
        assert_eq!(normalizer.normalize_text(""), "");
        
        assert_eq!(
            normalizer.normalize_text("Regular text with no issues."),
            "Regular text with no issues."
        );
    }

    #[test]
    fn test_normalize_repeated_characters() {
        let normalizer = TextNormalizer::new();
        
        assert_eq!(
            normalizer.normalize_repeated_characters("Hellooo"),
            "Hello"
        );
        
        assert_eq!(
            normalizer.normalize_repeated_characters("goooood moooorning"),
            "good morning"
        );
        
        assert_eq!(
            normalizer.normalize_repeated_characters("normal text"),
            "normal text"
        );
        
        assert_eq!(normalizer.normalize_repeated_characters(""), "");
    }

    #[test]
    fn test_remove_asterisks() {
        let normalizer = TextNormalizer::new();
        
        assert_eq!(
            normalizer.remove_asterisks("Hello *cough* there"),
            "Hello there"
        );
        
        assert_eq!(
            normalizer.remove_asterisks("*laughs* This is funny *smiles*"),
            "This is funny"
        );
        
        assert_eq!(
            normalizer.remove_asterisks("No asterisks here"),
            "No asterisks here"
        );
        
        assert_eq!(normalizer.remove_asterisks(""), "");
    }

    #[test]
    fn test_normalize_casing() {
        let normalizer = TextNormalizer::new();
        
        assert_eq!(normalizer.normalize_casing("HeLLo"), "Hello");
        
        assert_eq!(normalizer.normalize_casing("ALL CAPS"), "ALL CAPS");
        
        assert_eq!(
            normalizer.normalize_casing("all lowercase"),
            "all lowercase"
        );
        
        assert_eq!(
            normalizer.normalize_casing("MiXeD CaSiNg TeXt"),
            "Mixed Casing Text"
        );
        
        assert_eq!(normalizer.normalize_casing(""), "");
    }

    #[test]
    fn test_has_mixed_casing() {
        let normalizer = TextNormalizer::new();
        
        assert!(normalizer.has_mixed_casing("HeLLo"));
        assert!(!normalizer.has_mixed_casing("HELLO"));
        assert!(!normalizer.has_mixed_casing("hello"));
        assert!(!normalizer.has_mixed_casing("Hello")); // First capital letter only is not mixed case
        assert!(!normalizer.has_mixed_casing("a"));     // Single character
        assert!(!normalizer.has_mixed_casing(""));      // Empty string
    }
}