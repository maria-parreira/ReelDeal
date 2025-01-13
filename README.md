# Slot Machine Game

## Overview
This project is a slot machine game inspired by casino slot machines. The player interacts with the game by spinning and stopping the slot reels. If the symbols align in a winning combination, the player wins!

## How to Play
1. **Start the Game:**
   - Press the **Spin** button to start the slot reels. The symbols will begin moving downwards continuously.

2. **Stop the Reels:**
   - Press the **Stop** button to stop the reels. The symbols will align to a valid position on the grid.

3. **Win or Lose:**
   - After the reels stop, the game checks if the symbols align in a winning combination.
   - If it’s a winning combination, a victory signal is emitted and a popup window appears
   - Otherwise, the game signals a loss.

4. **Play Again:**
   - The game resets and you can spin again.

## Features
- **Slot Machine Animation:**
  - Symbols continuously move downwards, mimicking the behavior of a slot machine.
  - Smooth transitions and snapping to valid positions for realistic gameplay.

- **Winning Conditions:**
  - Specific positions (like the top or bottom of the reel) are designated as winning positions.
  - The game checks for these positions after the reels stop.

- **Scene Transition:**
  - A fade-in effect is used when transitioning between scenes for a polished experience.

## Code Highlights
### `slot_machine_logic.gd`
- Handles the core logic of the slot machine:
  - Movement of the symbols.
  - Gradual slowing of the reels when stopping.
  - Snapping symbols to valid positions.
  - Checking for winning combinations and signaling results.

### `scene_transition_control.gd`
- Manages scene transitions with smooth fade-in animations:
  - Configures and starts the fade-in effect.
  - Changes to the next scene after the animation completes.

## Installation
1. **Clone or Download the Repository:**
   - Clone this repository or download it as a ZIP file and extract it.

2. **Open in Godot:**
   - Open the project in Godot Engine.

3. **Run the Game:**
   - Click the **Play** button in Godot to start the game.

## Customization
- **Winning Positions:**
  - Modify the `win_positions` array in `slot_machine_logic.gd` to set custom winning conditions.

- **Animation Speed:**
  - Adjust `MOVE` and `time_interval` variables in `slot_machine_logic.gd` to change the speed of the reels.

- **Scene Transition Timing:**
  - Update the `wait_time` in `scene_transition_control.gd` to alter the duration of the fade-in effect.

## Future Improvements
- Add more winning combinations for increased complexity.
- Improve visual effects on scene transitions.
- Implement visual feedback for losing.

## Acknowledgments
- Developed using the Godot Engine and GDScript. 
- Inspired by traditional casino slot machines.

