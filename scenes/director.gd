extends Node


@onready var computadores = get_tree().get_nodes_in_group("computadores")
@onready var player = $'objetos/player'

var num_comp
var com_pro = 0
var ganhou = false

func _ready() -> void:
	player.usar.connect(_on_player_usar)
	num_comp = len(computadores)
	for c in computadores:
		c.pronto.connect(_on_computador_pronto)

	
func _process(delta: float) -> void:
	player.usar.connect(teste)
	
func _on_computador_pronto():
	com_pro = com_pro + 1
	print(str(com_pro) + '/' + str(num_comp))
	if com_pro == num_comp:
		ganhou = true
		# trocar para tela de ganho e ir para próxima

	
func teste():
	print("testando o conectado de conserto")
	
func teste2():
	print("teste 2 de conect2")


func _on_player_usar():
	for c in computadores:
		c.usando()


func _on_computer_area_entered(area: Area2D) -> void:
	player.usar.connect(teste)
