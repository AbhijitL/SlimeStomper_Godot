extends CanvasLayer

signal finish;

var scene : String;
var is_wipe := false;
export var is_reverse = false;

var frame = 0;
# last frame
export var last = 14;

onready var easing = Easing.new(0.45);
onready var audio : AudioStreamPlayer2D = $Control/AudioStreamPlayer2D;
onready var image := $Control/ColorRect;
onready var mat : ShaderMaterial = $Control/ColorRect.material;

func _ready():
	image.visible = false;
	easing.clock = easing.time;  Events.connect("transition_to",self,"_On_Transition_to");

func _On_Transition_to(scene)->void:
	change_scene(scene);

func change_scene(new_scene):
	scene = new_scene;
	start();
	# Events.emit_signal("camera_shake",2);
	
func _new_scene():
	if get_tree().current_scene.filename == scene:
		get_tree().reload_current_scene();
	else:
		get_tree().change_scene(scene);

func _physics_process(delta)->void:
	if is_wipe:
		easing.count(delta);
		var f = lerp(0.0, last, easing.frac());
		mat.set_shader_param("frame", (last - f) if is_reverse else f);
		
		if easing.is_complete:
			stop();

func start(_reverse = false)->void:
	is_wipe = true;
	easing.reset();
	image.visible = true;
	
	is_reverse = _reverse;
	if !is_reverse:
		audio.play();

func stop()->void:
	is_wipe = false;
	if is_reverse:
		image.visible = false;
	else:
		for i in 2:
			yield(get_tree(),"idle_frame");
		emit_signal("finish"); _new_scene();
		start(true);
