extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var world: World = Game.world
	world.soldiers.onCurrencyChanged.connect(func(newSoldier: int):
		text = str(newSoldier)
	)
