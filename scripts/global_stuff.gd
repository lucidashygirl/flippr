extends Node


var i = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Input.is_action_just_pressed("input_next"):
		next_level()
	if Input.is_action_just_pressed("input_prev"):
		prev_level()
	# if no level past the current one is detected
	# changes scene to level[i].tscn

func next_level():
	if ResourceLoader.exists("res://scenes/Level" + str(i + 1) + ".tscn") == false: 
		i = 1 
	else:
		i += 1
	get_tree().change_scene_to_file("res://scenes/Level" + str(i) + ".tscn")
		
func prev_level():
	if ResourceLoader.exists("res://scenes/Level" + str(i - 1) + ".tscn") == false: 
		i = 8 
	else:
		i -= 1
	get_tree().change_scene_to_file("res://scenes/Level" + str(i) + ".tscn")
