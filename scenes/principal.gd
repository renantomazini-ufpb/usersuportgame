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
	for n in get_children():
		n.queue_free() 
	fase += 1
	var nova_fase = load("res://scenes/cenario_" + str(fase) + ".tscn").instantiate()
	add_child(nova_fase)
	nova_fase.get_node("director").ganhar.connect(_on_ganhar)
