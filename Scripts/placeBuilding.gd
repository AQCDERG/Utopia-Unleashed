extends RayCast3D

var world: World
var outLineInstance: Node3D

@export var wall_sprite: PackedScene
@export var buildingsprite: TextureRect
@export var headqaurterButton: Button
@export var hunterCabinButton: Button
@export var mineButton: Button
@export var evilCastleButton: Button
@export var manaDogButton: Button

func _enter_tree() -> void:
	world = Game.world
	outLineInstance = wall_sprite.instantiate()
	outLineInstance.visible = false
	add_child(outLineInstance)
	
func _input(event):
	if (not Input.is_action_just_pressed("make")):
		return

	if outLineInstance.visible == true:
		_hideBuildingMode()
	else:
		outLineInstance.visible = true

func _hideBuildingMode() -> void:
	outLineInstance.visible = false
	buildingsprite.visible = false

func _on_hunter_cabin_pressed() -> void:
	if outLineInstance.visible == true:
		_make_building(Building.Type.LOG_CABIN)

func _on_mine_pressed() -> void:
	if outLineInstance.visible == true:
		_make_building(Building.Type.HONOR_GENERATOR)
		
func _on_headquarter_pressed() -> void:
	if outLineInstance.visible == true:
		_make_building(Building.Type.HEADQUARTER)

func _on_evil_castle_button_pressed() -> void:
	if outLineInstance.visible == true:
		_make_building(Building.Type.EVIL_CASTLE)

func _on_mana_dog_button_pressed() -> void:
	if outLineInstance.visible == true:
		_make_building(Building.Type.MANA_DOG)

func _make_building(building_type: Building.Type) -> void:
	if outLineInstance.visible == true:
		world.createBuilding(building_type, get_collision_point())