extends AnimatedSprite2D


func _on_animation_finished() -> void:
		var bomb = get_parent().get_node("Bomb") # หรือส่ง reference มาด้วย
		bomb.queue_free()
