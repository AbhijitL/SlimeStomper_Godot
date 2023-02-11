extends State

export var dead_sound : AudioStream;

func enter(msg:Dictionary={})->void:
	owner.audio_player.stream = dead_sound;
	
	_dead_procedure();
	owner.slime_skin.play("squash");
	Events.emit_signal("camera_shake",0.7);

func _dead_procedure()->void:
	owner.idle_timer.stop();
	owner.wander_timer.stop();
	owner.area_collsion_shape.set_disabled(true) ;

	var prev_health = owner.enemy_health;
	var health = 1;
	print("ENemy dead emit"+ str(health));
	Events.emit_signal("enemy_kill_change", health, prev_health);
	owner.audio_player.play();
	


func _on_EnemyAudio3D_finished():
	print("finised");
	if owner.audio_player.stream == dead_sound:
		owner.queue_free();
