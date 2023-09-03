#extends Node3D
#var direction: Vector3 = Vector3()
#@export var actor: CharacterBody3D
#@onready var attackAction = %AttackAction

#func _ready() -> void:
#  attackAction.hasTarget.connect(moveToTarget)

#func moveToTarget(target: Node3D) -> void:
 # pass
  #direction = target.position - self.global_transform.origin
  #var targetPos: Vector3 = pathFinder.incrementalPositionToGetToTarget - Vector3(0,0.5,0)
  #var targetVelocity: Vector3 = (targetPos - animal.global_transform.origin).normalized() * SPEED
  #actor.velocity = actor.velocity.move_toward(targetVelocity, delta * ACCELERATION)
