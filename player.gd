extends Area2D

@export var speed = 50
var screen_size
signal pontua
var ultima_direcao = 'cima'

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$AnimatedSprite2D.animation = "parado_cima"
	$AnimatedSprite2D.play()
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
		if ultima_direcao == 'cima':
			$AnimatedSprite2D.animation = "parado_cima"
		if ultima_direcao == 'baixo':
			$AnimatedSprite2D.animation = "parado_baixo"
		if ultima_direcao == 'esquerda':
			$AnimatedSprite2D.animation = "parado_esquerda"
		if ultima_direcao == 'direita':
			$AnimatedSprite2D.animation = "parado_direita"
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
	ultima_direcao = $AnimatedSprite2D.get_animation()
	
