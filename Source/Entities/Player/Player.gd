extends KinematicBody
class_name Player

export var move_radius: float= 4;
export var player_health_default = 1;

onready var pivot = $Pivot
onready var collider : CollisionShape = $CollisionShape;
onready var _state_machine: StateMachine = $StateMachine;
onready var tween : Tween = $Tween;
onready var slime_skin : = $Pivot/Slime;
onready var audio_player : AudioStreamPlayer3D = $PlayerAudio3D;

var is_active : bool = true setget set_is_active;
var player_health : int = player_health_default;
var prev_player_health : int=0;


func _ready():
	yield(owner,"ready");
	Events.connect("player_health_change",self, "_On_player_health_change");
	Events.emit_signal("player_health_change",player_health,player_health);

func _On_player_health_change(health,previous_health)->void:
	player_health = health;

func set_is_active(value:bool)->void:
	is_active = value;
	if not collider:
		return;
	collider.disable = not value;


func _on_PlayerHitArea_area_entered(area:Area):
	if area.name == "PlayerHitArea":
		_state_machine.transition_to("Move/Hit");
		pass;
