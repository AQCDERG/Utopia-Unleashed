class_name PathFinderComponent
extends NavigationAgent3D

# Be sure to set "target_position", to go to a target.

enum UpdateRate {
	EVERY_FRAME,
	EVERY_OTHER_FRAME,
	EVERY_5_FRAMES,
	EVERY_30_FRAMES,
	EVERY_60_FRAMES,
}


@export var is_enabled: bool = true
@export var update_rate: UpdateRate = UpdateRate.EVERY_FRAME

var incrementalPositionToGetToTarget: Vector3 = Vector3.ZERO

func _physics_process(delta: float) -> void:
	if (!is_enabled):
		return
	
	if not _should_process_navigation():
		return

	incrementalPositionToGetToTarget = get_next_path_position()


func _should_process_navigation() -> bool:
	if (_get_frame_count() % _get_update_rate() != 0):
		return false
	return true

func _get_frame_count() -> int:
	return Engine.get_physics_frames()


func _get_update_rate() -> int:
	match (update_rate):
		UpdateRate.EVERY_FRAME:
			return 1
		UpdateRate.EVERY_OTHER_FRAME:
			return 2
		UpdateRate.EVERY_5_FRAMES:
			return 5
		UpdateRate.EVERY_30_FRAMES:
			return 30
		UpdateRate.EVERY_60_FRAMES:
			return 60
		_: # default
			return 1