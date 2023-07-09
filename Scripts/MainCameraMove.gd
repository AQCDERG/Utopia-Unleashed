extends Camera3D


var _tension: float = 0.0 # Should be intensity.
var _max_tension: float = 50.0

func _process(delta: float) -> void:
	_calculate_camera_shake(delta)
	
func _enter_tree() -> void:
	var world: World = Game.world
	if(world != null):
		world.doCameraShake.connect(func(amount: float):
			add_shake_tension(amount)
		)
func add_shake_tension(amount: float) -> void:
	_tension += amount
	clampf(_tension, 0.0, _max_tension) # Don't go over the limit.

func _get_current_shake_position() -> Vector3:
	var shake_position: Vector3 = Vector3.ZERO
	if _tension > 0.0:
		shake_position = Vector3(randf_range(-_tension, _tension), randf_range(-_tension, _tension), randf_range(-_tension, _tension))
	return shake_position

func _calculate_camera_shake(time_delta: float) -> void:
	if _tension == 0.0:
		return
	var new_rotation: Vector3 = Vector3.ZERO

	new_rotation.x = randf_range(-_tension, _tension)
	new_rotation.y = randf_range(-_tension, _tension)
	new_rotation.z = randf_range(-_tension, _tension)
	rotation_degrees = new_rotation

	_tension = lerp(_tension, 0.0, time_delta * 5)

	if abs(_tension) < 0.05:
		_tension = 0.0