class_name AnimalMenuManager
extends Control

@onready var animalGamerTag: RichTextLabel = %AnimalGamerTag
@onready var animalHealth: RichTextLabel = %AnimalHealth
@onready var animalAction: RichTextLabel = %AnimalAction

const lavaDeerMenu := preload("res://Prefabs/AnimalMenus/LavaDeer/LavaDeerMenu.tscn")
const hellHoundMenu := preload("res://Prefabs/AnimalMenus/Hellhound/HellhoundMenu.tscn")
const hunterMenu := preload("res://Prefabs/AnimalMenus/Hunter/HunterMenu.tscn")

@onready var _animalMenuTween: Tween = create_tween()

const MODULATE_VISIBLE: float = 1
const MODULATE_INVISIBLE: float = 0

enum MenuDirection {
	LEFT,
	RIGHT
}

var world: World
var _log: Log

func _enter_tree() -> void:
	_log = Log.new(get_script())
	world = Game.world

func _ready() -> void:
	world.onAnimalAdded.connect(_on_animal_created)

func _on_animal_created(animal: Animal):
	animal.clickDetection.onMouseLeftClicked.connect(_on_specific_animal_clicked.bind(animal))

func _on_specific_animal_clicked(animal: Animal) -> void:
	print("YESS")
	await _deleteExistingAnimalMenuAsync()
	print("NOO")
	createAnimalMenu(animal)
	
func _deleteExistingAnimalMenuAsync() -> void:
	if (get_child_count() == 0):
		return

	var existingMenu: AnimalMenu = get_child(0)
	await _removeSomeMenuAsync(existingMenu, MenuDirection.LEFT)

func _removeSomeMenuAsync(menu: Control, goAwayDirection: MenuDirection) -> void:
	const GO_AWAY_TIME: float = 0.5

	refreshTween()

	var toSomeSide: float = menu.size.x # Right by default.
	if (goAwayDirection == MenuDirection.LEFT):
		toSomeSide = -toSomeSide

	_animalMenuTween.tween_property(menu, "modulate:a", MODULATE_INVISIBLE, GO_AWAY_TIME)
	_animalMenuTween.tween_property(menu, "position:x", toSomeSide, GO_AWAY_TIME)

	_animalMenuTween.finished.connect(func():
		if is_instance_valid(menu):
			menu.queue_free()
	)

	await _animalMenuTween.finished


func _showSomeMenu(menu: Control, comeBackDirection: MenuDirection) -> void:
	const COME_BACK_TIME: float = 1.5
	const ORIGINAL_POSITION: float = 0

	refreshTween()

	var fromSomeSide: float = menu.size.x # Right by default.
	if (comeBackDirection == MenuDirection.LEFT):
		fromSomeSide = -fromSomeSide
	
	# start from not visible
	menu.modulate.a = MODULATE_INVISIBLE 
	menu.position.x = fromSomeSide

	_animalMenuTween.tween_property(menu, "modulate:a", MODULATE_VISIBLE, COME_BACK_TIME)
	_animalMenuTween.tween_property(menu, "position:x", ORIGINAL_POSITION, COME_BACK_TIME)

func createAnimalMenu(animal: Animal):
	var menu: AnimalMenu = getAnimalMenuScene(animal.type).instantiate()
	menu.configure(animal)
	add_child(menu)
	_showSomeMenu(menu, MenuDirection.LEFT)

func getAnimalMenuScene(type: Animal.Type) -> PackedScene:
	match type:
		Animal.Type.LAVA_DEER:
			return lavaDeerMenu
		Animal.Type.HELL_HOUND:
			return hellHoundMenu
		Animal.Type.HUNTER:
			return hunterMenu
		_:
			return null

func _input(event): #clears menus
	if Input.is_action_just_pressed("clearUI"):
		_deleteExistingAnimalMenuAsync()
	
func refreshTween() -> void:
	if (_animalMenuTween != null):
		_animalMenuTween.stop();
		_animalMenuTween.kill();
	_animalMenuTween = create_tween().set_ease(Tween.EaseType.EASE_OUT).set_trans(Tween.TransitionType.TRANS_EXPO).set_parallel();
