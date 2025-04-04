#' TextNormalizer Class
#' 
#' A class for normalizing text containing unusual writing styles,
#' such as repeated characters, text in asterisks, or
#' unusual capitalization.
#' 
#' @importFrom stringr str_replace_all str_detect
#' @examples
#' normalizer <- TextNormalizer$new()
#' normalizer$normalize_text("Hellooo how areee you *cough* today?")
TextNormalizer <- R6::R6Class(
  "TextNormalizer",
  public = list(
    #' @description
    #' Normalize text by applying multiple normalization rules.
    #' @param input The text to normalize.
    #' @return The normalized text.
    normalize_text = function(input) {
      if (is.null(input) || input == "") {
        return(input)
      }
      
      result <- input
      
      # Normalize stretched words (e.g., "hellooo" -> "hello")
      result <- self$normalize_repeated_characters(result)
      
      # Remove text in asterisks (e.g., "*cough*")
      result <- self$remove_asterisks(result)
      
      # Normalize capitalization (e.g., "HeLLo" -> "Hello")
      result <- self$normalize_casing(result)
      
      return(result)
    },
    
    #' @description
    #' Normalize repeated characters in text.
    #' @param input The text to normalize.
    #' @return The text with normalized repeated characters.
    normalize_repeated_characters = function(input) {
      if (is.null(input) || input == "") {
        return(input)
      }
      
      # Split by words and process each word
      words <- unlist(stringr::str_extract_all(input, "\\b\\w+\\b"))
      
      for (word in words) {
        normalized_word <- ""
        i <- 1
        
        while (i <= nchar(word)) {
          current <- substr(word, i, i)
          normalized_word <- paste0(normalized_word, current)
          
          # Skip all subsequent identical characters
          while (i + 1 <= nchar(word) && substr(word, i + 1, i + 1) == current) {
            i <- i + 1
          }
          
          i <- i + 1
        }
        
        # Replace the original word with the normalized one
        input <- stringr::str_replace_all(input, fixed(word), normalized_word)
      }
      
      return(input)
    },
    
    #' @description
    #' Remove text surrounded by asterisks and fixes any resulting extra spaces.
    #' @param input The text to normalize.
    #' @return The text without asterisk content and no extra spaces.
    remove_asterisks = function(input) {
      if (is.null(input) || input == "") {
        return(input)
      }
      
      # Remove text between asterisks completely
      result <- stringr::str_replace_all(input, "\\*[^*]*\\*", "")
      
      # Fix any resulting double spaces or more
      result <- stringr::str_replace_all(result, "\\s{2,}", " ")
      
      return(result)
    },
    
    #' @description
    #' Normalize capitalization of words.
    #' @param input The text to normalize.
    #' @return The text with normalized capitalization.
    normalize_casing = function(input) {
      if (is.null(input) || input == "") {
        return(input)
      }
      
      # Split by words and process each word
      words <- unlist(stringr::str_extract_all(input, "\\b\\w+\\b"))
      
      for (word in words) {
        if (self$has_mixed_casing(word)) {
          # Convert everything to lowercase
          normalized <- tolower(word)
          
          # First letter uppercase if the original was uppercase
          if (stringr::str_detect(substr(word, 1, 1), "[A-Z]")) {
            normalized <- paste0(toupper(substr(normalized, 1, 1)), 
                                substr(normalized, 2, nchar(normalized)))
          }
          
          # Replace the original word with the normalized one
          input <- stringr::str_replace_all(input, fixed(word), normalized)
        }
      }
      
      return(input)
    },
    
    #' @description
    #' Check if a word contains mixed capitalization.
    #' @param word The word to check.
    #' @return TRUE if the word has mixed capitalization, otherwise FALSE.
    has_mixed_casing = function(word) {
      if (is.null(word) || nchar(word) <= 1) {
        return(FALSE)
      }
      
      has_upper <- FALSE
      has_lower <- FALSE
      
      for (i in 1:nchar(word)) {
        char <- substr(word, i, i)
        
        if (stringr::str_detect(char, "[A-Z]")) {
          has_upper <- TRUE
        } else if (stringr::str_detect(char, "[a-z]")) {
          has_lower <- TRUE
        }
        
        if (has_upper && has_lower) {
          return(TRUE)
        }
      }
      
      return(FALSE)
    }
  )
)

# Example usage
# library(R6)
# 
# normalizer <- TextNormalizer$new()
# 
# # Example for text preprocessing
# text_input <- "Hellooo how areee you *cough* today? *laughs* It's a niiice day!"
# normalized_text <- normalizer$normalize_text(text_input)
# cat("Original input:", text_input, "\n")
# cat("Normalized text:", normalized_text, "\n")
# 
# # Example with mixed capitalization
# mixed_case_input <- "HeLLo ThERe!!! Hooooow are you??"
# normalized_case <- normalizer$normalize_text(mixed_case_input)
# cat("Original input:", mixed_case_input, "\n")
# cat("Normalized text:", normalized_case, "\n")