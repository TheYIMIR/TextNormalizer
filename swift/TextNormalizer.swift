import Foundation

/// A class for normalizing text containing unusual writing styles,
/// such as repeated characters, text in asterisks, or
/// unusual capitalization.
public class TextNormalizer {
    
    /// Creates a new instance of TextNormalizer.
    public init() {}
    
    /// Normalizes text by applying multiple normalization rules.
    ///
    /// - Parameter input: The text to normalize.
    /// - Returns: The normalized text.
    public func normalizeText(_ input: String) -> String {
        if input.isEmpty {
            return input
        }
        
        var result = input
        
        // Normalize stretched words (e.g., "hellooo" -> "hello")
        result = normalizeRepeatedCharacters(result)
        
        // Remove text in asterisks (e.g., "*cough*")
        result = removeAsterisks(result)
        
        // Normalize capitalization (e.g., "HeLLo" -> "Hello")
        result = normalizeCasing(result)
        
        return result
    }
    
    /// Normalizes repeated characters in text.
    ///
    /// - Parameter input: The text to normalize.
    /// - Returns: The text with normalized repeated characters.
    public func normalizeRepeatedCharacters(_ input: String) -> String {
        if input.isEmpty {
            return input
        }
        
        do {
            // Define word boundaries to identify words
            let regex = try NSRegularExpression(pattern: "\\b\\w+\\b", options: [])
            let nsString = input as NSString
            let range = NSRange(location: 0, length: nsString.length)
            
            var lastEnd = 0
            var result = ""
            
            let matches = regex.matches(in: input, options: [], range: range)
            for match in matches {
                let wordRange = match.range
                let word = nsString.substring(with: wordRange)
                
                // Add text before the current word
                if wordRange.location > lastEnd {
                    result += nsString.substring(with: NSRange(location: lastEnd, length: wordRange.location - lastEnd))
                }
                
                // Normalize the word
                var normalized = ""
                var lastChar: Character?
                
                for char in word {
                    if lastChar != char {
                        normalized.append(char)
                        lastChar = char
                    }
                }
                
                result += normalized
                lastEnd = wordRange.location + wordRange.length
            }
            
            // Add remaining text
            if lastEnd < nsString.length {
                result += nsString.substring(with: NSRange(location: lastEnd, length: nsString.length - lastEnd))
            }
            
            return result
        } catch {
            // If regex fails, return the original input
            return input
        }
    }
    
    /// Removes text surrounded by asterisks and fixes any resulting extra spaces.
    ///
    /// - Parameter input: The text to normalize.
    /// - Returns: The text without asterisk content and no extra spaces.
    public func removeAsterisks(_ input: String) -> String {
        if input.isEmpty {
            return input
        }
        
        do {
            // Remove text between asterisks completely
            let regex = try NSRegularExpression(pattern: "\\*[^*]*\\*", options: [])
            let nsString = input as NSString
            let range = NSRange(location: 0, length: nsString.length)
            var result = regex.stringByReplacingMatches(in: input, options: [], range: range, withTemplate: "")
            
            // Fix any resulting double spaces or more
            let spaceRegex = try NSRegularExpression(pattern: "\\s{2,}", options: [])
            let resultNSString = result as NSString
            result = spaceRegex.stringByReplacingMatches(in: result, options: [], range: NSRange(location: 0, length: resultNSString.length), withTemplate: " ")
            
            return result
        } catch {
            // If regex fails, return the original input
            return input
        }
    }
    
    /// Normalizes capitalization of words.
    ///
    /// - Parameter input: The text to normalize.
    /// - Returns: The text with normalized capitalization.
    public func normalizeCasing(_ input: String) -> String {
        if input.isEmpty {
            return input
        }
        
        do {
            // Define word boundaries to identify words
            let regex = try NSRegularExpression(pattern: "\\b\\w+\\b", options: [])
            let nsString = input as NSString
            let range = NSRange(location: 0, length: nsString.length)
            
            var lastEnd = 0
            var result = ""
            
            let matches = regex.matches(in: input, options: [], range: range)
            for match in matches {
                let wordRange = match.range
                let word = nsString.substring(with: wordRange)
                
                // Add text before the current word
                if wordRange.location > lastEnd {
                    result += nsString.substring(with: NSRange(location: lastEnd, length: wordRange.location - lastEnd))
                }
                
                // If the word has mixed capitalization
                if hasMixedCasing(word) {
                    // Convert everything to lowercase
                    var normalized = word.lowercased()
                    
                    // First letter uppercase if the original was uppercase
                    if let firstChar = word.first, firstChar.isUppercase {
                        normalized = normalized.prefix(1).uppercased() + normalized.dropFirst()
                    }
                    
                    result += normalized
                } else {
                    result += word
                }
                
                lastEnd = wordRange.location + wordRange.length
            }
            
            // Add remaining text
            if lastEnd < nsString.length {
                result += nsString.substring(with: NSRange(location: lastEnd, length: nsString.length - lastEnd))
            }
            
            return result
        } catch {
            // If regex fails, return the original input
            return input
        }
    }
    
    /// Checks if a word contains mixed capitalization.
    ///
    /// - Parameter word: The word to check.
    /// - Returns: True if the word has mixed capitalization, otherwise False.
    private func hasMixedCasing(_ word: String) -> Bool {
        if word.count <= 1 {
            return false
        }
        
        var hasUpper = false
        var hasLower = false
        
        for char in word {
            if char.isUppercase {
                hasUpper = true
            } else if char.isLowercase {
                hasLower = true
            }
            
            if hasUpper && hasLower {
                return true
            }
        }
        
        return false
    }
}

// Example usage
/*
let normalizer = TextNormalizer()
let normalized = normalizer.normalizeText("Hellooo how areee you *cough* today?")
print(normalized)  // "Hello how are you today?"
*/