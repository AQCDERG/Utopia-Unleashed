extends RichTextLabel

func _ready() -> void:
	var world: World = Game.world
	world.harmony.onCurrencyChanged.connect(func(newHarmony: int):
		text = str(newHarmony)
	)
