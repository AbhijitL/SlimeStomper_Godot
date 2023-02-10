extends Spatial

var level : int;

onready var enemies = $Enemies;

var no_of_enemy : int = 0;
var point : int = 0;
var time : float = 0;

func _ready():
	no_of_enemy = enemies.get_child_count();
	Events.connect("enemy_kill_change",self,"_On_Enemy_kill_change");
	Events.connect("timer_finished",self,"_On_timer_finished");
	get_level_name();
	
func _On_timer_finished(value:float)->void:
	var best_time : float =  GameManager.get_best_time(level);
	if best_time < value:
		time = best_time;
	else:
		time = value;

func get_level_name()->void:
	var level_name = self.name;
	level = int(level_name.right(level_name.length()-1));
	print("current level is", str(level));

func _On_Enemy_kill_change(value,previous_value)->void:
	print("enemy value chaned"+str(1));
	print("No of enemy is", str(no_of_enemy));
	point += value;
	if point == no_of_enemy:
		Events.emit_signal("level_completed");
		GameManager.save_data(level, time, true);
