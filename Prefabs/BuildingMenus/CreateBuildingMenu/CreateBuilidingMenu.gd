class_name CreateBuildingMenu 
extends Control

# This script should be on a scene with these buttons on it.
# And it should be in the world scene.

@onready var _createHeadqaurterButton: Button = %Headquarter
@onready var _createHunterCabinButton: Button = %HunterCabin
@onready var _createHonorGeneratorButton: Button = %Mine
@onready var _createEvilCastleButton: Button = %EvilCastleButton
@onready var _createManaDogButton: Button = %ManaDogButton
@onready var _createWatchTowerButton: Button = %WatchTowerButton

signal on_building_creation_requested(type: Building.Type)

func _ready() -> void:
  visible = false # should be initially hidden.

  _createHeadqaurterButton.pressed.connect(_request_building_creation.bind(Building.Type.HEADQUARTER))
  _createHunterCabinButton.pressed.connect(_request_building_creation.bind(Building.Type.LOG_CABIN))
  _createHonorGeneratorButton.pressed.connect(_request_building_creation.bind(Building.Type.HONOR_GENERATOR))
  _createEvilCastleButton.pressed.connect(_request_building_creation.bind(Building.Type.EVIL_CASTLE))
  _createManaDogButton.pressed.connect(_request_building_creation.bind(Building.Type.MANA_DOG)) 
  _createWatchTowerButton.pressed.connect(_request_building_creation.bind(Building.Type.WATCH_TOWER)) 

  # # 2
  # var _request_building_creation_of_headquarter: Callable = _request_building_creation.bind(Building.Type.HEADQUARTER)
  # _createHeadqaurterButton.pressed.connect(_request_building_creation_of_headquarter)

  # 3
  # _createHeadqaurterButton.pressed.connect(func(): # <--- This is called a "lambda" function, but technically its a callable. 
  #   _request_building_creation(Building.Type.HEADQUARTER)
  # )

func _request_building_creation(type: Building.Type) -> void:
  on_building_creation_requested.emit(type)

func _input(_event):
  if Input.is_action_just_pressed("make"): # idealy change to "open_construction_menu"
    _toggle_visibility()

func _toggle_visibility() -> void:
  visible = not visible
