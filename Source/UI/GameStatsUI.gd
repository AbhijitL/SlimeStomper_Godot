extends CanvasLayer


func _input(event):
    if event.is_action_pressed("menu_open"):
        visible = not visible;