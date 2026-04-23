extends Node2D

var fase = 1
var ganhou
var tempo = 0.0
var tempo_final = 0.0
signal  send_temp


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var cena = load("res://scenes/cenario_1.tscn")
	var instancia = cena.instantiate()
	$FaseContainer.add_child(instancia)
	var director = instancia.get_node("director")
	director.ganhar.connect(_on_ganhar)
	ganhou = false
	$Label.z_index = 3

	#get_tree().change_scene_to_file("res://scenes/cenario_1.tscn")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	tempo += delta
	$Label.text = str(int(tempo))
	
func _on_ganhar():
	if ganhou: return 
	ganhou = true
	for n in $FaseContainer.get_children():
		n.queue_free()
	await get_tree().process_frame
	set_process(false) 
	fase += 1
	if fase == 9:
		tempo_final = tempo
		
		var nova_cena = load("res://scenes/final.tscn").instantiate()
		nova_cena.tempo_recebido = tempo_final
		$FaseContainer.add_child(nova_cena)
		return
	var caminho = "res://scenes/cenario_" + str(fase) + ".tscn"
	var cena_recurso = load(caminho)
	if cena_recurso:
		var nova_cena = cena_recurso.instantiate()
		#get_tree().change_scene_to_file(caminho)
		$FaseContainer.add_child(nova_cena)
		var novo_director = nova_cena.get_node("director")
		novo_director.ganhar.connect(_on_ganhar)
		ganhou = false
		set_process(true)
	else:
		pass
		print("Erro! Sem caminho de fase")
