extends Spatial


onready var enemies = $Enemies;

var no_of_enemy : int = 0;

var point : int = 0;

func _ready():
	no_of_enemy = enemies.get_child_count();
	Events.connect("enemy_kill_change",self,"_On_Enemy_kill_change");


func _On_Enemy_kill_change(value,previous_value)->void:
	print("enemy value chaned"+str(1));
	print("No of enemy is", str(no_of_enemy));
	point += value;
	if point == no_of_enemy:
		Events.emit_signal("level_completed");
