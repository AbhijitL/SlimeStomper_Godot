extends State

func _ready():
	owner.connect("enemy_detected",self,"_On_Enemy_detected");


func physics_process(delta:float):
	var move := get_parent();

	if owner.is_on_floor():
		move.mov_vec = Vector3.ZERO;
		owner.jumping = false;

	if not owner.is_on_floor():
		_state_machine.transition_to("Move/Air",{from ="from Idle State"});


func enter(msg:Dictionary={})->void:
	if "from" in msg:
		print(msg);
	var move: = get_parent();
	move.enter(msg);
	move.max_speed = move.max_speed_default;
	move.mov_vec = Vector3.ZERO;
	owner.idle_timer.connect("timeout",self,"_On_Idle_timer_timeout");
	if not owner.wander_timer.stop():
		owner.idle_timer.start();
		owner.area_collsion_shape.set_disabled(false);
	
	owner.slime_skin.play("IdleAnim");
	owner.slime_skin.connect("animation_finished",self,"_On_Slime_Skin_animation_finished");

func _On_Idle_timer_timeout()->void:
	print("IdleTimeout");
	_state_machine.transition_to("Move/Wander",{from ="from Idle State"});

func exit()->void:
	owner.slime_skin.stop();
	owner.slime_skin.disconnect("animation_finished",self,"_On_Slime_Skin_animation_finished");
	owner.idle_timer.disconnect("timeout",self,"_On_Idle_timer_timeout");
	get_parent().exit();

func _On_Enemy_detected(enemy_detected:bool)->void:
	if enemy_detected:
		owner.idle_timer.stop();
		_state_machine.transition_to("Move/Wander",{from ="from Idle State"});

func _On_Slime_Skin_animation_finished(anim_name: String)->void:
	owner.slime_skin.play(anim_name);
