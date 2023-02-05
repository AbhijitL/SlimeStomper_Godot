extends State

export var acceleration_z := 20;

func physics_process(delta: float) -> void:
	var move = get_parent();
	move.physics_process(delta);
	if owner.is_on_floor():
		print("enemy on floor")
		var target_state := "Move/Idle";
		_state_machine.transition_to(target_state,{from ="from Air State"});

func enter(msg: Dictionary = {}) -> void:
	var move = get_parent();
	move.enter(msg);
	move.gravity = move.gravity + acceleration_z;
	# move.mov_vec = Vector3.ZERO;


func exit() -> void:
	var move = get_parent();
	move.gravity = move.gravity_default;
	move.exit();
