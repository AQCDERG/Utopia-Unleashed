extends RichTextLabel

func _ready() -> void:
	var world: World = Game.world
	world.mana.onCurrencyChanged.connect(func(newMana: int):
		text = str(newMana)
	)
