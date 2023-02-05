extends State

export var max_speed_default : float = 500.0;
export var gravity_default: float = 50;

var gravity = gravity_default;
var max_speed = max_speed_default;
var mov_vec = Vector3.ZERO;

var input_vector: Vector3= Vector3.ZERO;

var goal_pos : Vector3;
var transform_ ;
var is_target_reachable_ : bool;
var distance_to_target_ ;


func _ready():
	pass;

func physics_process(delta)->void:

	# if owner.navi_agent.is_navigation_finished():
	# 	return;
	
	var target_pos = owner.navi_agent.get_next_location();
	var direction = owner.global_transform.origin.direction_to(target_pos);
	mov_vec = calculate_velocity(mov_vec,max_speed,delta,gravity,direction);
	owner.pivot.look_at(owner.translation + (Vector3(direction.x,0,0) + Vector3(0,0,direction.z)) *delta, Vector3.UP)
	mov_vec = owner.move_and_slide(mov_vec,Vector3.UP);

	transform_ = owner.global_transform.origin;
	is_target_reachable_ = owner.navi_agent.is_target_reachable();
	distance_to_target_ = owner.navi_agent.distance_to_target();

static func calculate_velocity(old_velocity:Vector3,max_speed: float, delta:float, gravity: float,
	input_vector: Vector3) -> Vector3:
	var new_velocity = old_velocity;
	new_velocity.y -=  gravity * delta;
	new_velocity.x = clamp((input_vector.x * max_speed * delta),-max_speed,max_speed);
	new_velocity.z = clamp((input_vector.z * max_speed * delta),-max_speed,max_speed);
	return new_velocity;

func enter(msg: Dictionary={})-> void:
		pass;

func exit()->void:
	pass;
