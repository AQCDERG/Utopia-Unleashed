extends Node3D
var bulletVelocity: Vector3

@export var _attackIntervalSeconds: float
@export var damage: int




@export var bullet: PackedScene
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
	shootSound.play(0.5)
	bulletInstance.launch(_currentTarget, self.owner)



func _target(possibleVictim: Node3D) -> void:
	if(possibleVictim == self):
		#print("FAILED")
		return
	if(possibleVictim is Animal || possibleVictim is Building):
		_currentTarget = possibleVictim
		#print("TARGET")
		#print(possibleVictim.name)
	#print("OK")

func _disengage(possibleVictim: Node3D) -> void:
	if(possibleVictim == _currentTarget):
		_currentTarget = null
		
func setSound(soundPath: String) -> void:
	if(shootSound != null):
		shootSound.stream = load(soundPath)
	#print("NILL")
