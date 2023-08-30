extends Node3D
var isNewLocationClicked: bool 
var isAnimalClicked: bool
var animalClicked: Animal

@onready var nextPosition: Node3D = %Position
@onready var rayCast: RayCast3D = %RayPosition
@onready var camera: Camera3D = %Camera3D
@onready var visual: StaticBody3D = %StaticBody3D
@onready var visual2: MeshInstance3D = %Mesh
@onready var child: MeshInstance3D = %ChildRayPosition
@onready var animalCreationManager: AnimalCreationManager = %AnimalCreationManager



func _ready() -> void:
	animalCreationManager.onControlableAnimalAdded.connect(detectClick)

func detectClick(animal: Animal) -> void:
	animal.clickDetection.onMouseLeftClicked.connect(moveAnimal.bind(animal))

func moveAnimal(animal: Animal) -> void:
	isAnimalClicked = true
	animal.targetedPathFinder.target = nextPosition

func _input(event):
	if not isAnimalClicked:
		return
	if not isNewLocationClicked:
		isNewLocationClicked = true
		return
	if event is InputEventMouseButton:
		var ray_origin = camera.project_ray_origin(event.position)
		var ray_direction = camera.project_ray_normal(event.position).normalized()
	
		var desired_length = 1000.0
		ray_direction *= desired_length
	
		# Construct the Basis for the Ray's Transform
		var up = Vector3.UP
		if abs(ray_direction.dot(up)) > 0.99:
			up = Vector3.RIGHT
		var right = ray_direction.cross(up).normalized()
		up = right.cross(ray_direction).normalized()
		var basis = Basis(right, up, ray_direction)
	
			# Set the Ray's Global Transform
		rayCast.global_transform = Transform3D(basis, ray_origin)
	
			# Force the raycast to update
		rayCast.force_raycast_update()
	
		if rayCast.is_colliding():
			visual.position = rayCast.get_collision_point()
	
		isAnimalClicked = false
		isNewLocationClicked = false