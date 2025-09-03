extends Area2D
signal create_item
signal set_text

func _on_body_entered(body: Node2D = null) -> void:
	var flash = $PointLight2D
	flash.enabled = true
	flash.energy = 1.0
	flash.scale = Vector2(1.5, 1.5)
	
	# ใช้ Tween ทำให้หายไป
	var tween = create_tween()
	tween.tween_property(flash, "energy", 0.0, 1)  # ค่อยๆ ดับใน 0.5 วิ
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
		emit_signal("create_item")
		body.queue_free()
		print("ทำลายบล้อคหได้")
