extends CanvasLayer




func _on_SourceButton_pressed()->void:
	if OS.get_name() == "HTML5":
		JavaScript.eval("window.location.href='https://github.com/AbhijitL/SlimeStomper_Godot' ");
	else:
		OS.shell_open("https://github.com/AbhijitL/SlimeStomper_Godot");


func _on_QuitButton_pressed():
	get_tree().quit();
