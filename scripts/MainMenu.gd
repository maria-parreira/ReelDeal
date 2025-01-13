extends Control

onready var start_button = $StartButton 
onready var transition_scene = preload("res://scenes/ScreenTransition.tscn")  # Preload the scene for the screen transition

func _ready():
	# Connect the button press signal to the handler if not already connected
	if not start_button.is_connected("pressed", self, "_on_StartButton_pressed"):
		start_button.connect("pressed", self, "_on_StartButton_pressed")

# Handler for StartButton press event
func _on_StartButton_pressed():
	var transition = transition_scene.instance()  # Create an instance of the ScreenTransition scene
	add_child(transition)  # Add the transition instance to the MainMenu scene
	transition.start_transition("res://scenes/SlotMachine.tscn")  # Start the transition to the SlotMachine
