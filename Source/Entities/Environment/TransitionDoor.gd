extends Spatial

export var change_to_scene : String = "";

func _on_Area_body_entered(body)->void:
    if body is Player:
        Events.emit_signal("transition_to",change_to_scene);