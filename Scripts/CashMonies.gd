extends RichTextLabel


func _ready() -> void:
	var world: World = Game.world
	world.honor.onCurrencyChanged.connect(func(newCash: int):
		text = str(newCash)
	)
	print("Testing System")
