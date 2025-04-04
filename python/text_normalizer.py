import re

class TextNormalizer:
    """
    A class for normalizing text containing unusual writing styles,
    such as repeated characters, text in asterisks, or
    unusual capitalization.
    """
    
    def normalize_text(self, input_text):
        """
        Normalizes text by applying multiple normalization rules.
        
        Args:
            input_text (str): The text to normalize.
        
        Returns:
            str: The normalized text.
        """
        if not input_text:
            return input_text
            
        result = input_text
        
        # Normalize stretched words (e.g., "hellooo" -> "hello")
        result = self.normalize_repeated_characters(result)
        
        # Remove text in asterisks (e.g., "*cough*")
        result = self.remove_asterisks(result)
        
        # Normalize capitalization (e.g., "HeLLo" -> "Hello")
        result = self.normalize_casing(result)
        
        return result
    
    def normalize_repeated_characters(self, input_text):
        """
        Normalizes repeated characters in text.
        
        Args:
            input_text (str): The text to normalize.
        
        Returns:
            str: The text with normalized repeated characters.
        """
        if not input_text:
            return input_text
            
        def normalize_word(match):
            word = match.group(0)
            normalized = []
            i = 0
            
            while i < len(word):
                current_char = word[i]
                normalized.append(current_char)
                
                # Skip all subsequent identical characters
                while i + 1 < len(word) and word[i + 1] == current_char:
                    i += 1
                
                i += 1
                
            return ''.join(normalized)
        
        # Process each word (sequence of word characters)
        return re.sub(r'\b\w+\b', normalize_word, input_text)
    
    def remove_asterisks(self, input_text):
        """
        Removes text surrounded by asterisks and fixes any resulting extra spaces.
        
        Args:
            input_text (str): The text to normalize.
        
        Returns:
            str: The text without asterisk content and no extra spaces.
        """
        if not input_text:
            return input_text
            
        # Remove text between asterisks completely
        result = re.sub(r'\*[^*]*\*', '', input_text)
        
        # Fix any resulting double spaces or more
        result = re.sub(r'\s{2,}', ' ', result)
        
        return result
    
    def normalize_casing(self, input_text):
        """
        Normalizes capitalization of words.
        
        Args:
            input_text (str): The text to normalize.
        
        Returns:
            str: The text with normalized capitalization.
        """
        if not input_text:
            return input_text
            
        def normalize_word_casing(match):
            word = match.group(0)
            
            # If the word has mixed capitalization
            if self._has_mixed_casing(word):
                # Convert everything to lowercase
                normalized = word.lower()
                
                # First letter uppercase if the original was uppercase
                if word[0].isupper():
                    normalized = normalized[0].upper() + normalized[1:]
                
                return normalized
            
            return word
            
        # Process each word (sequence of word characters)
        return re.sub(r'\b\w+\b', normalize_word_casing, input_text)
    
    def _has_mixed_casing(self, word):
        """
        Checks if a word contains mixed capitalization.
        
        Args:
            word (str): The word to check.
        
        Returns:
            bool: True if the word has mixed capitalization, otherwise False.
        """
        if len(word) <= 1:
            return False
            
        has_upper = False
        has_lower = False
        
        for char in word:
            if char.isupper():
                has_upper = True
            elif char.islower():
                has_lower = True
                
            if has_upper and has_lower:
                return True
                
        return False


# Example usage
if __name__ == "__main__":
    normalizer = TextNormalizer()
    
    # Example with stretched words and asterisks
    sample_text = "Hellooo how areee you *cough* today? It's a niiice day *laughs*"
    normalized = normalizer.normalize_text(sample_text)
    print(f"Original: {sample_text}")
    print(f"Normalized: {normalized}")
    
    # Example with mixed capitalization
    sample_text2 = "HeLLo ThERe, HOw Are YOu?"
    normalized2 = normalizer.normalize_text(sample_text2)
    print(f"Original: {sample_text2}")
    print(f"Normalized: {normalized2}")