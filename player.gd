extends CharacterBody2D 

@export var speed = 300 
var screen_size
signal pontua
var ultima_direcao = 'cima'
@export var push_force = 100.0 # Força para empurrar

func _ready() -> void:
	$AnimatedSprite2D.animation = "parado_cima"
	$AnimatedSprite2D.play()
	screen_size = get_viewport_rect().size

func _physics_process(delta: float) -> void: # 2. Usamos physics_process para física
	var input_dir = Vector2.ZERO
	if Input.is_action_pressed("baixo"):
		input_dir.y += 1
	elif Input.is_action_pressed("cima"):
		input_dir.y -= 1
	elif Input.is_action_pressed("esquerda"):
		input_dir.x -= 1
	elif Input.is_action_pressed("direita"):
		input_dir.x += 1

	# 3. Em vez de position, alimentamos a variável nativa 'velocity'
	if input_dir.length() > 0:
		velocity = input_dir.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		velocity = Vector2.ZERO # Para o player se não houver input
		# ... (sua lógica de animação parado continua igual)
		if ultima_direcao == 'cima': $AnimatedSprite2D.animation = "parado_cima"
		if ultima_direcao == 'baixo': $AnimatedSprite2D.animation = "parado_baixo"
		if ultima_direcao == 'esquerda': $AnimatedSprite2D.animation = "parado_esquerda"
		if ultima_direcao == 'direita': $AnimatedSprite2D.animation = "parado_direita"

	# 4. A MÁGICA: move_and_slide resolve colisões e o movimento
	move_and_slide()
	
	# 5. Lógica para empurrar objetos (RigidBody2D)
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider() is RigidBody2D:
			collision.get_collider().apply_central_impulse(collision.get_normal() * -push_force)

	# Suas animações continuam iguais...
	if velocity.y > 0: $AnimatedSprite2D.animation = "baixo"
	elif velocity.y < 0: $AnimatedSprite2D.animation = "cima"
	if velocity.x > 0: $AnimatedSprite2D.animation = "direita"
	elif velocity.x < 0: $AnimatedSprite2D.animation = "esquerda"
	
	ultima_direcao = $AnimatedSprite2D.get_animation()
	
	# Clamp para não sair da tela (opcional, já que agora você terá paredes)
	global_position.x = clamp(global_position.x, 0, screen_size.x)
	global_position.y = clamp(global_position.y, 0, screen_size.y)
	
	teste_usar()
	
func teste_usar():
	if Input.is_action_just_pressed("usar"):
		print("usando, né?")
	if Input.is_action_just_released("usar"):
		print("parou")
