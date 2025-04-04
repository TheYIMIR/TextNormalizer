# TextNormalizer

A multi-language library for normalizing text that contains unusual writing styles, emoticons, and inconsistent formatting.

## Overview

TextNormalizer helps clean up text data by handling common issues in informal writing:

- **Repeated Characters**: Converts stretched words like "hellooooo" to "hello"
- **Asterisk Content**: Removes text enclosed in asterisks like "*cough*" or "*laughs*"
- **Inconsistent Capitalization**: Normalizes mixed-case text like "HeLLo" to "Hello"

This is particularly useful for processing social media content, chat messages, or any text that needs normalization before further processing.

## Implementations

This repository contains implementations in multiple languages:

- [JavaScript](./js/textNormalizer.js)
- [C++](./cpp/TextNormalizer.cpp)
- [C#](./csharp/TextNormalizer.cs)
- [Python](./python/text_normalizer.py)
- [R](./r/text_normalizer.R)

## Usage Examples

### JavaScript

```javascript
const TextNormalizer = require('./js/textNormalizer.js');
const normalizer = new TextNormalizer();

const normalized = normalizer.normalizeText("Hellooo how areee you *cough* today?");
console.log(normalized);  // "Hello how are you today?"
```

### Python

```python
from python.text_normalizer import TextNormalizer

normalizer = TextNormalizer()
normalized = normalizer.normalize_text("Hellooo how areee you *cough* today?")
print(normalized)  # "Hello how are you today?"
```

### C#

```csharp
using TextProcessing;

TextNormalizer normalizer = new TextNormalizer();
string normalized = normalizer.NormalizeText("Hellooo how areee you *cough* today?");
Console.WriteLine(normalized);  // "Hello how are you today?"
```

### C++

```cpp
#include "cpp/TextNormalizer.h"
#include <iostream>

int main() {
    TextNormalizer normalizer;
    std::string normalized = normalizer.normalizeText("Hellooo how areee you *cough* today?");
    std::cout << normalized << std::endl;  // "Hello how are you today?"
    return 0;
}
```

### R

```r
library(R6)
source("r/text_normalizer.R")

normalizer <- TextNormalizer$new()
normalized <- normalizer$normalize_text("Hellooo how areee you *cough* today?")
cat(normalized)  # "Hello how are you today?"
```

## Features

Each implementation provides the following methods:

- **normalize_text** / **normalizeText** / **NormalizeText**: Apply all normalization rules
- **normalize_repeated_characters** / **normalizeRepeatedCharacters** / **NormalizeRepeatedCharacters**: Fix stretched-out words
- **remove_asterisks** / **removeAsterisks** / **RemoveAsterisks**: Remove text in asterisks
- **normalize_casing** / **normalizeCasing** / **NormalizeCasing**: Fix inconsistent capitalization

## Installation

Each language implementation can be used independently. Simply copy the relevant file(s) into your project:

- **JavaScript**: Copy `textNormalizer.js`
- **Python**: Copy `text_normalizer.py`
- **C#**: Copy `TextNormalizer.cs`
- **C++**: Copy `TextNormalizer.h` and `TextNormalizer.cpp` 
- **R**: Copy `text_normalizer.R` (requires R6 package)

## Dependencies

- **JavaScript**: No dependencies
- **Python**: No dependencies
- **C#**: System.Text.RegularExpressions
- **C++**: Standard library (regex, string)
- **R**: R6, stringr

## License

MIT License

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request or open an issue for any bugs or feature requests.
