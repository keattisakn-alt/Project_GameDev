extends Node2D


func _ready() -> void:
	pass

func _process(delta: float) -> void:
	pass
	
func update_bomb_label(Player):
	if Player.name == "Player1":
		$Player1/Label_P1.text = str(Player.number_bombs)
	elif Player.name == "Player2":
		$Player2/Label_P2.text = str(Player.number_bombs)

func _on_item_up_bombs(player) -> void:
	update_bomb_label(player)

func _on_player_1_tricker(Player) -> void:
	update_bomb_label(Player)
	

func _on_player_2_tricker(Player) -> void:
	update_bomb_label(Player)


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://tscn/select_map.tscn")


func _on_button_2_pressed() -> void:
	get_tree().quit()

func set_P1_win():
	var timer = get_tree().create_timer(1.0)
	await timer.timeout
	$PointLight2D.show()
	$Player1/Label_P1.hide()
	$Panel.show()
	$Summary.text = 'Player1 is winner!'
	$Summary.show()
	$Button.show()
	$Button2.show()

func set_P2_win():
	var timer = get_tree().create_timer(1.0)
	await timer.timeout
	$PointLight2D.show()
	$Player2/Label_P2.hide()
	$Panel.show()
	$Summary.text = 'Player2 is winner!'
	$Summary.show()
	$Button.show()
	$Button2.show()

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player1":
		body.action = false
		set_P2_win()
	elif body.name == "Player2":
		body.action = false
		set_P1_win()
