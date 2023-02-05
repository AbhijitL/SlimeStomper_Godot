extends State


func enter(msg:Dictionary={})->void:
	_dead_procedure();
	owner.slime_skin.play("squash");
	Events.emit_signal("camera_shake",0.7);

func _dead_procedure()->void:
	owner.idle_timer.stop();
	owner.wander_timer.stop();
	owner.area_collsion_shape.set_disabled(true) ;

	var timer = Timer.new();
	timer.connect("timeout",self,"_On_timer_timeout");
	owner.add_child(timer);
	timer.start(1);

	var health = owner.enemy_health - 1 if owner.enemy_health > 1 else owner.enemy_health;
	Events.emit_signal("enemy_kill_change", health, health);

func _On_timer_timeout()->void:
	owner.queue_free();
