extends Area2D

@export var speed = 50
var screen_size
signal pontua


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2()
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	elif Input.is_action_pressed("ui_up"):
		velocity.y -= 1
	elif Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	elif Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	position += velocity*delta
	position.x = clamp(position.x,0,screen_size.x)
	position.y = clamp(position.y,0,screen_size.y)
	if velocity.y > 0:
		$AnimatedSprite2D.animation = "baixo"
	elif velocity.y < 0:
		$AnimatedSprite2D.animation = "cima"
	if velocity.x > 0:
		$AnimatedSprite2D.animation = "direita"
	elif velocity.x < 0:
		$AnimatedSprite2D.animation = "esquerda"
