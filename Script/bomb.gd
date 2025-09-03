extends Area2D
signal create_item
signal set_text

func _on_body_entered(body: Node2D = null) -> void:
	if (body.name == "Player1"):
		body.hide()
		
		print("ลบโหนดไม่ได้")
		var timer1 = get_tree().create_timer(0.6)
		await timer1.timeout
		print("ลบโหนดได้")
		body.queue_free()
	elif (body.name == "Player2"):
		body.hide()
		
		var timer2 = get_tree().create_timer(0.6)
		await timer2.timeout
		print("ลบโหนดได้")
		body.queue_free()
		
	elif (body.get_groups()):
	#else:
		emit_signal("create_item")
		body.queue_free()
		print("ทำลายบล้อคหได้")
