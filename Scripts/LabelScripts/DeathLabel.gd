extends RichTextLabel

func _ready() -> void:
	var world: World = Game.world
	world.death.onCurrencyChanged.connect(func(newDeath: int):
		text = str(newDeath)
	)
