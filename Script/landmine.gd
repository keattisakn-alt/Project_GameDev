extends Area2D
#signal trigger_explode
var radius = 120


func _on_body_entered(body: Node2D) -> void:
	explode(body)


func explode(body: Node2D ) -> void:
	if (body.name == "Player1") || (body.name == "Player2"):
		$CollisionShape2D.shape.set_radius(radius)
		$Sprite2D2.hide()
		$AnimatedSprite2D.show()
		$AnimatedSprite2D.play("Fire")
		body.hide()
		var timer1 = get_tree().create_timer(0.5)
		await timer1.timeout
		if body != null:
			$AnimatedSprite2D.hide()
			body.queue_free()
			queue_free()
		else:
			$AnimatedSprite2D.hide()
		#queue_free()
	elif (body.name == "Block"):
		$CollisionShape2D.shape.set_radius(radius)
		$Sprite2D2.hide()
		$AnimatedSprite2D.show()
		$AnimatedSprite2D.play("Fire")
		body.hide()
		var timer4 = get_tree().create_timer(0.5)
		await timer4.timeout
		#if body != null:
			#body.queue_free()
			#queue_free()
		#else:
			#$AnimatedSprite2D.hide()
		body.queue_free()
		queue_free()
