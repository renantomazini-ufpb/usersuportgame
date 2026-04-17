extends Area2D

#@export var usando = false
signal pronto
var player_na_area = false
var terminado = false

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("computadores")
	$Timer.wait_time = 5.0
	$ProgressBar.max_value = $Timer.wait_time
	$ProgressBar.value = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not $Timer.is_stopped():
		$ProgressBar.value = $Timer.wait_time - $Timer.time_left
		print("Tempo restante: ", snapped($Timer.time_left, 0.1)) # vai atualizar o timeleft?


func _on_area_entered(area: Area2D) -> void:
	print("Entrou " + String(self.name))
	$Pc1.visible = true
	$Pc2.visible = false
	player_na_area = true



func _on_area_exited(area: Area2D) -> void:
	print("Saiu") # Replace with function body.
	if !terminado:
		player_na_area = false
		$Pc1.visible = false
		$Pc2.visible = true
		$ProgressBar.set_visible(false)
		$Timer.stop()
		$Timer.set_wait_time(5.0)
	$ProgressBar.set_visible(false)

func _on_timer_timeout():
	terminado = true
	emit_signal("pronto")


		
func usando():
	print("teste importante")
	if player_na_area and !terminado:
		print("teste passado!")
		$ProgressBar.set_visible(true)
		$Timer.start()
