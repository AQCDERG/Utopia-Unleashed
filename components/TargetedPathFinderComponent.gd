class_name TargetedPathFinderComponente
extends PathFinderComponent

signal onTargetLost

var hasTarget: bool:
	get:
		return target != null

var target: Node3D

var _accountedForTargetLoss: bool = false

func _physics_process(delta: float) -> void:
	# stupid convert to event driven.
	if (!hasTarget):
		if (_accountedForTargetLoss):
			return
		
		_accountedForTargetLoss = true
		onTargetLost.emit()
		return	
	_accountedForTargetLoss = false

	# -----------------------------

	target_position = target.global_position
	super()