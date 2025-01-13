extends Control

signal handle_click  # Signal for when the spin button is pressed
signal handle_stop   # Signal for when the stop button is pressed

onready var spin := $SpinButton  
onready var stop := $StopButton  
onready var label := $Popup/Label  
onready var popup := $Popup 

func _ready() -> void:
	# Check and connect signals if not already connected
	if not spin.is_connected("pressed", self, "_on_SpinButton_pressed"):
		spin.connect("pressed", self, "_on_SpinButton_pressed")
	if not stop.is_connected("pressed", self, "_on_StopButton_pressed"):
		stop.connect("pressed", self, "_on_StopButton_pressed")
	
	# Set the size of the Popup and Label
	label.set_size(Vector2(700, 300))
	# Center the Label inside the Popup
	label.rect_position = popup.rect_size / 2 - label.rect_size / 2

# Handles the Spin button press and emits handle_click signal
func _on_SpinButton_pressed():
	emit_signal("handle_click")

# Handles the Stop button press and emits handle_stop signal
func _on_StopButton_pressed():
	emit_signal("handle_stop")
	
# Shows the popup and label for 3 seconds if is_victory is true
func _on_Base_game_result(is_victory):
	if is_victory:
		popup.show()
		label.show() 
		yield(get_tree().create_timer(3.0), "timeout")
		label.hide() 
		popup.hide() 
