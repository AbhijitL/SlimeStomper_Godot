extends Spatial

export(Array, String) var level_paths; 

onready var ui = $UI;
onready var level_transition_doors = $Level/Transitions;
onready var level_locks = $Level/LevelLocks;

var data: Dictionary;

func _ready():
	data = GameManager.load_data();
	_set_scene_path_to_level_transition_door();
	_set_level_lock_unloced();


func _set_scene_path_to_level_transition_door()->void:
	var i : int = 0;
	for door in level_transition_doors.get_children():
		if len(level_paths) == i:
			return;
		door.change_to_scene = level_paths[i];
		door.time_label.text = "Time elapsed: " + str(data[i][0]) + "s";
		i += 1;

func _set_level_lock_unloced()->void:
	var i : int = 0;
	for lock in level_locks.get_children():
		if len(data) - 1 == i:
			return;
		
		if data[i][1] == true:
			lock.unlocked();

		i += 1;
