extends State

func unhandled_input(event: InputEvent) -> void:
	get_parent().unhandled_input(event);

func physics_process(delta: float) -> void:
	var move = get_parent();
	if owner.is_on_floor():
		if move.velocity.length() < 1.0:
			_state_machine.transition_to("Move/Idle");
	else:
		_state_machine.transition_to("Move/Air");

	move.physics_process(delta);


func enter(msg: Dictionary = {}) -> void:
	get_parent().enter(msg);
	owner.slime_skin.play("run");
	owner.slime_skin.connect("animation_finished",self,"_On_Slime_Skin_animation_finished");


func exit() -> void:
	owner.slime_skin.stop();
	owner.slime_skin.disconnect("animation_finished",self,"_On_Slime_Skin_animation_finished");
	get_parent().exit();

func _On_Slime_Skin_animation_finished(anim_name: String)->void:
	owner.slime_skin.play(anim_name);