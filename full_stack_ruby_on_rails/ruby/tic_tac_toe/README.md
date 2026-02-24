# Tic Tac Toe

A simple Ruby terminal Tic Tac Toe game (human vs computer).

## Description

This is a command-line Tic Tac Toe game implemented in Ruby. The board uses positions 1–9. The human player uses the symbol `O` and the computer uses `X`. The game displays the board, validates moves, detects wins and ties, and prints result messages. The display uses the `rainbow` gem to color `O` (blue) and `X` (red).

## Features

- Human vs computer
- Terminal board display with colored symbols (uses the `rainbow` gem)
- Validates player input and prevents invalid moves
- Displays game results when a player wins or the game ends in a tie

## Requirements

- Ruby (version 2.0 or higher)
- The `rainbow` gem (included in the `Gemfile`)

## Usage

1. Clone or download the repository.
2. Navigate to the `tic_tac_toe` directory.
3. Install dependencies (optional, uses the Gemfile):

```bash
bundle install
```

4. Run the game:

```bash
ruby main.rb
```

Follow on-screen prompts to enter a move (1-9).

## Test‑Driven Development (TDD) 🧪

This project was developed using an RSpec‑based TDD workflow. A full test suite lives in the `spec/` directory and covers core behaviour of the board, player, computer, and game logic.

To run the tests:

```bash
cd tic_tac_toe
bundle exec rspec
```

Start by writing a failing example in one of the spec files (or create a new one), then implement the minimal code in `lib/` or elsewhere to make the test pass. Repeat the cycle and refactor with confidence since the suite will catch regressions.

### Writing New Tests

- Load helpers with `require_relative 'spec_helper'` at the top of each spec.
- Use `describe` / `context` blocks to group related examples.
- Stub user input (`allow($stdin).to receive(:gets).and_return("3\n")`) when testing interactive methods.

The existing examples demonstrate typical assertions for object state, output capture, and random behaviour.

You can also take advantage of **mocks and doubles** to isolate a unit of behaviour and assert that it interacts correctly with collaborators. For instance, when testing `Game#play_turn` you might substitute the real `Board`, `Player`, and `Computer` with test doubles that respond to the minimal API you need and record messages sent to them. This lets you verify that the game asks the player for a move, updates the board with the correct symbols, and invokes the computer only after the player’s turn, all without exercising the full board implementation.

## Live Demo

No live demo available.

## Examples

When you run the game, the output looks like this (player input shown after prompts):

```
1 | 2 | 3
----------
4 | 5 | 6
----------
7 | 8 | 9

Player Input:
1

O | 2 | 3
----------
4 | 5 | X
----------
7 | 8 | 9

Player Input:
2

O | O | 3
----------
4 | 5 | X
----------
7 | 8 | X

Player Input:
3
O | O | O
----------
4 | 5 | X
----------
7 | 8 | X

You Win!
```

The human player's symbol is `O` (message "You Win!" when human wins). The computer uses `X` (message "Computer Wins!" when computer wins). A tied game prints `It's a Tie!`.

## Contributing

Contributions are welcome! Please submit a Pull Request or open an Issue for improvements.

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/SalasNorman/theOdinProject-projectCompilation/blob/main/LICENSE) file for details.
