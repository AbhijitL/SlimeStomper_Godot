extends CanvasLayer

onready var player_health_label : Label = $Control/MarginContainer/HBoxContainer/VBoxContainer2/VBoxContainer/HBoxContainer/HBoxContainer2/PlayerHealthLabel;
onready var point_label : Label = $Control/MarginContainer/HBoxContainer/VBoxContainer2/VBoxContainer/HBoxContainer/HBoxContainer3/PointLabel;

func _input(event):
	if event.is_action_pressed("menu_open"):
		visible = not visible;

func _ready():
	Events.connect("player_health_change",self,"_On_player_health_change");
	Events.connect("enemy_kill_change",self,"_On_enemy_kill_change");

func _On_player_health_change(health,previous_health)->void:
	player_health_label.text = str(health) + " hp";

func _On_enemy_kill_change(point,previous_point)->void:
	point_label.text = str(point)+" $";
