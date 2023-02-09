extends Node

var data : Dictionary = {};


func save_data(level : int, best_time : float, completed: bool)->void:
    var new_data : Dictionary = {level:[best_time,completed]};
    data.merge(new_data,true);
    print(data);

func load_data() -> Dictionary:
    return {};

func get_best_time(level:int)-> float:
    if not data.has(level):
        return 0.0;
    return data.get(level)[0];

func get_is_level_completed(level) -> bool:
    if not data.has(level):
        return false;
    return data.get(level)[1];