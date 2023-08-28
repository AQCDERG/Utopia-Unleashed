class_name DefenderBuilding
extends Building

var bulletVelocity: Vector3

@export var _attackIntervalSeconds: float
@export var damage: int

@onready var bullet: PackedScene
@onready var _attackArea: Area3D = %AttackArea # You need to have this node in your scene.
@onready var shootSound: AudioStreamPlayer3D = %AttackSound

var _currentTarget: Animal

func _ready() -> void:
	_createAndConfigureTimer()
	_attackArea.body_entered.connect(_target)
	_attackArea.body_exited.connect(_disengage)

func _createAndConfigureTimer() -> void:
	var timer: Timer = Timer.new()
	timer.wait_time = _attackIntervalSeconds
	timer.one_shot = false
	timer.timeout.connect(_attackTarget)
	add_child(timer)
	timer.start()
	

func _attackTarget() -> void:
	if(_currentTarget == null):
		return
	createBullet()
	#_currentTarget.health.takeDamage(damage)

func createBullet() -> void:
	if(bullet == null):
		return
	var bulletInstance = bullet.instantiate()
	add_child(bulletInstance)
	shootSound.playing = true
	print("PLAY")
	bulletInstance.launch(_currentTarget)



func _target(possibleVictim: Node3D) -> void:
	if(possibleVictim is Animal):
		_currentTarget = possibleVictim


func _disengage(possibleVictim: Node3D) -> void:
	if(possibleVictim == _currentTarget):
		_currentTarget = null

func setSound(soundPath: String) -> void:
	if(shootSound != null):
		shootSound.stream = load(soundPath)
	print("NILL")
