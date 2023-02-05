extends Spatial



var scene;

onready var butt = $Button;


func _ready():
    butt.grab_focus();
    scene = preload("res://Source/Scenes/test.tscn").instance();

func _on_Button_pressed():
    
    pass;

func _add_a_scene_manually():
    get_node("/root/Test").free()
    # This is like autoloading the scene, only
    # it happens after already loading the main scene.
    get_tree().get_root().add_child(scene);