extends State

export var jump_impulse : float = 5;
const ANIM_LENGTH = 0.6;

# func _ready():
# 	owner.connect("attack_enemy",self,"_On_attack_enemy");

func physics_process(delta):
	var move = get_parent();
	move.physics_process(delta);
	# print(owner.is_attacking);	
	if  owner.is_on_floor() and not owner.is_attacking:
		print("Transiiton to air");
		_state_machine.transition_to("Move/Air");
		pass;
	

func enter(msg:Dictionary={})->void:
	var move = get_parent();
	move.enter(msg);
	_attack(msg);
	move.mov_vec = Vector3.ZERO;



func _attack(msg):
	if owner.is_on_floor():
		# _jump(jump_impulse,distance_to_player);
		jump();

func exit() -> void:
	var move = get_parent();
	move.gravity = move.gravity_default;
	move.exit();

func jump():
	var current_pos = owner.global_transform.origin;
	var player_pos = owner.player_reference.global_transform.origin + Vector3(0,3,0);

	owner.tween.interpolate_property(owner,"translation:x",current_pos.x,player_pos.x,ANIM_LENGTH,Tween.TRANS_LINEAR,Tween.EASE_IN);
	owner.tween.interpolate_property(owner,"translation:z",current_pos.z,player_pos.z,ANIM_LENGTH,Tween.TRANS_LINEAR,Tween.EASE_IN);
	owner.tween.interpolate_property(owner,"translation:y",current_pos.y,player_pos.y+jump_impulse,ANIM_LENGTH/2,Tween.TRANS_QUAD,Tween.EASE_OUT);
	owner.tween.interpolate_property(owner,"translation:y",player_pos.y+jump_impulse,player_pos.y,ANIM_LENGTH/3,Tween.TRANS_QUAD,Tween.EASE_IN,ANIM_LENGTH/2);
	owner.tween.start();
	owner.slime_skin.play("Jump");


func _on_Tween_tween_all_completed():
	print("Tween completed");
	owner.is_attacking = false;
	owner.tween.stop(self);
	# owner.idle_timer.start();
	# owner.wander_timer.start();
	# owner.area_collsion_shape.set_disabled(false) ;
