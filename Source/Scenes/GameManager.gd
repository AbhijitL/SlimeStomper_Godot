extends Spatial


export var player_health : int = 1;

func _ready():
    Events.emit_signal("player_health_change",player_health,player_health);