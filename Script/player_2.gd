extends CharacterBody2D
@export var Speed = 250.0
@export var bomb_sprite: PackedScene
@export var landmine_sprite: PackedScene
var action = true
var screen_size = Vector2.ZERO
var number_bombs = 10
var scale_fire = 1.0
var radius = 75
var texture_scale = 1
signal tricker

func _ready() -> void:
	screen_size = get_viewport_rect().size
	action = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = Vector2.ZERO
	if Input.is_action_pressed("ui_up") && Input.is_action_pressed("ui_right"):
		direction.y -= 0.7
		direction.x += 0.7
		$AnimatedSprite2D.play("Walk_up_right")
	elif Input.is_action_pressed("ui_up") && Input.is_action_pressed("ui_left"):
		direction.y -= 0.7
		direction.x -= 0.7
		$AnimatedSprite2D.play("Walk_up_left")
	elif Input.is_action_pressed("ui_down") && Input.is_action_pressed("ui_right"):
		direction.y += 0.7
		direction.x += 0.7
		$AnimatedSprite2D.play("Walk_down_right")
	elif Input.is_action_pressed("ui_down") && Input.is_action_pressed("ui_left"):
		direction.y += 0.7
		direction.x -= 0.7
		$AnimatedSprite2D.play("Walk_down_left")
	elif Input.is_action_pressed("ui_right"):
		$AnimatedSprite2D.play("Walk_right")
		direction.x += 1
	elif Input.is_action_pressed("ui_left"):
		$AnimatedSprite2D.play("Walk_left")
		direction.x -= 1
	elif Input.is_action_pressed("ui_up"):
		$AnimatedSprite2D.play("Walk_up")
		direction.y -= 1
	elif Input.is_action_pressed("ui_down"):
		$AnimatedSprite2D.play("Walk_down")
		direction.y += 1
	else:
		$AnimatedSprite2D.play("idle")
	
	position.x = clamp(position.x,0,screen_size.x)
	position.y = clamp(position.y,0,screen_size.y)	
	if direction != Vector2.ZERO:
		position += delta*Speed*direction
	else:
		velocity = Vector2.ZERO
	move_and_slide()

	
	if Input.is_action_just_pressed("Drop_bomb_p2"):
		if number_bombs >= 1:
			number_bombs -= 1
			emit_signal("tricker",self)
			create_bomb()
		
	if Input.is_action_just_pressed("Drop_landmine_p2"):
		if number_bombs >= 2:
			number_bombs -= 2
			emit_signal("tricker",self)
			create_landmine()

func create_bomb():
	if bomb_sprite:
		var bomb = bomb_sprite.instantiate()
		bomb.position = position
		get_parent().add_child(bomb)
		bomb.get_node("fire").queue_free()
		bomb.get_node("fire2").hide()
		bomb.get_node("CollisionShape2DFire").disabled = true
		bomb.get_node("bomb").play("bomb")
		
		var timer = get_tree().create_timer(1.5)
		await timer.timeout
		$Sound.play()
		bomb.get_node("bomb").queue_free()
		bomb.get_node("fire2").set_scale(Vector2(scale_fire,scale_fire))
		bomb.get_node("fire2").show()
		bomb.get_node("fire2").play("Fire")
		bomb.get_node("CollisionShape2DFire").shape.set_radius(radius)
		bomb.get_node("CollisionShape2DFire").disabled = false
		var timer2 = get_tree().create_timer(0.33)
		await timer2.timeout
		bomb.get_node("CollisionShape2DFire").disabled = true
		bomb.get_node("fire2").queue_free()
		
		
func create_landmine():
	if landmine_sprite:
		var landmine = landmine_sprite.instantiate()
		landmine.position = position
		get_parent().add_child(landmine)
		landmine.get_node("CollisionShape2D").disabled = true
		var timer = get_tree().create_timer(2.0)
		await timer.timeout
		landmine.get_node("Sprite2D").hide()
		landmine.get_node("Sprite2D2").show()
		landmine.get_node("CollisionShape2D").disabled = false
