class_name World
extends Node

signal onBuildingAdded(building: Building)
signal doCameraShake(amount: float) # not ideal, but it works.

@export var passiveIncomeIntervalSeconds: float = 5.0
@onready var scienceLabel: RichTextLabel = %ScienceLabel
@onready var soldierLabel: RichTextLabel = %SoldierLabel
@onready var waterColor: MeshInstance3D = %Water
@onready var music1: AudioStreamPlayer = %Music1
@onready var music2: AudioStreamPlayer = %Music2
@onready var music3: AudioStreamPlayer = %Music3
@onready var allMusic = [music1, music2, music3]

@onready var animalFactory: AnimalFactory = %AnimalFactory
@onready var buildingFactory: BuildingFactory = %BuildingFactory


@onready var cashLabel: RichTextLabel = %CashLabel
@onready var poorSound: AudioStreamPlayer = %Poor

@onready var cameraRay: RayCast3D = %CameraRay # Be sure to rename your ray to this, with the right script.
@onready var createBuildingMenu: CreateBuildingMenu = %CreateBuildingMenu # Same.

@onready var animalCreator: AnimalCreationManager = %AnimalCreationManager
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

func _ready() -> void:
	_playRandomMusic()
	_updateCurrencyMaterialsOnChanged()
	_createAndConfigureIncomeTimer()
	_passiveIncome() # Give money IMMEDIATELY.
	_spawnBuildingOnRequested()
	animalCreator.spawnDeerRandomly()
	animalCreator.spawnWolfRandomly()


func _playRandomMusic() -> void:
	allMusic[randi_range(0, allMusic.size() - 1)].playing = true

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
	#_log.info("Passive income added.")

func _spawnBuildingOnRequested() -> void:
	createBuildingMenu.on_building_creation_requested.connect(func(type: Building.Type) -> void:
		var creationPosition: Vector3 = cameraRay.get_collision_point()
		spawnBuilding(type, creationPosition)
	)


	
func spawnBuilding(type: Building.Type, position: Vector3) -> Building:
	#if !(buildingFactory.canCreateBuilding(type)): # TODO: Implement poor logic. 	#Building.GetCurrencyCost()
	#	poorSound.playing = true
	#	return

	var building: Building = buildingFactory.createBuilding(type)
	building.position = position
	add_child(building)
	applyBuildingCost(type)
	
	# todo: Remove monies.
	doCameraShake.emit(0.3)
	onBuildingAdded.emit(building)
	return building

func applyBuildingCost(type: Building.Type):
	match type:
		Building.Type.HONOR_GENERATOR:
			HonorGenerator.getCost(honor)
		Building.Type.MANA_DOG:
			ManaDog.getCost(mana, harmony)
		Building.Type.HEADQUARTER:
			HeadQuarters.getCost(honor, mana, harmony, life)
		Building.Type.EVIL_CASTLE:
			EvilCastle.getCost(death, passion)
		Building.Type.LOG_CABIN:
			LogCabin.getCost(honor, passion)
		Building.Type.WATCH_TOWER:
			WatchTower.getCost(honor, passion, death)
		_:
			push_error("Invalid building type")
			return null
