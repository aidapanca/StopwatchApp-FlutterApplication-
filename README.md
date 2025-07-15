# Flutter Stopwatch Application ⏱️
Stopwatch application implemented using the Flutter framework. It integrates precise time tracking, lap recording, and real-time UI updates using asynchronous control structures. 

## 🔧 Features

- Accurate time tracking using Dart's `Stopwatch` API
- Real-time UI updates with `Timer.periodic` at 30ms resolution
- Lap (split) functionality with indexed storage and display
- Material 3 design system with custom pastel color palette
- Snackbar feedback on user actions
- Clear state transitions between running, paused, and reset states

## 📦 Technical Stack

- **Flutter** SDK
- **Dart** language
- **Material 3** components
- **StatefulWidget** for UI-state coupling

## 🧠 Logic Overview

- The `Stopwatch` instance manages the core time-tracking logic.
- A `Timer.periodic` with 30ms interval refreshes the display.
- Lap times are stored in a list and displayed in reverse order.
- The UI is rebuilt reactively using `setState()` based on the current state of the stopwatch.
