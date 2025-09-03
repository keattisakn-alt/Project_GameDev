extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player1" || body.name == "Player2":
		body.texture_scale += 0.25
		body.get_node("PointLight2D").texture_scale = body.texture_scale 
		$Sprite2D.hide()
		$CollisionShape2D.disabled = true
		#$Sound.play()
		print(1)
		var timer = get_tree().create_timer(1.0)
		await timer.timeout
		print(2)
		queue_free()
