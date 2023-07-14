extends Sprite2D

@export var buildingMenu: TextureRect
@export var logCabinMenu: TextureRect
@export var mineMenu: TextureRect
@export var headqaurterMenu: TextureRect
@export var evilCastleMenu: TextureRect
@export var manaDogMenu: TextureRect

var world: World
var _log: Log

func _enter_tree() -> void:
	_log = Log.new(get_script())
	world = Game.world
	
func _ready() -> void:
	world.onBuildingAdded.connect(_on_building_created)

func _input(event):
	if Input.is_action_just_pressed("place2"):
		visible = false
		_hide_all_building_status_menus()
	elif Input.is_action_just_pressed("make"):
		buildingMenu.visible = true
	elif Input.is_action_just_pressed("escape"):
		visible = true

func _on_building_created(building: Building) -> void:
	building.clickDetection.onMouseLeftClicked.connect(_on_specific_building_clicked.bind(building))

func _on_specific_building_clicked(building: Building) -> void:
	_hide_all_building_status_menus()
	_show_status_menu_for_building(building)

func _hide_all_building_status_menus() -> void:
	headqaurterMenu.visible = false
	mineMenu.visible = false
	logCabinMenu.visible = false
	manaDogMenu.visible = false
	evilCastleMenu.visible = false

func _show_status_menu_for_building(building: Building) -> void:
	if(building.buildingType == Building.Type.HEADQUARTER):
		headqaurterMenu.visible = true
	elif(building.buildingType == Building.Type.HONOR_GENERATOR):
		mineMenu.visible = true
	elif(building.buildingType == Building.Type.LOG_CABIN):
		logCabinMenu.visible = true
	elif(building.buildingType == Building.Type.MANA_DOG):
		manaDogMenu.visible = true
	elif(building.buildingType == Building.Type.EVIL_CASTLE):
		evilCastleMenu.visible = true