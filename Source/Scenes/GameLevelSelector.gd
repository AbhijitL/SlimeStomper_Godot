extends Spatial

export(Array, String) var level_paths; 

onready var ui = $UI;
onready var level_transition_doors = $Level/Transitions;
onready var level_locks = $Level/LevelLocks;

func _ready():
	_set_scene_path_to_level_transition_door();
	_set_level_lock_unloced();


func _set_scene_path_to_level_transition_door()->void:
	var i : int = 0;
	for scene in level_transition_doors.get_children():
		if len(level_paths) == i:
			return;
		scene.change_to_scene = level_paths[i];
		i += 1;

func _set_level_lock_unloced()->void:
	var data: Dictionary = GameManager.load_data();
	var i : int = 0;
	for lock in level_locks.get_children():
		if len(data) - 1 == i:
			return;
		
		if data[i][1] == true:
			lock.unlocked();

		i += 1;
