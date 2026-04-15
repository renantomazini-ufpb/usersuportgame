extends Node


@onready var computador = $'objetos/MesaYTest/Computer'
@onready var player = $'objetos/player'

func _ready() -> void:
	player.usar.connect(teste)
	computador.area_entered.connect(teste2)
	
func teste():
	print("teste de conect")
	
func teste2():
	print("teste 2 de conect")
