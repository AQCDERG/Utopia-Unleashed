extends RichTextLabel

func _ready() -> void:
	var world: World = Game.world
	world.passion.onCurrencyChanged.connect(func(newPassion: int):
		text = str(newPassion)
	)
