# TextNormalizer

<div align="center">

![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)
![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)

**A multi-language library for normalizing text with unusual formatting and informal writing styles**

[Key Features](#key-features) •
[Implementations](#implementations) •
[Installation](#installation) •
[Usage](#usage) •
[Documentation](#documentation) •
[Contributing](#contributing) •
[License](#license)

</div>

---

## Introduction

TextNormalizer is a flexible, multi-language library designed to clean and standardize text data that contains irregular formatting commonly found in informal writing, chat messages, and social media content.

The library addresses several key text normalization challenges, ensuring your text is clean and consistent before further processing or analysis.

## Key Features

- **Character Repetition Handling** - Converts stretched words like "hellooooo" to "hello"
- **Asterisk Content Removal** - Eliminates text enclosed in asterisks such as "*cough*" or "*laughs*"
- **Capitalization Normalization** - Standardizes inconsistent capitalization like "HeLLo" to "Hello"
- **Extra Space Cleanup** - Prevents multiple spaces that might result from other normalization operations

## Implementations

This library is available in multiple programming languages, allowing seamless integration with your existing technology stack:

| Language | File Location | Dependencies |
|----------|---------------|--------------|
| JavaScript | [`js/textNormalizer.js`](./js/textNormalizer.js) | None |
| TypeScript | [`typescript/textNormalizer.ts`](./typescript/textNormalizer.ts) | None |
| Python | [`python/text_normalizer.py`](./python/text_normalizer.py) | None |
| C# | [`csharp/TextNormalizer.cs`](./csharp/TextNormalizer.cs) | System.Text.RegularExpressions |
| C++ | [`cpp/TextNormalizer.cpp`](./cpp/TextNormalizer.cpp) | Standard library (regex, string) |
| Go | [`go/text_normalizer.go`](./go/text_normalizer.go) | regexp, strings |
| Swift | [`swift/TextNormalizer.swift`](./swift/TextNormalizer.swift) | Foundation |
| Rust | [`rust/text_normalizer.rs`](./rust/text_normalizer.rs) | regex |
| Kotlin | [`kotlin/TextNormalizer.kt`](./kotlin/TextNormalizer.kt) | kotlin.text |
| R | [`r/text_normalizer.R`](./r/text_normalizer.R) | R6, stringr |

## Installation

Each language implementation can be used independently. Simply integrate the relevant files into your project:

### JavaScript/TypeScript
```bash
cp js/textNormalizer.js YOUR_PROJECT_DIR/
# or for TypeScript
cp typescript/textNormalizer.ts YOUR_PROJECT_DIR/
```

### Python
```bash
cp python/text_normalizer.py YOUR_PROJECT_DIR/
```

### C#
```bash
cp csharp/TextNormalizer.cs YOUR_PROJECT_DIR/
```

### C++
```bash
cp cpp/TextNormalizer.h cpp/TextNormalizer.cpp YOUR_PROJECT_DIR/
```

### Go
```bash
cp go/text_normalizer.go YOUR_PROJECT_DIR/pkg/
```

### Swift
```bash
cp swift/TextNormalizer.swift YOUR_PROJECT_DIR/Sources/
```

### Rust
```bash
# Add to your Cargo.toml
# text_normalizer = { path = "path/to/text_normalizer" }
cp rust/text_normalizer.rs YOUR_PROJECT_DIR/src/
cp rust/Cargo.toml YOUR_PROJECT_DIR/
```

### Kotlin
```bash
cp kotlin/TextNormalizer.kt YOUR_PROJECT_DIR/src/main/kotlin/com/example/textnormalizer/
```

### R
```bash
cp r/text_normalizer.R YOUR_PROJECT_DIR/
# Ensure R6 and stringr packages are installed
# install.packages(c("R6", "stringr"))
```

## Usage

Here are examples of how to use TextNormalizer in various languages:

### JavaScript

```javascript
const TextNormalizer = require('./textNormalizer.js');
const normalizer = new TextNormalizer();

const normalized = normalizer.normalizeText("Hellooo how areee you *cough* today?");
console.log(normalized);  // "Hello how are you today?"
```

### TypeScript

```typescript
import { TextNormalizer } from './textNormalizer';
const normalizer = new TextNormalizer();

const normalized = normalizer.normalizeText("Hellooo how areee you *cough* today?");
console.log(normalized);  // "Hello how are you today?"
```

### Python

```python
from text_normalizer import TextNormalizer

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
#include "TextNormalizer.h"
#include <iostream>

int main() {
    TextNormalizer normalizer;
    std::string normalized = normalizer.normalizeText("Hellooo how areee you *cough* today?");
    std::cout << normalized << std::endl;  // "Hello how are you today?"
    return 0;
}
```

### Go

```go
package main

import (
    "fmt"
    "textnormalizer"
)

func main() {
    normalizer := textnormalizer.NewTextNormalizer()
    normalized := normalizer.NormalizeText("Hellooo how areee you *cough* today?")
    fmt.Println(normalized)  // "Hello how are you today?"
}
```

### Swift

```swift
import Foundation

let normalizer = TextNormalizer()
let normalized = normalizer.normalizeText("Hellooo how areee you *cough* today?")
print(normalized)  // "Hello how are you today?"
```

### Rust

```rust
use text_normalizer::TextNormalizer;

fn main() {
    let normalizer = TextNormalizer::new();
    let normalized = normalizer.normalize_text("Hellooo how areee you *cough* today?");
    println!("{}", normalized);  // "Hello how are you today?"
}
```

### Kotlin

```kotlin
import com.example.textnormalizer.TextNormalizer

fun main() {
    val normalizer = TextNormalizer()
    val normalized = normalizer.normalizeText("Hellooo how areee you *cough* today?")
    println(normalized)  // "Hello how are you today?"
}
```

### R

```r
library(R6)
source("text_normalizer.R")

normalizer <- TextNormalizer$new()
normalized <- normalizer$normalize_text("Hellooo how areee you *cough* today?")
cat(normalized)  # "Hello how are you today?"
```

## Documentation

### Common API Across All Implementations

Each language implementation provides the following core methods with consistent behavior:

| Method | Description |
|--------|-------------|
| **normalizeText** | Apply all normalization rules to clean the input text |
| **normalizeRepeatedCharacters** | Remove stretched character sequences |
| **removeAsterisks** | Remove text enclosed in asterisks |
| **normalizeCasing** | Fix inconsistent capitalization |

> Note: Method naming follows language conventions (camelCase for JavaScript/TypeScript, snake_case for Python/R, PascalCase for C#/C++/Swift, etc.)

### Advanced Usage

For more granular control, you can apply specific normalization rules individually:

```javascript
// JavaScript example of selective normalization
const normalizer = new TextNormalizer();

// Only fix repeated characters
const text1 = normalizer.normalizeRepeatedCharacters("Hellooooo there!");

// Only remove asterisk content
const text2 = normalizer.removeAsterisks("Hello *waves* there!");

// Only normalize capitalization
const text3 = normalizer.normalizeCasing("HeLLo ThERe!");
```

## Contributing

Contributions are welcome and appreciated! Here's how you can contribute:

1. **Fork** the repository on GitHub
2. **Clone** the project to your machine
3. **Commit** changes to your own branch
4. **Push** your work back up to your fork
5. Submit a **Pull Request** so your changes can be reviewed

### Contribution Guidelines

- Ensure cross-language consistency for any new features
- Add tests for new functionality
- Update documentation to reflect changes
- Follow language-specific code style guidelines

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

<div align="center">
  <sub>Built with ❤️ by the open source community</sub>
</div>
