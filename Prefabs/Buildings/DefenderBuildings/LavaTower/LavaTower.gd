extends DefenderBuilding
func GetPacked() -> PackedScene:
	if bullet == null:
		bullet = load("res://Scenes/FireBullet.tscn")
	return bullet
	
func ready() -> void:
	super()
	GetPacked()