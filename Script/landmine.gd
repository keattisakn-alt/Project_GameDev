extends Area2D
#signal trigger_explode
var radius = 120


func _on_body_entered(body: Node2D) -> void:
	explode(body)


func explode(body: Node2D ) -> void:
	if (body.name == "Player1") || (body.name == "Player2"):
		var flash = $PointLight2D
		flash.enabled = true
		flash.energy = 1.0 
		flash.scale = Vector2(2, 2)
		var tween = create_tween()
		tween.tween_property(flash, "energy", 0.0, 1.5) 
		$Sound.play()
		$CollisionShape2D.shape.set_radius(radius)
		$Sprite2D2.hide()
		$AnimatedSprite2D.show()
		$AnimatedSprite2D.play("Fire")
		body.hide()
		var timer1 = get_tree().create_timer(1.5)
		await timer1.timeout
		if body != null:
			$AnimatedSprite2D.hide()
			body.queue_free()
			queue_free()
		else:
			$AnimatedSprite2D.hide()
	elif (body.name == "Block"):
		$CollisionShape2D.shape.set_radius(radius)
		$Sprite2D2.hide()
		$AnimatedSprite2D.show()
		$AnimatedSprite2D.play("Fire")
		body.hide()
		var timer4 = get_tree().create_timer(0.5)
		await timer4.timeout
		body.queue_free()
		queue_free()
