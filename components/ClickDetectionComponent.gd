extends Area3D
class_name ClickDetectionComponent
signal onMouseLeftClickedAnimal
signal onMouseLeftClicked
signal onBuildingClicked

var _isMouseHoveredOver: bool = false

func _ready() -> void:
  mouse_entered.connect(_mouse_entered_bounds)
  mouse_exited.connect(_mouse_exited_bounds)

func _input_event(_cam: Camera3D, event: InputEvent, _pos: Vector3, _nor: Vector3, _sidx: int) -> void:
  if (not _isMouseHoveredOver):
    return
  
  if event is InputEventMouseButton:
    var mouseButtonEvent = event as InputEventMouseButton
    if (_is_left_clicked(mouseButtonEvent)):
      onMouseLeftClicked.emit()
      onBuildingClicked.emit(self)
      print("CLICKED ")

func _is_left_clicked(event: InputEventMouseButton) -> bool:
  return event.pressed && event.button_index == MouseButton.MOUSE_BUTTON_LEFT

func _mouse_entered_bounds() -> void:
  _isMouseHoveredOver = true
  pass

func _mouse_exited_bounds() -> void:
  _isMouseHoveredOver = false
  pass
