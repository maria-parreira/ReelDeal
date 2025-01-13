extends Popup

# Tempo em segundos para o popup desaparecer
export var display_duration: float = 3.0

func show_temporary():
	yield(get_tree().create_timer(display_duration), "timeout")
	self.hide()  # Esconde o popup automaticamente após o tempo
