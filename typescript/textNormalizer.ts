/**
 * A class for normalizing text containing unusual writing styles,
 * such as repeated characters, text in asterisks, or
 * unusual capitalization.
 */
export class TextNormalizer {
    /**
     * Normalizes text by applying multiple normalization rules.
     *
     * @param input - The text to normalize.
     * @returns The normalized text.
     */
    public normalizeText(input: string): string {
        if (!input) {
            return input;
        }

        let result = input;
        
        // Normalize stretched words (e.g., "hellooo" -> "hello")
        result = this.normalizeRepeatedCharacters(result);
        
        // Remove text in asterisks (e.g., "*cough*")
        result = this.removeAsterisks(result);
        
        // Normalize capitalization (e.g., "HeLLo" -> "Hello")
        result = this.normalizeCasing(result);
        
        return result;
    }

    /**
     * Normalizes repeated characters in text.
     *
     * @param input - The text to normalize.
     * @returns The text with normalized repeated characters.
     */
    public normalizeRepeatedCharacters(input: string): string {
        if (!input) {
            return input;
        }

        // Define word boundaries to identify words
        const pattern = /\b\w+\b/g;
        
        return input.replace(pattern, (word) => {
            let normalized = '';
            
            for (let i = 0; i < word.length; i++) {
                const current = word[i];
                normalized += current;
                
                // Skip all subsequent identical characters
                while (i + 1 < word.length && word[i + 1] === current) {
                    i++;
                }
            }
            
            return normalized;
        });
    }

    /**
     * Removes text surrounded by asterisks and fixes any resulting extra spaces.
     *
     * @param input - The text to normalize.
     * @returns The text without asterisk content and no extra spaces.
     */
    public removeAsterisks(input: string): string {
        if (!input) {
            return input;
        }
        
        // Remove text between asterisks completely
        let result = input.replace(/\*[^*]*\*/g, '');
        
        // Fix any resulting double spaces or more
        result = result.replace(/\s{2,}/g, ' ');
        
        return result;
    }

    /**
     * Normalizes capitalization of words.
     *
     * @param input - The text to normalize.
     * @returns The text with normalized capitalization.
     */
    public normalizeCasing(input: string): string {
        if (!input) {
            return input;
        }

        // Define word boundaries to identify words
        const pattern = /\b\w+\b/g;
        
        return input.replace(pattern, (word) => {
            // If the word has mixed capitalization
            if (this.hasMixedCasing(word)) {
                // Convert everything to lowercase
                let normalized = word.toLowerCase();
                
                // First letter uppercase if the original was uppercase
                if (/^[A-Z]/.test(word)) {
                    normalized = normalized.charAt(0).toUpperCase() + normalized.slice(1);
                }
                
                return normalized;
            }
            
            return word;
        });
    }

    /**
     * Checks if a word contains mixed capitalization.
     *
     * @param word - The word to check.
     * @returns True if the word has mixed capitalization, otherwise False.
     */
    private hasMixedCasing(word: string): boolean {
        if (word.length <= 1) {
            return false;
        }
        
        let hasUpper = false;
        let hasLower = false;
        
        for (let i = 0; i < word.length; i++) {
            const char = word[i];
            
            if (char >= 'A' && char <= 'Z') {
                hasUpper = true;
            } else if (char >= 'a' && char <= 'z') {
                hasLower = true;
            }
            
            if (hasUpper && hasLower) {
                return true;
            }
        }
        
        return false;
    }
}

// Example usage
/*
const normalizer = new TextNormalizer();
const normalized = normalizer.normalizeText("Hellooo how areee you *cough* today?");
console.log(normalized);  // "Hello how are you today?"
*/