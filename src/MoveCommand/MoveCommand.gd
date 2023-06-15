extends Node

var direction :=Vector2.ZERO

func do_move() -> void:
	get_parent().move_character(direction)

func undo_move() -> void:
	get_parent().move_character(direction * -1)
	queue_free()
