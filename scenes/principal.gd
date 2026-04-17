extends Node2D

var fase = 1
var ganhou


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var cena = load("res://scenes/cenario_1.tscn")
	var instancia = cena.instantiate()
	add_child(instancia)
	var director = instancia.get_node("director")
	director.ganhar.connect(_on_ganhar)
	fase = 1
	ganhou = false
	#get_tree().change_scene_to_file("res://scenes/cenario_1.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _on_ganhar():
	if ganhou: return 
	ganhou = true
	for n in get_children():
		n.queue_free()
	await get_tree().process_frame
	set_process(false) 
	fase += 1
	var caminho = "res://scenes/cenario_" + str(fase) + ".tscn"
	if FileAccess.file_exists(caminho):
		var nova_cena = load(caminho).instantiate()
		#get_tree().change_scene_to_file(caminho)
		add_child(nova_cena)
		var novo_director = nova_cena.get_node("director")
		novo_director.ganhar.connect(_on_ganhar)
		ganhou = false
	else:
		print("Sem novas fases")
