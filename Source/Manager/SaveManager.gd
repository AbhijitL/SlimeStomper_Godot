extends Node
class_name SaveManager


const FILE_NAME = "user://game_data.json";


func _ready():
	load_data();


func load_data()->Dictionary:
	var file : File = File.new();
	if not file.file_exists(FILE_NAME):
		print("File not exists");
		return {};
	print("File exists");
	file.open(FILE_NAME,File.READ);
	var file_data = {};
	file_data = file.get_as_text();
	file_data = parse_json(file_data);
	var data = str2var(file_data);
	file.close();
	print("Current save data is "+ str(data));
	return data;
	
	


func save_data(_data)->void:
	var file : File = File.new();
	file.open(FILE_NAME,file.WRITE);
	file.store_line(to_json(var2str(_data)));
	file.close();
	print(_data);
