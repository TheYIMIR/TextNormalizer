using System;
using System.Text;
using System.Text.RegularExpressions;

namespace TextProcessing
{
    /// <summary>
    /// A class for normalizing text containing unusual writing styles,
    /// such as repeated characters, text in asterisks, or
    /// unusual capitalization.
    /// </summary>
    public class TextNormalizer
    {
        /// <summary>
        /// Normalizes text by applying multiple normalization rules.
        /// </summary>
        /// <param name="input">The text to normalize.</param>
        /// <returns>The normalized text.</returns>
        public string NormalizeText(string input)
        {
            if (string.IsNullOrEmpty(input))
                return input;

            string result = input;
            
            // Normalize stretched words (e.g., "hellooo" -> "hello")
            result = NormalizeRepeatedCharacters(result);
            
            // Remove text in asterisks (e.g., "*cough*")
            result = RemoveAsterisks(result);
            
            // Normalize capitalization (e.g., "HeLLo" -> "Hello")
            result = NormalizeCasing(result);
            
            return result;
        }

        /// <summary>
        /// Normalizes repeated characters in text.
        /// </summary>
        /// <param name="input">The text to normalize.</param>
        /// <returns>The text with normalized repeated characters.</returns>
        public string NormalizeRepeatedCharacters(string input)
        {
            if (string.IsNullOrEmpty(input))
                return input;

            // Define word boundaries to identify words
            string pattern = @"\b\w+\b";
            
            return Regex.Replace(input, pattern, match =>
            {
                string word = match.Value;
                StringBuilder normalized = new StringBuilder();
                
                for (int i = 0; i < word.Length; i++)
                {
                    char current = word[i];
                    normalized.Append(current);
                    
                    // Skip all subsequent identical characters
                    while (i + 1 < word.Length && word[i + 1] == current)
                    {
                        i++;
                    }
                }
                
                return normalized.ToString();
            });
        }

        /// <summary>
        /// Removes text surrounded by asterisks and fixes any resulting extra spaces.
        /// </summary>
        /// <param name="input">The text to normalize.</param>
        /// <returns>The text without asterisk content and no extra spaces.</returns>
        public string RemoveAsterisks(string input)
        {
            if (string.IsNullOrEmpty(input))
                return input;
            
            // Remove text between asterisks completely
            string result = Regex.Replace(input, @"\*[^*]*\*", "");
            
            // Fix any resulting double spaces or more
            result = Regex.Replace(result, @"\s{2,}", " ");
            
            return result;
        }

        /// <summary>
        /// Normalizes capitalization of words.
        /// </summary>
        /// <param name="input">The text to normalize.</param>
        /// <returns>The text with normalized capitalization.</returns>
        public string NormalizeCasing(string input)
        {
            if (string.IsNullOrEmpty(input))
                return input;

            // Define word boundaries to identify words
            string pattern = @"\b\w+\b";
            
            return Regex.Replace(input, pattern, match =>
            {
                string word = match.Value;
                
                // If the word has mixed capitalization
                if (HasMixedCasing(word))
                {
                    // Convert everything to lowercase
                    string normalized = word.ToLower();
                    
                    // First letter uppercase if the original was uppercase
                    if (char.IsUpper(word[0]))
                    {
                        normalized = char.ToUpper(normalized[0]) + normalized.Substring(1);
                    }
                    
                    return normalized;
                }
                
                return word;
            });
        }

        /// <summary>
        /// Checks if a word contains mixed capitalization.
        /// </summary>
        /// <param name="word">The word to check.</param>
        /// <returns>True if the word has mixed capitalization, otherwise False.</returns>
        private bool HasMixedCasing(string word)
        {
            if (word.Length <= 1)
                return false;
            
            bool hasUpper = false;
            bool hasLower = false;
            
            for (int i = 0; i < word.Length; i++)
            {
                if (char.IsUpper(word[i]))
                    hasUpper = true;
                else if (char.IsLower(word[i]))
                    hasLower = true;
                
                if (hasUpper && hasLower)
                    return true;
            }
            
            return false;
        }
    }
}