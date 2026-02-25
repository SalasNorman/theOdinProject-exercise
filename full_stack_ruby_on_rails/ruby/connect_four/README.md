# Connect Four

A simple Ruby terminal Connect Four game (human vs computer).

## Description

This is a command-line Connect Four game implemented in Ruby. The board has 6 rows and 7 columns. Players take turns dropping pieces into columns; the first to align four of their pieces vertically, horizontally, or diagonally wins. The board display uses the `rainbow` gem to color `O` (blue) and `X` (red).

## Features

- Human vs computer
- Terminal board display with colored symbols (uses the `rainbow` gem)
- Validates player input and prevents invalid moves
- Detects wins in all directions and handles draws
- Simple computer opponent picks a random available column (requires improvement to be smarter)

## Requirements

- Ruby (version 2.0 or higher)
- The `rainbow` gem (included in the `Gemfile`)

## Usage

1. Clone or download the repository.
2. Navigate to the `connect_four` directory.
3. Install dependencies (optional, uses the Gemfile):

```bash
bundle install
```

4. Run the game:

```bash
ruby main.rb
```

Follow on-screen prompts to enter a column number (1–7).

## Test‑Driven Development (TDD)

This project was developed using an RSpec‑based TDD workflow. A full test suite lives in the `spec/` directory and covers core behaviour of the board, player, computer, checker, and game logic.

To run the tests:

```bash
cd connect_four
bundle exec rspec
```

Start by writing a failing example in one of the spec files (or create a new one), then implement the minimal code in `lib/` or elsewhere to make the test pass. Repeat the cycle and refactor with confidence since the suite will catch regressions.

### Writing New Tests

- Load helpers with `require_relative 'spec_helper'` at the top of each spec.
- Use `describe` / `context` blocks to group related examples.
- Stub user input (e.g. `allow_any_instance_of(Player).to receive(:gets).and_return("3\n")`) when testing interactive methods.

Existing examples show assertions for object state, output capture, and handling of random behaviour and corner cases.

## Live Demo

No live demo available.

## Examples

When you run the game, the output looks like this (player input shown after prompts):

```
Enter your name:
John
1 2 3 4 5 6 7
. . . . . . .
. . . . . . .
. . . . . . .
. . . . . . .
. . . . . . .
. . . . . . .
John (X), choose a column (1-7):
1
1 2 3 4 5 6 7
. . . . . . .
. . . . . . .
. . . . . . .
. . . . . . .
. . . . . . .
X . . . . . .
Computer (O) is thinking...
Computer drops piece in column 3
1 2 3 4 5 6 7
. . . . . . .
. . . . . . .
. . . . . . .
. . . . . . .
. . . . . . .
X . O . . . .
John (X), choose a column (1-7):
1
1 2 3 4 5 6 7
. . . . . . .
. . . . . . .
. . . . . . .
. . . . . . .
X . . . . . .
X . O . . . .
Computer (O) is thinking...
Computer drops piece in column 5
1 2 3 4 5 6 7
. . . . . . .
. . . . . . .
. . . . . . .
. . . . . . .
X . . . . . .
X . O . O . .
John (X), choose a column (1-7):
1
1 2 3 4 5 6 7
. . . . . . .
. . . . . . .
. . . . . . .
X . . . . . .
X . . . . . .
X . O . O . .
Computer (O) is thinking...
Computer drops piece in column 3
1 2 3 4 5 6 7
. . . . . . .
. . . . . . .
. . . . . . .
X . . . . . .
X . O . . . .
X . O . O . .
John (X), choose a column (1-7):
1
1 2 3 4 5 6 7
. . . . . . .
. . . . . . .
X . . . . . .
X . . . . . .
X . O . . . .
X . O . O . .
=== John wins! ===
```

Human uses `X` and computer uses `O` (adjust symbols depending on implementation). Winning or draw messages are printed when the game ends.

> **Note:** the computer’s AI is very basic and only selects columns at random. Consider enhancing it with lookahead or blocking logic for a more challenging opponent.

## Contributing

Contributions are welcome! Please submit a Pull Request or open an Issue for improvements.

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/SalasNorman/theOdinProject-projectCompilation/blob/main/LICENSE) file for details.
