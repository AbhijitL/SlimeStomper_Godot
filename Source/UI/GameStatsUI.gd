extends CanvasLayer

onready var player_health_label : Label = $Control/MarginContainer/HBoxContainer/VBoxContainer2/VBoxContainer/HBoxContainer/HBoxContainer2/PlayerHealthLabel;
onready var point_label : Label = $Control/MarginContainer/HBoxContainer/VBoxContainer2/VBoxContainer/HBoxContainer/HBoxContainer3/PointLabel;
onready var time_label : Label = $Control/MarginContainer/HBoxContainer/VBoxContainer3/HBoxContainer/TimeLabel;

var time : float = 0.0;

var time_started : bool = false;
var point: int = 0;
var player_dead : bool = false;

func _input(event):
	if event.is_action_pressed("menu_open") and not player_dead:
		visible = not visible;

func _ready():
	Events.connect("player_health_change",self,"_On_player_health_change");
	Events.connect("enemy_kill_change",self,"_On_enemy_kill_change");
	Events.connect("level_completed",self,"_On_level_completed");
	Events.connect("start_timer",self,"_On_start_timer");
	Events.connect("player_dead",self,"_On_Player_dead");

	if not time_started:
		set_process(false);

func _On_Player_dead()->void:
	player_dead = true;
	# visible = false;

func _On_player_health_change(health,previous_health)->void:
	player_health_label.text = str(health) + " hp";

func _On_enemy_kill_change(value,previous_value)->void:
	point += value;
	point_label.text = str(point)+" $";
		
func _On_start_timer()->void:
	if not time_started:
		time_started = true;
		set_process(true);

func _On_level_completed()->void:
	set_time_to_stop();

func set_time_to_stop()->void:
	time_started = false;
	Events.emit_signal("timer_finished",time);
	set_process(false);

func _process(delta):
	if time_started:
		time += delta;
		time = round_to_dec(time,2);
		time_label.text = "Time: " + str(time)+"s";

func round_to_dec(num, digit):
    return round(num * pow(10.0, digit)) / pow(10.0, digit)


func _exit_tree():
	Events.disconnect("player_health_change",self,"_On_player_health_change");
	Events.disconnect("enemy_kill_change",self,"_On_enemy_kill_change");
	Events.disconnect("level_completed",self,"_On_level_completed");
	Events.disconnect("start_timer",self,"_On_start_timer");