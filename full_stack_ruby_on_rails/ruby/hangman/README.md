# Hangman

Simple command‑line Hangman game written in Ruby.

## Description

The program picks a random word from a built‑in word list (`google-10000-english-no-swears.txt`) and
challenges the player to guess it one letter at a time. The player has six wrong attempts before losing.

## Features

- Human vs computer (single player)
- Random word selection from a word file
- Terminal-based gameplay with live status display
- Input validation and duplicate guess prevention
- Tracks guessed letters and wrong attempts
- Win/lose detection and result message

## Requirements

- Ruby (version 2.0 or higher)

## Usage

1. Clone or download the repository.
2. Navigate to the `hangman` directory.
3. Run the game:

```bash
ruby main.rb
```

### Gameplay rules

- You must enter a single lowercase letter (a–z).
- Repeated guesses are disallowed.
- Wrong guesses increment the attempt counter (max 6).
- The secret word is revealed one letter at a time as you guess correctly.

## Example session

Below is an example interaction with the game (user input after prompts):

```
Word: _ _ _ _ _ _ _
Guessed:
Wrong attempts: 0/6
Enter a letter: 1
Please enter ONE letter (a-z) only.
Enter a letter: 2
Please enter ONE letter (a-z) only.
Enter a letter: w

Word: _ _ _ _ _ _ _
Guessed: w
Wrong attempts: 1/6
Enter a letter: qq
Please enter ONE letter (a-z) only.
Enter a letter: ds
Please enter ONE letter (a-z) only.
Enter a letter: d

Word: _ _ _ _ _ _ d
Guessed: w, d
Wrong attempts: 1/6
Enter a letter:
Please enter ONE letter (a-z) only.
Enter a letter: d
You already guessed 'd'.
Enter a letter: f

Word: f _ _ _ _ _ d
Guessed: w, d, f
Wrong attempts: 1/6
Enter a letter: gb
Please enter ONE letter (a-z) only.
Enter a letter: g

Word: f _ g _ _ _ d
Guessed: w, d, f, g
Wrong attempts: 1/6
Enter a letter: n

Word: f _ g _ _ _ d
Guessed: w, d, f, g, n
Wrong attempts: 2/6
Enter a letter: r

Word: f _ g _ r _ d
Guessed: w, d, f, g, n, r
Wrong attempts: 2/6
Enter a letter: a

Word: f _ g _ r _ d
Guessed: w, d, f, g, n, r, a
Wrong attempts: 3/6
Enter a letter: o

Word: f _ g _ r _ d
Guessed: w, d, f, g, n, r, a, o
Wrong attempts: 4/6
Enter a letter: e

Word: f _ g _ r e d
Guessed: w, d, f, g, n, r, a, o, e
Wrong attempts: 4/6
Enter a letter: u

Word: f _ g u r e d
Guessed: w, d, f, g, n, r, a, o, e, u
Wrong attempts: 4/6
Enter a letter: i

Secret word is 'figured'
=== You win! ===
```

## Contributing

Contributions are welcome! Feel free to submit pull requests or open issues for improvements.

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/SalasNorman/theOdinProject-projectCompilation/blob/main/LICENSE) file for details.
