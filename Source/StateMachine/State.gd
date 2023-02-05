extends Node
class_name State

onready var _state_machine: = _get_state_machine(self)

var _parent: State = null


func _ready() -> void:
	yield(owner, "ready")
	var parent: = get_parent()
	if not parent.is_in_group("state_machine"):
		_parent = parent


func unhandled_input(event: InputEvent) -> void:
	return


func process(delta: float) -> void:
	return


func physics_process(delta: float) -> void:
	return


func enter(msg: Dictionary = {}) -> void:
	return


func exit() -> void:
	return


func _get_state_machine(node: Node) -> Node:
	if node != null and not node.is_in_group("state_machine"):
		return _get_state_machine(node.get_parent())
	return node