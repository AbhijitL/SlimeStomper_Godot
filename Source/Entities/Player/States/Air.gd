extends State

export var acceleration_z := 20;
export var jump_impulse := 30;


func unhandled_input(event: InputEvent) -> void:
	var move = get_parent();
	move.unhandled_input(event);

func physics_process(delta: float) -> void:
	var move = get_parent();
	move.physics_process(delta);
	if owner.is_on_floor():
		print("on floor")
		var target_state := "Move/Idle" if move.get_input_vector().length() == 0.0 else "Move/Run";
		_state_machine.transition_to(target_state);

func enter(msg: Dictionary = {}) -> void:
	var move = get_parent();
	move.enter(msg);
	move.gravity = move.gravity + acceleration_z;
	if "impulse" in msg:
		jump();

	

func exit() -> void:
	var move = get_parent();
	move.gravity = move.gravity_default;
	owner.slime_skin.stop();
	move.exit();

func _calculate_jump_vector(impulse:=0.0)-> Vector3:
	var move = get_parent();
	return move.calculate_velocity(
		move.velocity,
		move.max_speed,
		1,
		impulse,
		Vector3.UP
	);

func jump():
	if owner.is_on_floor() and Input.is_action_just_pressed("jump"):
		get_parent().velocity.y = jump_impulse;
		owner.slime_skin.play("Jump");
		Events.emit_signal("camera_shake",0.4);
