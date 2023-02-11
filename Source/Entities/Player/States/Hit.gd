extends State


export var hit_anim_speed :float = 0.1;
export var dead_audio : AudioStream;

func enter(msg: Dictionary = {}) -> void:
	_tween_to_random_loc();
	owner.slime_skin.play("squash");
	Events.emit_signal("camera_shake",0.5);

	owner.prev_player_health = owner.player_health;
	owner.player_health = owner.player_health - 1;
	if owner.player_health <= 0:
		owner.player_health == 0;
		owner.is_active = false;
		owner.player_dead = true;
		owner.audio_player.stream = dead_audio;
		owner.audio_player.play();
		Events.emit_signal("player_dead");
		Events.emit_signal("level_completed");
	Events.emit_signal("player_health_change", owner.player_health, owner.prev_player_health);



func exit() -> void:
	owner.slime_skin.stop();
	pass;

func _get_random_pos_on_xz_circle(center: Vector3,radius:float = 3)->Vector3:
	var angle : float = rand_range(0,2*PI);
	var pos : Vector3 = center + Vector3(cos(angle),0,sin(angle)) * radius;
	return pos;

func _tween_to_random_loc()->void:
	var current_pos: Vector3 = owner.global_transform.origin;
	var to_pos : Vector3 = _get_random_pos_on_xz_circle(current_pos,owner.move_radius);

	owner.tween.interpolate_property(owner,"translation:x",current_pos.x,to_pos.x,hit_anim_speed,Tween.TRANS_LINEAR,Tween.EASE_IN);
	owner.tween.interpolate_property(owner,"translation:z",current_pos.z,to_pos.z,hit_anim_speed,Tween.TRANS_LINEAR,Tween.EASE_IN);
	owner.tween.start();




func _on_Tween_tween_all_completed():
	_state_machine.transition_to("Move/Idle");
