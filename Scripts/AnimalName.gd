extends Label3D

@onready var nameGenator: GamertagGenerator = %NameGenerator

var username: String:
  get:
    return text

func _ready() -> void:
  text = nameGenator.generateGamerTag()
