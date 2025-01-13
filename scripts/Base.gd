extends TextureRect

# Signal to communicate the game result (win or loss) to the SlotMachine
signal game_result(is_victory)

# Constants and Variables
const TURN := -6300  # Reset position when the column moves past the last position
const INITIAL_SPEED := 70  # Initial movement speed
const TIME_INTERVAL := 0.025  # Time interval for movement updates

var rng := RandomNumberGenerator.new()  # Random number generator for variety
var valid_positions = [-6441, -5159, -3860, -2575, -1290, 0]  # List of valid Y positions
var win_positions = [-6441, 0]  # Winning positions on the Y-axis

onready var col = $Col  # Reference to the game symbols ("Col")

var move_speed := INITIAL_SPEED  # Current speed of movement
var stop_requested := false  # Flag to indicate a stop request
var is_playing := false  # Indicates whether the game is active

func _ready() -> void:
	"""
	Called when the node is added to the scene.
	Sets up connections and initializes the RNG.
	"""
	rng.randomize()  # Randomize RNG seed
	owner.connect("handle_click", self, "_handle_click")  # Connect click event
	owner.connect("handle_stop", self, "_handle_stop")  # Connect stop event

# Starts the game on click
func _handle_click() -> void:
	"""
	Handles click events to start the slot machine movement.
	"""
	if is_playing:
		return  # Ignore clicks if the game is already active

	is_playing = true
	stop_requested = false
	move_speed = INITIAL_SPEED

	while true:
		if stop_requested:
			yield(_slow_down(), "completed")  # Slow down the movement
			yield(_move_to_valid_position(), "completed")  # Align to a valid position
			_check_victory()  # Check if the game was won or lost
			is_playing = false
			break  # Exit the movement loop

		_move_column()  # Move the column
		yield(get_tree().create_timer(TIME_INTERVAL), "timeout")  # Wait for the next frame

# Handles the stop event
func _handle_stop() -> void:
	"""
	Signals the slot machine to stop.
	"""
	if not is_playing:
		return  # Ignore stop requests if the game isn't active

	stop_requested = true

# Moves the symbols downward
func _move_column() -> void:
	"""
	Moves the column downward and resets if it goes beyond the limit.
	"""
	if round(col.rect_position.y) >= 0:
		col.rect_position.y = TURN  # Reset position to TURN when reaching the bottom
	else:
		col.rect_position.y += move_speed  # Move downward by current speed

# Gradually slows down the movement
func _slow_down() -> GDScriptFunctionState:
	"""
	Gradually reduces the movement speed until the column stops.
	"""
	while move_speed > 0:
		move_speed -= 2  # Decrease speed gradually
		if move_speed < 0:
			move_speed = 0  # Ensure speed does not go negative

		col.rect_position.y += move_speed  # Apply the current speed to movement
		yield(get_tree().create_timer(TIME_INTERVAL), "timeout")  # Wait for the next frame

	return "completed"

# move the column to the closest valid Y position
func _move_to_valid_position() -> GDScriptFunctionState:
	"""
	Adjusts the column's position to the nearest valid position.
	"""
	var closest_position = valid_positions[0]
	var min_distance = abs(col.rect_position.y - closest_position)

	# Find the closest valid position
	for pos in valid_positions:
		var distance = abs(col.rect_position.y - pos)
		if distance < min_distance:
			min_distance = distance
			closest_position = pos

	# Smoothly move the column to the closest valid position
	while abs(col.rect_position.y - closest_position) > 0.5:
		col.rect_position.y = move_toward(col.rect_position.y, closest_position, 7)
		yield(get_tree().create_timer(TIME_INTERVAL), "timeout")

	col.rect_position.y = closest_position  # move to the exact position
	return "completed"

# Checks if the current position is a winning position
func _check_victory() -> void:
	"""
	Emits a signal indicating whether the column is in a winning position.
	"""
	if col.rect_position.y in win_positions:
		emit_signal("game_result", true)  # Emit victory signal
	else:
		emit_signal("game_result", false)  # Emit failure signal
