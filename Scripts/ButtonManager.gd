extends Control

@onready var playButton: Button = %Play
#@onready var creditButton: Button = %Credit
@onready var uiBackground: TextureRect = %UiBackground
var allUi = ["res://SpriteImages/HellHoundImage.jpg", "res://SpriteImages/LavaDeerImage.jpg"]


func _ready() -> void:
  changeBackground()
  playButton.pressed.connect(startGame)

func startGame() -> void: 
  #SwtichScene.load_scene("res://FixedScene/MainMenu.tscn", "res://oldMain.tscn")
  get_tree().change_scene_to_file("res://Scenes/LoadingScreen.tscn")

func changeBackground() -> void:
  uiBackground.texture = load(allUi[randi_range(0, allUi.size() - 1)])
  
