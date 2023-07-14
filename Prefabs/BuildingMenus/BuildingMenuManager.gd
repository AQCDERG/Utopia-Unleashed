extends Node

const manaGeneratorMenu := preload("res://Prefabs/BuildingMenus/ManaGenerator/ManaGeneratorMenu.tscn")
const honorGeneratorMenu := preload("res://Prefabs/BuildingMenus/HonorGenerator/HonorGeneratorMenu.tscn")
const headqaurterMenu := preload("res://Prefabs/BuildingMenus/Headquarter/HeadquarterMenu.tscn")
const evilCastleMenu := preload("res://Prefabs/BuildingMenus/EvilCastle/EvilCastleMenu.tscn")
const logCabinMenu := preload("res://Prefabs/BuildingMenus/LogCabin/LogCabinMenu.tscn")
var visibleNode: Node

var world: World
var _log: Log

func _enter_tree() -> void:
	_log = Log.new(get_script())
	world = Game.world
	
func _ready() -> void:
	world.onBuildingAdded.connect(_on_building_created)
	
func _on_building_created(building: Building) -> void:
	building.clickDetection.onMouseLeftClicked.connect(_on_specific_building_clicked.bind(building))

func _on_specific_building_clicked(building: Building) -> void:
	_hide_all_building_status_menus()
	_show_status_menu_for_building(building)

func _hide_all_building_status_menus() -> void:
	pass

func _show_status_menu_for_building(building: Building) -> void:
	if(building.buildingType == Building.Type.HEADQUARTER):
		var menu = headqaurterMenu.instantiate()
		add_child(menu)
		
		print("IT IS HERE")
	elif(building.buildingType == Building.Type.HONOR_GENERATOR):
		var menu = honorGeneratorMenu.instantiate()
		add_child(menu)
	elif(building.buildingType == Building.Type.LOG_CABIN):
		var menu = logCabinMenu.instantiate()
		add_child(menu)
	elif(building.buildingType == Building.Type.MANA_DOG):
		var menu = manaGeneratorMenu.instantiate()
		add_child(menu)
	elif(building.buildingType == Building.Type.EVIL_CASTLE):
		var menu = evilCastleMenu.instantiate()
		add_child(menu)
	else:
		print("BRO")


func _input(event): #clears menus
	if Input.is_action_just_pressed("clearUI"):
		if(get_child(0) == null):
			return
		get_child(0).queue_free()
