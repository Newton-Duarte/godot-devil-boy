extends Node

var current_level := 0
var lives := 3
var gems_collected := 0

# Called when the node enters the scene tree for the first time.
func _ready():
	print("Global is ready.")
	
func _input(event):
	if event.is_action_pressed("return_to_main_menu"):
		get_tree().change_scene_to_file("res://scenes/main_menu.tscn")

func set_level(level: int):
	current_level = level
	update_hud()

func collect_gem():
	gems_collected += 1
	update_hud()
	
func lose_life():
	lives -= 1
	update_hud()
	if lives <= 0:
		game_over()
	else:
		get_tree().reload_current_scene()

func reset():
	current_level = 0
	lives = 3
	gems_collected = 0
	
func update_hud():
	for node in get_tree().get_nodes_in_group("hud"):
		node.update_hud()
	
func game_over():
	print("Game over")
	reset()
	get_tree().change_scene_to_file("res://scenes/main_menu.tscn")
