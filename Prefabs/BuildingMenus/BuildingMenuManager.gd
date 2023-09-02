class_name BuildingMenuManager
extends Control


const manaGeneratorMenu := preload("res://Prefabs/BuildingMenus/ManaGenerator/ManaGeneratorMenu.tscn")
const honorGeneratorMenu := preload("res://Prefabs/BuildingMenus/HonorGenerator/HonorGeneratorMenu.tscn")
const headqaurterMenu := preload("res://Prefabs/BuildingMenus/Headquarter/HeadquarterMenu.tscn")
const evilCastleMenu := preload("res://Prefabs/BuildingMenus/EvilCastle/EvilCastleMenu.tscn")
const logCabinMenu := preload("res://Prefabs/BuildingMenus/LogCabin/LogCabinMenu.tscn")
const lavaTowerMenu := preload("res://Prefabs/BuildingMenus/LavaTower/LavaTowerMenu.tscn")
const watchTowerMenu := preload("res://Prefabs/BuildingMenus/WatchTower/WatchTowerMenu.tscn")
const dwarfMenu := preload("res://Prefabs/BuildingMenus/DwarfHallMenu/DwarfHallMenu.tscn")
var buildingCreated: Building
var world: World
var _log: Log

func _enter_tree() -> void:
	_log = Log.new(get_script())
	world = Game.world
	
func _ready() -> void:
	world.onBuildingAdded.connect(_on_building_created)

func _on_building_created(building: Building) -> void:
	building.clickDetection.onMouseLeftClicked.connect(_on_specific_building_clicked.bind(building))
	buildingCreated = building

func _on_specific_building_clicked(building: Building) -> void:
	_remove_existing_menus()
	_show_status_menu_for_building(building)

func _remove_existing_menus() -> void:
	# Assuming they are children of this node
	for child in get_children():
		child.queue_free()

func _show_status_menu_for_building(building: Building) -> void:
	var menuScene: PackedScene = _get_menu_scene(building.buildingType)
	var menu := menuScene.instantiate()
	print(building.name)
	menu.building = building
	add_child(menu)

func _get_menu_scene(type: Building.Type) -> PackedScene:
	match type:
		Building.Type.HONOR_GENERATOR:
			return honorGeneratorMenu
		Building.Type.MANA_DOG:
			return manaGeneratorMenu
		Building.Type.HEADQUARTER:
			return headqaurterMenu
		Building.Type.EVIL_CASTLE:
			return evilCastleMenu
		Building.Type.LOG_CABIN:
			return logCabinMenu
		Building.Type.LAVA_TOWER:
			return lavaTowerMenu
		Building.Type.WATCH_TOWER:
			return watchTowerMenu
		Building.Type.DWARF_HALL:
			return dwarfMenu
		_:
			push_error("Invalid building type")
			return null
	#if(dwarfHall != null):
		#building.clickDetection.onMouseLeftClicked.connect(_on_specific_building_clicked.bind(building))
	#lavaTower.clickDetection.onMouseLeftClicked.connect(_on_specific_building_clicked.bind(lavaTower))


func _input(event): 
	if Input.is_action_just_pressed("clearUI"):
		_remove_existing_menus()


# For refrence
# func _some_function(type: String) -> PackedScene:
# 	match type:
# 		"honor_generator":
# 			return honorGeneratorMenu
# 		"manadog":
# 			return manaGeneratorMenu
# 		"headquarter":
# 			return headqaurterMenu
# 		"evil_castle":
# 			return evilCastleMenu
# 		"log_cabin":
# 			return logCabinMenu
# 		_:
# 			push_error("Invalid building type")
# 			return input

