extends KinematicBody2D

const TILE_SIZE = 64 
const command = preload("res://src/MoveCommand/MoveCommand.tscn")
# WASD to move
# Z to undo step
var inputs = {"move_right" : Vector2.RIGHT,
			  "move_left" : Vector2.LEFT,
			  "move_up" : Vector2.UP,
			  "move_down" : Vector2.DOWN}

func _unhandled_input(event: InputEvent) -> void:
		for direction_key in inputs.keys():
			if event.is_action_pressed(direction_key):
				call_move_command(inputs[direction_key])
		if event.is_action_pressed("back"):
			call_undo_command()
func move_character(direction) -> void:
		var target_pos = position + direction * TILE_SIZE
		position = target_pos

func call_move_command(direction) -> void:
		var command_instance = command.instance()
		self.add_child(command_instance)
		command_instance.direction = direction
		command_instance.do_move()

func call_undo_command() -> void:
	var temp_array = []
	for g in get_children():
			if g.is_in_group("command"):
					temp_array.append(g)
	if temp_array.size() != 0:
			temp_array[-1].undo_move()
