extends DefenderBuilding

func GetPacked() -> PackedScene:
	if bullet == null:
		print("NOO")
		bullet = load("res://Scenes/bullet.tscn")
	return bullet

func _ready() -> void:
	super()
	GetPacked()
