extends CanvasLayer

onready var player_health_label : Label = $Control/MarginContainer/HBoxContainer/VBoxContainer2/VBoxContainer/HBoxContainer/HBoxContainer2/PlayerHealthLabel;
onready var point_label : Label = $Control/MarginContainer/HBoxContainer/VBoxContainer2/VBoxContainer/HBoxContainer/HBoxContainer3/PointLabel;
onready var time_label : Label = $Control/MarginContainer/HBoxContainer/VBoxContainer3/HBoxContainer/TimeLabel;

var time : float = 0.0;

var time_started : bool = false;

func _input(event):
	if event.is_action_pressed("menu_open"):
		visible = not visible;

func _ready():
	Events.connect("player_health_change",self,"_On_player_health_change");
	Events.connect("enemy_kill_change",self,"_On_enemy_kill_change");
	Events.connect("level_completed",self,"_On_level_completed");

func _On_player_health_change(health,previous_health)->void:
	player_health_label.text = str(health) + " hp";

func _On_enemy_kill_change(point,previous_point)->void:
	point_label.text = str(point)+" $";
	if point == 1:
		time_started = true;

func _On_level_completed()->void:
	set_time_to_stop();

func set_time_to_stop()->void:
	time_started = false;

func _process(delta):
	if time_started:
		time += delta;
		time = round_to_dec(time,2);
		time_label.text = "Time: " + str(time)+"s";

func round_to_dec(num, digit):
    return round(num * pow(10.0, digit)) / pow(10.0, digit)