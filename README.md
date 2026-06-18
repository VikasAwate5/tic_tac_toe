# Tic Tac Toe

A clean and modern Tic Tac Toe game built with Flutter.

This app focuses on polished UI interactions for local 2-player gameplay:
- Animated turn indicator
- Win-cell highlighting
- Per-player score tracking
- Win and draw dialogs with quick replay
- One-tap full reset

## Screenshot

![App Screenshot](https://github.com/user-attachments/assets/bff294d3-e37b-4c33-9748-a19a6ccd544d)

## Features

- Local 2-player mode (`X` vs `O`) on a 3x3 board
- Automatic winner detection (rows, columns, diagonals)
- Draw detection when all 9 cells are filled
- Highlighted winning combination with glow effect
- Persistent in-session score board for Player X and Player O
- `Play Again` flow that clears only the board
- `Reset All` action that clears board and scores
- Responsive sizing using centralized dimension constants

## Tech Stack

- Flutter
- Dart
- Material UI widgets

## Requirements

Based on project configuration:
- Flutter SDK: `3.38.9` (from `.fvmrc`)
- Dart SDK: `>=3.10.8 <4.0.0` (from `pubspec.yaml`)

If you use FVM, it will pin the Flutter version automatically.

## Getting Started

1. Clone the repository.
2. Install dependencies.
3. Run the app on an emulator or physical device.

```zsh
cd /path/to/tic_tac_toe
flutter pub get
flutter run
```

If you use FVM:

```zsh
cd /path/to/tic_tac_toe
fvm install
fvm flutter pub get
fvm flutter run
```

## How to Play

1. Player O starts first.
2. Players take turns tapping empty cells.
3. First player to complete 3 in a row wins.
4. If all cells are filled with no winner, the game is a draw.
5. Use `Play Again` to start the next round.
6. Use `Reset All` to clear board state and scores.

## Project Structure

```text
lib/
  main.dart                      # App entry point
  home_page.dart                 # Game UI and game logic
  home_page_helper.dart          # Legacy helper widgets
  common/
	color_constants.dart         # Color palette
	dimens_constants.dart        # Spacing, sizing, animation tokens
test/
  widget_test.dart               # Default Flutter template test (needs update)
```

## Testing

Run tests with:

```zsh
cd /path/to/tic_tac_toe
flutter test
```

Note: `test/widget_test.dart` is currently the default Flutter counter test template and does not reflect this game's current UI. Updating it with game-specific widget tests is recommended.

## Build

Example release build command:

```zsh
cd /path/to/tic_tac_toe
flutter build appbundle
```

## Version

Current app version in `pubspec.yaml`: `1.0.0+2`

## Improvements You Can Add Next

- Single-player mode with AI
- Sound effects and haptics
- Theme switch (light/dark)
- Match history
- Better automated tests for turn flow, win detection, and reset behavior

## License

No license file is currently included in this repository. Add a `LICENSE` file if you plan to distribute the project publicly.
