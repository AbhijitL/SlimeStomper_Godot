extends State

export var max_speed_default : float = 10.0;
export var acceleration_dafault : = Vector3(25,50,25);
export var decceleration_default: = Vector3(50,0,50);
export var gravity_default: float = 70;
export var jump_impulse = 25;


var gravity = gravity_default;
var max_speed = max_speed_default;
var acceleration = acceleration_dafault;
var deacceleration = decceleration_default;
var velocity = Vector3.ZERO;


func unhandled_input(event: InputEvent) -> void:
	if owner.is_on_floor() and event.is_action_pressed("jump"):
		_state_machine.transition_to("Move/Air",{impulse = true});

func physics_process(delta)->void:
	velocity = calculate_velocity(velocity,max_speed,delta,gravity,get_input_vector());
	if get_input_vector() != Vector3.ZERO:
		owner.pivot.look_at(owner.translation + get_input_vector(), Vector3.UP)
	velocity = owner.move_and_slide(velocity,Vector3.UP);


func get_input_vector() -> Vector3:
	var input_vector = Vector3.ZERO
	input_vector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	input_vector.z = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	return input_vector.normalized() if not owner.player_dead else Vector3(0,0,0);
	

static func calculate_velocity(old_velocity:Vector3,max_speed: float, delta:float, gravity: float,
	input_vector: Vector3) -> Vector3:
	var new_velocity = old_velocity;
	new_velocity.y -=  gravity * delta;
	new_velocity.x = clamp((input_vector.x * max_speed),-max_speed,max_speed);
	new_velocity.z = clamp((input_vector.z * max_speed),-max_speed,max_speed);
	return new_velocity;


func enter(msg: Dictionary={})-> void:
		pass;

func exit()->void:
	pass;
