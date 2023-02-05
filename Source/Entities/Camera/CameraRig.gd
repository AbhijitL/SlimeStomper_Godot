extends Position3D

onready var camera : Camera = $CameraShake;

export var offset : Vector3 = Vector3(250,0,250);
export var player_range : Vector3  = Vector3(400,0.0,400);

onready var player_reference : Player;

var is_active : bool = true;

func _ready():
	player_reference = get_tree().get_nodes_in_group("Player")[0];
	Events.connect("camera_shake",self,"_On_Camera_shake");

func _On_Camera_shake(value)->void:
	camera.add_trauma(value);
	print("Camera shake");

func _physics_process(delta):
	update_position(delta);

func update_position(delta,velocity: Vector3 = Vector3.ZERO)->void:

	if not is_active:
		return;

	var player_pos : Vector3 = Vector3(player_reference.global_transform.origin.x,0,player_reference.global_transform.origin.z);

	var distance_ratio : = clamp(player_pos.length(),player_pos.y,player_range.z) / player_range.z; 
	camera.translation = lerp(camera.translation,(distance_ratio * player_pos.normalized() * offset),3*delta);
