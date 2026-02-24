**NOTE:** I only use AI for README and commit. That what AI use for.

# Caesar Cipher

A simple Ruby implementation of the Caesar cipher encryption algorithm.

## Description

The Caesar cipher is a type of substitution cipher where each letter in the plaintext is shifted a certain number of places down the alphabet. This project provides a Ruby script to encrypt text using this method, preserving case and non-alphabetic characters.

## Features

- Encrypts both uppercase and lowercase letters
- Leaves non-alphabetic characters unchanged
- Supports any integer shift value (positive or negative)

## Requirements

- Ruby (version 2.0 or higher)

## Usage

1. Clone or download the repository.
2. Navigate to the `caesar_cipher` directory.
3. Run the script:

   ```bash
   ruby caesar_cipher.rb
   ```

The script includes built-in examples that will print encrypted outputs.

## Test‑Driven Development (TDD) 🧪

This project was built using a TDD workflow:

1. Write a failing test in `spec/main_spec.rb` describing the desired behaviour.
2. Run the test suite with `rspec` to see it fail.
3. Implement the minimal code in `main.rb` to make the test pass.
4. Refactor as needed while keeping the tests green.
5. Repeat for the next feature.

You can execute the full test suite with:

```bash
cd ruby/caesar_cipher
rspec
```

Tests cover shifting uppercase and lowercase letters, handling non‑alphabetic characters, and using positive or negative shift values.

## Live Demo

Try the Caesar Cipher online: [Paiza.io Demo](https://paiza.io/projects/YJrAmE80O29pcilDIchu7w)

## Examples

```ruby
caesar_cipher("Hello World", 3)
# Output: "Khoor Zruog"

caesar_cipher("What a string!", 5)
# Output: "Bmfy f xywnsl!"
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request or open an Issue for any bugs, features, or improvements.

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/SalasNorman/theOdinProject-projectCompilation/blob/main/LICENSE) file for details.
