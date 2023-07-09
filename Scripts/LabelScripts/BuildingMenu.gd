extends Sprite2D

var world: World

@export var buildingMenu: TextureRect
@export var logCabinMenu: TextureRect
@export var mineMenu: TextureRect
@export var headqaurterMenu: TextureRect
@export var evilCastleMenu: TextureRect
@export var manaDogMenu: TextureRect

func _enter_tree() -> void:
	world = Game.world
	
func _ready() -> void:
	world.onBuildingAdded.connect(_on_building_created)


func _on_headqauters_on_mouse_clicked() -> void:
	# self.visible = true
	# print("COCKROACH")
	pass

func _on_building_click(building: Building) -> void:
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

func _on_building_created(building: Building) -> void:
	building.clickDetection.onMouseLeftClicked.connect(_on_building_click.bind(building))

func _input(event):
	if Input.is_action_just_pressed("place2"):
		self.visible = false
		_hide_all_building_status_menus()
	elif Input.is_action_just_pressed("make"):
		buildingMenu.visible = true
	elif Input.is_action_just_pressed("escape"):
		self.visible = true

func _hide_all_building_status_menus() -> void:
	logCabinMenu.visible = false
	mineMenu.visible = false
	evilCastleMenu.visible = false
	headqaurterMenu.visible = false
	manaDogMenu.visible = false


