extends Spatial

signal animation_finished;

# export var material : Material;

onready var mesh : MeshInstance = $Slime;
onready var animation_player : AnimationPlayer = $AnimationPlayer;

func _ready() ->void:
	# if material:
	# 	mesh.set_surface_material(0,material);
	animation_player.connect("animation_finished",self,"_On_AnimationPlayer_animation_finished");


func _On_AnimationPlayer_animation_finished(anim_name: String) ->void:
	emit_signal("animation_finished",anim_name);
	
func play(anim_name: String)->void:
	assert (anim_name in animation_player.get_animation_list());
	animation_player.stop();
	animation_player.play(anim_name,0.2);


func stop()->void:
	animation_player.stop();
