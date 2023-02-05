extends State

var go_to_radius : float;

var go_to_pos : Vector3;

func _ready():
	owner.connect("enemy_detected",self,"_On_Enemy_detected");
	owner.connect("attack_enemy",self,"_On_attack_enemy");
	

func physics_process(delta:float) -> void:

	if owner.enemy_detected:
		owner.navi_agent.set_target_location(owner.player_reference.global_transform.origin);
	else:
		owner.navi_agent.set_target_location(go_to_pos);

	var move := get_parent();
	if not owner.is_on_floor():
		_state_machine.transition_to("Move/Air",{from ="from Wander State"});
	move.physics_process(delta);
	
	
func enter(msg: Dictionary={})->void:
	get_parent().enter(msg);
	owner.wander_timer.connect("timeout", self,"_On_Wander_timer_timeout");
	owner.wander_timer.start();
	init();
	owner.slime_skin.play("run");
	owner.slime_skin.connect("animation_finished",self,"_On_Slime_Skin_animation_finished");

func init()->void:
	go_to_radius = owner.area_collsion_shape.shape.radius;
	var pos : Vector3 = get_random_pos_on_xz_circle(owner.global_transform.origin,go_to_radius);
	print(pos);
	owner.point_to.global_transform.origin = pos;
	go_to_pos = pos;

	# owner.is_attacking = false;
	# owner.idle_timer.start();
	owner.wander_timer.start();
	owner.area_collsion_shape.set_disabled(false) ;

func get_random_pos_on_xz_circle(center: Vector3,radius:float = 4)->Vector3:
	var angle : float = rand_range(0,2*PI);
	var pos : Vector3 = center + Vector3(cos(angle),0,sin(angle)) * radius;
	return pos;

func _On_Wander_timer_timeout()->void:
	print("Wander timeout");
	_state_machine.transition_to("Move/Idle",{from ="from Wander State"});

func exit() -> void:
	owner.wander_timer.disconnect("timeout", self,"_On_Wander_timer_timeout");
	owner.slime_skin.stop();
	owner.slime_skin.disconnect("animation_finished",self,"_On_Slime_Skin_animation_finished");
	get_parent().exit();


func _On_Enemy_detected(enemy_detected:bool)->void:
	if enemy_detected:
		# owner.navi_agent.set_target_location(get_tree().get_nodes_in_group("Player")[0].global_transform.origin);
		owner.wander_timer.stop();
	elif not enemy_detected and not owner.is_attacking and not owner.is_dead:
		owner.navi_agent.set_target_location(go_to_pos);
		owner.wander_timer.start();

		

func _on_NavigationAgent_navigation_finished():
	if not owner.enemy_detected:
		var pos : Vector3 = get_random_pos_on_xz_circle(owner.global_transform.origin,go_to_radius);
		owner.point_to.global_transform.origin = pos;
		go_to_pos = pos;
	
	# if owner.enemy_detected:
	# 	owner.is_attacking = true;
	# 	# owner.idle_timer.stop();
		


func _On_attack_enemy()->void:
	if owner.is_attacking:
		owner.wander_timer.stop();
		owner.area_collsion_shape.set_disabled(true) ;
		_state_machine.transition_to("Move/Attack");

func _On_Slime_Skin_animation_finished(anim_name: String)->void:
	owner.slime_skin.play(anim_name);