extends Button

# Wait for 1.5 seconds and then play the "PlayButton" animation
func _ready():
	yield(get_tree().create_timer(1.5), "timeout") 
	$AnimationPlayer.play("PlayButton")  
