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

func _process(delta: float) -> void:
	var direction = Vector2.ZERO
	if Input.is_action_pressed("Move_up") && Input.is_action_pressed("Move_right") && action:
		direction.y -= 0.7
		direction.x += 0.7
		$AnimatedSprite2D.play("Walk_up_right")
	elif Input.is_action_pressed("Move_up") && Input.is_action_pressed("Move_left") && action:
		direction.y -= 0.7
		direction.x -= 0.7
		$AnimatedSprite2D.play("Walk_up_left")
	elif Input.is_action_pressed("Move_down") && Input.is_action_pressed("Move_right") && action:
		direction.y += 0.7
		direction.x += 0.7
		$AnimatedSprite2D.play("Walk_down_right")
	elif Input.is_action_pressed("Move_down") && Input.is_action_pressed("Move_left") && action:
		direction.y += 0.7
		direction.x -= 0.7
		$AnimatedSprite2D.play("Walk_down_left")
	elif Input.is_action_pressed("Move_right") && action:
		$AnimatedSprite2D.play("Walk_right")
		direction.x += 1
	elif Input.is_action_pressed("Move_left") && action:
		$AnimatedSprite2D.play("Walk_left")
		direction.x -= 1
	elif Input.is_action_pressed("Move_up") && action:
		$AnimatedSprite2D.play("Walk_up")
		direction.y -= 1
	elif Input.is_action_pressed("Move_down") && action:
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
	
	if Input.is_action_just_pressed("Drop_bomb_p1") && action:
		if number_bombs >= 1:
			number_bombs -= 1
			emit_signal("tricker",self)
			create_bomb()
	
	if Input.is_action_just_pressed("Drop_landmine_p1") && action:
		if number_bombs >= 2:
			number_bombs -= 2
			emit_signal("tricker",self)
			create_landmine()
	
func create_bomb():
	if bomb_sprite:
		var Bomb = bomb_sprite.instantiate()
		Bomb.position = position
		get_parent().add_child(Bomb)
		Bomb.get_node("fire").hide()
		Bomb.get_node("fire2").queue_free()
		Bomb.get_node("CollisionShape2DFire").disabled = true
		Bomb.get_node("bomb").play("bomb")
		
		var timer = get_tree().create_timer(1.5)
		await timer.timeout
		$Sound.play()  
		Bomb.get_node("bomb").queue_free()
		Bomb.get_node("fire").set_scale(Vector2(scale_fire,scale_fire))
		Bomb.get_node("fire").show()
		Bomb.get_node("fire").play("Fire")
		Bomb.get_node("CollisionShape2DFire").shape.set_radius(radius)
		Bomb.get_node("CollisionShape2DFire").disabled = false
		var timer2 = get_tree().create_timer(0.4)
		await timer2.timeout
		Bomb.get_node("CollisionShape2DFire").disabled = true
		Bomb.get_node("fire").queue_free()
		#Bomb.queue_free()
		

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
