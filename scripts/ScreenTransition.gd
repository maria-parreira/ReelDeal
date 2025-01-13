extends Control

# Path to the next scene to transition
var next_scene = ""

# Onready variables for child nodes
onready var fade_rect = $ColorRect
onready var tween = $Tween
onready var timer = Timer.new()  # Timer for delaying the scene change

# Starts the scene transition with a fade-in effect
func start_transition(to_scene: String):
	
	next_scene = to_scene  # Set the target scene

	# Add the Timer
	if not timer.is_inside_tree():
		add_child(timer)

	# Configure the Timer
	timer.one_shot = true  # Set timer to trigger only once
	timer.wait_time = 1.5  # Duration of the fade-in effect
	timer.connect("timeout", self, "_on_timer_timeout")  # Connect timeout signal to handler
	timer.start()  # Start the timer

	# Animate fade-in effect (opacity from 0 to 1)
	tween.interpolate_property(
		fade_rect, "modulate:a",  # Target property: alpha channel of modulate color
		0, 1,  # Start and end values for opacity
		1.5,  # Duration of the animation
		Tween.TRANS_LINEAR,  # Linear transition type
		Tween.EASE_IN_OUT  # Ease in-out for smooth animation
	)
	tween.start()  # Start the fade-in animation

# Called when the Timer finishes (fade-in complete)
func _on_timer_timeout():
	"""
	Changes to the next scene after the fade-in animation completes.
	"""
	get_tree().change_scene(next_scene)

