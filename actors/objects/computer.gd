extends Area2D

@export var usando = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.wait_time = 5.0
	$ProgressBar.max_value = $Timer.wait_time # A barra agora vai de 0 a 5
	$ProgressBar.value = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if not $Timer.is_stopped():
		$ProgressBar.value = $Timer.wait_time - $Timer.time_left
		print("Tempo restante: ", snapped($Timer.time_left, 0.1))


func _on_area_entered(area: Area2D) -> void:
	print("Entrou")
	$Pc1.visible = true
	$Pc2.visible = false
	if usando and $Timer.is_stopped():
		$ProgressBar.set_visible(true)
		$Timer.start()
		print("Timer iniciado!")


func _on_area_exited(area: Area2D) -> void:
	print("Saiu") # Replace with function body.
	$Pc1.visible = false
	$Pc2.visible = true
	$ProgressBar.set_visible(false)
	$Timer.stop()
	$Timer.set_wait_time(5.0)

func _on_timer_timeout():
	print("Pronto!!!!")
