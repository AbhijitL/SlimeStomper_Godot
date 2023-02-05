extends KinematicBody
class_name Enemy


signal enemy_detected(value);
signal attack_enemy;
signal dead;


var player_reference : Player;
onready var pivot = $Pivot;
onready var collider : CollisionShape = $CollisionShape;
onready var _state_machine: StateMachine = $StateMachine;
onready var idle_timer : Timer = $IdleTimer;
onready var wander_timer : Timer = $WanderTimer;
onready var navi_agent: NavigationAgent = $NavigationAgent;
onready var observable_area : Area = $ObservableArea;
onready var point_to = $point_to;
onready var area_collsion_shape: = $ObservableArea/CollisionShape;
onready var tween : Tween = $Tween;
onready var slime_skin : = $Pivot/SlimeEnemy;


var is_active : bool = true setget set_is_active;
var jumping : bool = false;
var enemy_detected : bool = false;
var is_attacking : bool = false;
var is_dead : bool = false;

func _ready():
	player_reference = get_tree().get_nodes_in_group("Player")[0];
	pass;

func set_is_active(value:bool)->void:
	is_active = value;
	if not collider:
		return;
	collider.disable = not value;

func _on_ObservableArea_body_entered(body:Node):
	if body is Player:
		enemy_detected = true;
		emit_signal("enemy_detected",enemy_detected);

func _on_ObservableArea_body_exited(body:Node):
	if body is Player:
		enemy_detected = false;
		emit_signal("enemy_detected",enemy_detected);

func _on_EnemyHitArea_area_entered(area:Area):
	if area.owner is Player:
		is_dead = true;
		emit_signal("dead");
		_state_machine.transition_to("Move/Die",{from="from Enemy Script"});


func _on_AttackArea_body_entered(body:Node):
	if body is Player and not is_dead:
		is_attacking = true;
		print("attacking");
		emit_signal("attack_enemy");



func _on_AttackArea_body_exited(body:Node):
	if body is Player:
		is_attacking = false;
