extends State

func unhandled_input(event)->void:
	var move:= get_parent();
	move.unhandled_input(event);


func physics_process(delta:float):
	var move:= get_parent(); move.physics_process(delta);

	if owner.is_on_floor() and move.get_input_vector().length() == 0.0:
		move.velocity = Vector3.ZERO;

	if owner.is_on_floor() and move.velocity.length() >= 0.01:
		_state_machine.transition_to("Move/Run");
	elif not owner.is_on_floor():
		print("on air")
		_state_machine.transition_to("Move/Air");

func enter(msg:Dictionary={})->void:
		var move: = get_parent();
		move.enter(msg);
		move.max_speed = move.max_speed_default;
		move.velocity = Vector3.ZERO;
		owner.slime_skin.play("IdleAnim");
		owner.slime_skin.connect("animation_finished",self,"_On_Slime_Skin_animation_finished");

func exit()->void:
	owner.slime_skin.stop();
	owner.slime_skin.disconnect("animation_finished",self,"_On_Slime_Skin_animation_finished");
	get_parent().exit();

func _On_Slime_Skin_animation_finished(anim_name: String)->void:
	owner.slime_skin.play(anim_name);
