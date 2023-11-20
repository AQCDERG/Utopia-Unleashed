extends RichTextLabel

func _ready() -> void:
	var world: World = Game.world
	world.science.onCurrencyChanged.connect(func(newScience: int):
		text = str(newScience)
	)
	print("New Mana/Science resource")
