extends RichTextLabel

func _ready() -> void:
	var world: World = Game.world
	world.mana.onCurrencyChanged.connect(func(newLife: int):
		text = str(newLife)
	)
