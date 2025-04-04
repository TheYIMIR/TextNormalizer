#include "TextNormalizer.h"
#include <regex>
#include <algorithm>

TextNormalizer::TextNormalizer() {
    // Constructor
}

TextNormalizer::~TextNormalizer() {
    // Destructor
}

std::string TextNormalizer::normalizeText(const std::string& input) {
    if (input.empty()) {
        return input;
    }

    std::string result = input;
    
    // Normalize stretched words (e.g., "hellooo" -> "hello")
    result = normalizeRepeatedCharacters(result);
    
    // Remove text in asterisks (e.g., "*cough*")
    result = removeAsterisks(result);
    
    // Normalize capitalization (e.g., "HeLLo" -> "Hello")
    result = normalizeCasing(result);
    
    return result;
}

std::string TextNormalizer::normalizeRepeatedCharacters(const std::string& input) {
    if (input.empty()) {
        return input;
    }

    // Define word boundaries to identify words
    std::regex wordPattern("\\b\\w+\\b");
    
    std::string result;
    std::sregex_iterator wordIterBegin(input.begin(), input.end(), wordPattern);
    std::sregex_iterator wordIterEnd;
    
    size_t lastPos = 0;
    for (std::sregex_iterator iter = wordIterBegin; iter != wordIterEnd; ++iter) {
        std::smatch match = *iter;
        std::string word = match.str();
        
        // Add text before the current word
        result += input.substr(lastPos, match.position() - lastPos);
        
        // Normalize the word
        std::string normalized;
        for (size_t i = 0; i < word.length(); i++) {
            char current = word[i];
            normalized += current;
            
            // Skip all subsequent identical characters
            while (i + 1 < word.length() && word[i + 1] == current) {
                i++;
            }
        }
        
        result += normalized;
        lastPos = match.position() + match.length();
    }
    
    // Add remaining text
    result += input.substr(lastPos);
    
    return result;
}

std::string TextNormalizer::removeAsterisks(const std::string& input) {
    if (input.empty()) {
        return input;
    }
    
    // Remove text between asterisks completely
    std::regex asteriskPattern("\\*[^*]*\\*");
    std::string result = std::regex_replace(input, asteriskPattern, "");
    
    // Fix any resulting double spaces or more
    std::regex multipleSpacesPattern("\\s{2,}");
    result = std::regex_replace(result, multipleSpacesPattern, " ");
    
    return result;
}

std::string TextNormalizer::normalizeCasing(const std::string& input) {
    if (input.empty()) {
        return input;
    }

    // Define word boundaries to identify words
    std::regex wordPattern("\\b\\w+\\b");
    
    std::string result;
    std::sregex_iterator wordIterBegin(input.begin(), input.end(), wordPattern);
    std::sregex_iterator wordIterEnd;
    
    size_t lastPos = 0;
    for (std::sregex_iterator iter = wordIterBegin; iter != wordIterEnd; ++iter) {
        std::smatch match = *iter;
        std::string word = match.str();
        
        // Add text before the current word
        result += input.substr(lastPos, match.position() - lastPos);
        
        // If the word has mixed capitalization
        if (hasMixedCasing(word)) {
            // Convert everything to lowercase
            std::string normalized = word;
            std::transform(normalized.begin(), normalized.end(), normalized.begin(), ::tolower);
            
            // First letter uppercase if the original was uppercase
            if (std::isupper(word[0])) {
                normalized[0] = std::toupper(normalized[0]);
            }
            
            result += normalized;
        } else {
            result += word;
        }
        
        lastPos = match.position() + match.length();
    }
    
    // Add remaining text
    result += input.substr(lastPos);
    
    return result;
}

bool TextNormalizer::hasMixedCasing(const std::string& word) {
    if (word.length() <= 1) {
        return false;
    }
    
    bool hasUpper = false;
    bool hasLower = false;
    
    for (char c : word) {
        if (std::isupper(c)) {
            hasUpper = true;
        } else if (std::islower(c)) {
            hasLower = true;
        }
        
        if (hasUpper && hasLower) {
            return true;
        }
    }
    
    return false;
}