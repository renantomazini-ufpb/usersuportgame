extends Node2D

var tempo_recebido = 0.0

func _ready() -> void:
	$Button_time.text = "Tempo: " + str(int(tempo_recebido))



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Inicial.tscn")
