class_name World
extends Node

signal onBuildingAdded(building: Building)
signal doCameraShake(amount: float)

@export var passiveIncomeIntervalSeconds: float = 5.0
@export var scienceLabel: RichTextLabel
@export var soldierLabel: RichTextLabel
@export var waterColor: MeshInstance3D
@export var music1: AudioStreamPlayer
@export var music2: AudioStreamPlayer

@onready var animalFactory: AnimalFactory = %AnimalFactory
@onready var buildingFactory: BuildingFactory = %BuildingFactory

@onready var cashLabel: RichTextLabel = %CashLabel
@onready var poorSound: AudioStreamPlayer = %Poor

var _log: Log

var honor: CurrencyManager = CurrencyManager.new()
var science: CurrencyManager = CurrencyManager.new()
var soldiers: CurrencyManager = CurrencyManager.new()
var mana: CurrencyManager = CurrencyManager.new()
var life: CurrencyManager = CurrencyManager.new()
var passion: CurrencyManager = CurrencyManager.new()
var death: CurrencyManager = CurrencyManager.new()
var harmony: CurrencyManager = CurrencyManager.new()

#COMMAND CONSOLE IS CONTROL SHIFT P SKINSO

func _enter_tree():
	_log = Log.new(get_script())
	Game.SetWorld(self)

func _ready() -> void:# Give money IMMEDIATELY.
	_passiveIncome()
	_playRandomMusic()
	_createAndConfigureIncomeTimer()
	_updateCurrencyMaterialsOnChanged()


func _playRandomMusic() -> void:
	if bool(randi_range(0, 1)):
		music1.playing = true
	else:
		music2.playing = true

func _updateCurrencyMaterialsOnChanged() -> void:
	honor.onCurrencyChanged.connect(func(amount: int) -> void:
		cashLabel.material.set_shader_parameter("cash_value", amount)
		waterColor.mesh.material.set_shader_parameter("r_vertical", amount)
	)

	science.onCurrencyChanged.connect(func(amount: int) -> void:
		scienceLabel.material.set_shader_parameter("science_value", amount)
	)

	soldiers.onCurrencyChanged.connect(func(amount: int) -> void:
		soldierLabel.material.set_shader_parameter("soldier_value", amount)
	)

func _createAndConfigureIncomeTimer() -> void:
	var timer: Timer = Timer.new()
	timer.wait_time = 5
	timer.one_shot = false
	timer.timeout.connect(_passiveIncome)
	add_child(timer)
	timer.start()


func _passiveIncome() -> void:
	honor.add(250)
	science.add(1)
	soldiers.add(5)
	mana.add(2)
	passion.add(3)
	death.add(4)
	life.add(6)
	harmony.add(7)
	_log.info("Passive income added.")
	# Clean up late.er
	var deer = animalFactory.createAnimal(Animal.Type.LAVA_DEER)
	add_child(deer)
	deer.global_position = Vector3(0, 90, 0)


func createBuilding(type: Building.Type, position: Vector3) -> Building:
	#if !(buildingFactory.canCreateBuilding(type)): # TODO: Implement poor logic.
	#	poorSound.playing = true
	#	return

	var building: Building = buildingFactory.createBuilding(type)
	building.position = position
	add_child(building)

	# todo: Remove monies.

	doCameraShake.emit(0.3)
	onBuildingAdded.emit(building)
	return building
