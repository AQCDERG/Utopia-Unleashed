extends Control

@onready var playButton: Button = %Play
@onready var creditButton: Button = %Credit

func _ready() -> void:
  playButton.pressed.connect(startGame)

func startGame() -> void: 
  get_tree().change_scene("res://oldMain.tscn")
  print("DDD")
