extends CanvasLayer

export var main_menu_scene_path : String;

# buttons
onready var continue_button : = $Control/PauseMenu/CenterContainer/VBoxContainer/ContinueButton;
onready var restart_button : = $Control/PauseMenu/CenterContainer/VBoxContainer/RestartButton;
onready var menu_button : = $Control/PauseMenu/CenterContainer/VBoxContainer/LevelSelectorButton;
onready var exit_button : = $Control/PauseMenu/CenterContainer/VBoxContainer/ExitButton;

onready var pause_button := $Control/PauseMenu;



func _input(event:InputEvent)->void:
	if event.is_action_pressed("menu_open"):
		pause_button.visible = not pause_button.visible;

func _on_ContinueButton_pressed()->void:
	pause_button.visible = not pause_button.visible;

func _on_RestartButton_pressed()->void:
	pause_button.visible = not pause_button.visible;
	Events.emit_signal("transition_to",get_tree().current_scene.filename);

func _on_LevelSelectorButton_pressed()->void:
	pause_button.visible = not pause_button.visible;
	Events.emit_signal("transition_to",main_menu_scene_path);

func _on_ExitButton_pressed()->void:
	pause_button.visible = not pause_button.visible;
	get_tree().quit();
