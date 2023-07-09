extends Node3D
var goofyVar: float = 0.0
@onready var floatingIsland = $"."
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	goofyVar += 0.02
	floatingIsland.position.y = 3 * sin(goofyVar) + 140
	
