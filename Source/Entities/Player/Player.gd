extends KinematicBody
class_name Player

export var move_radius: float= 4;

onready var pivot = $Pivot
onready var collider : CollisionShape = $CollisionShape;
onready var _state_machine: StateMachine = $StateMachine;
onready var tween : Tween = $Tween;
onready var slime_skin : = $Pivot/Slime;

var is_active : bool = true setget set_is_active;


func _ready():
	yield(owner,"ready");

func set_is_active(value:bool)->void:
	is_active = value;
	if not collider:
		return;
	collider.disable = not value;


func _on_PlayerHitArea_area_entered(area:Area):
	if area.name == "PlayerHitArea":
		_state_machine.transition_to("Move/Hit");
		pass;
