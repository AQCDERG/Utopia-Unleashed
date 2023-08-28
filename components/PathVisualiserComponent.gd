class_name PathVisualiserComponent
extends Node3D


# Its actually like the animal, but UnrealEngine:tm:
@export var actor: Node3D

var pathFinderComponent: PathFinderComponent
var pathNode: Path3D = Path3D.new()
var mesh: CSGPolygon3D = CSGPolygon3D.new()

var incrementalMesh: MeshInstance3D = MeshInstance3D.new()
var finalMesh: MeshInstance3D = MeshInstance3D.new()

# maybe if we need it, we can make a DebugVisualiserBox, instead of copy pasting the code here.
var incrementalMaterial: StandardMaterial3D = StandardMaterial3D.new()
var finalMaterial: StandardMaterial3D = StandardMaterial3D.new()

func _ready() -> void:
  pathFinderComponent = get_parent()

  incrementalMaterial.albedo_color = Color(0.0, 1.0, 0.0, 0.2) # 🥇 <--- A big shiny medal.
  incrementalMaterial.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
  incrementalMaterial.emission_enabled = true

  incrementalMesh.material_override = incrementalMaterial
  incrementalMesh.mesh = BoxMesh.new()

  # Final mesh.
  finalMaterial.albedo_color = Color.YELLOW
  finalMaterial.transparency = BaseMaterial3D.TRANSPARENCY_ALPHA
  finalMaterial.emission_enabled = true

  finalMesh.material_override = finalMaterial
  finalMesh.mesh = BoxMesh.new()

  add_child(incrementalMesh)
  add_child(finalMesh)



func _process(_delta: float) -> void:
  var actionPosition: Vector3 = actor.global_position
  var pathIncrementPosition: Vector3 = pathFinderComponent.incrementalPositionToGetToTarget
  
  # Sinewave scale.
  incrementalMesh.scale = Vector3(1, 1, 1) * (1.4 + sin(Time.get_ticks_msec() / 100.0)) * 0.4

  incrementalMesh.global_position = pathIncrementPosition - Vector3(0,1,0)

  # Final mesh.
  finalMesh.global_position = pathFinderComponent.target_position

  # Final mesh scale.
  finalMesh.scale = Vector3(1, 1, 1) * (1.4 + sin(Time.get_ticks_msec() / 50.0)) * 0.7



