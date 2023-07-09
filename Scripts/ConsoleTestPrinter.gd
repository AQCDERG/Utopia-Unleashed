extends Node3D
var x: int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	match x:
		1: 
			print("HI JOE")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass