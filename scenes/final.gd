extends Node2D

var tempo_recebido = 0.0

func _ready() -> void:
	$Button_time.text = "Tempo: " + str(int(tempo_recebido))



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_button_play_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/Inicial.tscn")


func _on_gerar_pressed() -> void:
	var link = "https://renantomazini-ufpb.github.io/certificadorIFSG/?tempo=" + str(tempo_recebido)
	OS.shell_open(link)
	pass # Replace with function body.
