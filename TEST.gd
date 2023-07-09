extends MeshInstance3D
var raidus: float = 1
var x: float = self.position.x
var z: float = self.position.z
var y: float = self.position.y
var increase: float = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	increase += PI/24
	x += sin(increase)
	z += cos(increase)
	self.position = Vector3(x * 4,y,z)

