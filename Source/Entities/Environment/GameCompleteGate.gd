extends Spatial

export var color_safe : Color;

onready var collision : CollisionShape = $GateMesh/StaticBody/CollisionShape;
onready var mesh : MeshInstance = $GateMesh/Gate;


func _ready():
    Events.connect("level_completed",self,"_On_level_completed");

func _On_level_completed():
    collision.set_deferred("disabled", true);
    mesh.get_surface_material(1).set_shader_param("color",color_safe);