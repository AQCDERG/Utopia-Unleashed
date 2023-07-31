extends RayCast3D # DEPRECATED

const createBuildingMenu: = preload("res://Prefabs/BuildingMenus/CreateBuildingMenu/CreateBuilidingMenu.tscn")
var honorGenerat
var exsists: bool = false
var world: World
var outLineInstance: Node3D

@export var wall_sprite: PackedScene
@export var buildingsprite: TextureRect
@onready var headqaurterButton: Button = %Headquarter
@onready var hunterCabinButton: Button = %HunterCabin
@onready var honorGeneratorButton: Button = %Mine
@onready var evilCastleButton: Button = %EvilCastleButton
@onready var manaDogButton: Button = %EvilCastleButtonEvilCastleButton
@onready var buildingManager: BuildingMenuManager = %BuildingMenuManager
@onready var buildingMenuScene

var buildinMenugExsists = false
var _log: Log

func _enter_tree() -> void:
	_log = Log.new(get_script())
	world = Game.world
	outLineInstance = wall_sprite.instantiate()
	outLineInstance.visible = false
	add_child(outLineInstance)
	

	
func _input(event):
	if outLineInstance.visible == true:
		exsists = true
		_hideBuildingMode()
	else:
		outLineInstance.visible = true

func _hideBuildingMode() -> void:
	outLineInstance.visible = false
	buildingsprite.visible = false

func _on_hunter_cabin_pressed() -> void:
	_make_building(Building.Type.LOG_CABIN)

func _on_mine_pressed() -> void:
	_make_building(Building.Type.HONOR_GENERATOR)
		
func _on_headquarter_pressed() -> void:
	_make_building(Building.Type.HEADQUARTER)

func _on_evil_castle_button_pressed() -> void:
	_make_building(Building.Type.EVIL_CASTLE)

func _on_mana_dog_button_pressed() -> void:
	_make_building(Building.Type.MANA_DOG)
	
func _make_building(building_type: Building.Type) -> void:
	if outLineInstance.visible == true:
		world.createBuilding(building_type, get_collision_point())


func _on_building_menu_manager_builiding_menu_exsists() -> void:
	exsists = true
