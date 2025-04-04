#ifndef TEXT_NORMALIZER_H
#define TEXT_NORMALIZER_H

#include <string>

/**
 * A class for normalizing text containing unusual writing styles,
 * such as repeated characters, text in asterisks, or
 * unusual capitalization.
 */
class TextNormalizer {
public:
    /**
     * Constructor
     */
    TextNormalizer();
    
    /**
     * Destructor
     */
    ~TextNormalizer();
    
    /**
     * Normalizes text by applying multiple normalization rules.
     *
     * @param input The text to normalize.
     * @return The normalized text.
     */
    std::string normalizeText(const std::string& input);
    
    /**
     * Normalizes repeated characters in text.
     *
     * @param input The text to normalize.
     * @return The text with normalized repeated characters.
     */
    std::string normalizeRepeatedCharacters(const std::string& input);
    
    /**
     * Removes text surrounded by asterisks and fixes any resulting extra spaces.
     *
     * @param input The text to normalize.
     * @return The text without asterisk content and no extra spaces.
     */
    std::string removeAsterisks(const std::string& input);
    
    /**
     * Normalizes capitalization of words.
     *
     * @param input The text to normalize.
     * @return The text with normalized capitalization.
     */
    std::string normalizeCasing(const std::string& input);
    
private:
    /**
     * Checks if a word contains mixed capitalization.
     *
     * @param word The word to check.
     * @return True if the word has mixed capitalization, otherwise False.
     */
    bool hasMixedCasing(const std::string& word);
};

#endif // TEXT_NORMALIZER_H