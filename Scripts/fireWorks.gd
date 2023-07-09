extends Node
@export var firework: GPUParticles3D
@export var firework2: GPUParticles3D
@export var music: AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("fireWorks"):
		firework.emitting = true
		firework2.emitting = true

func _on_audio_stream_player_finished() -> void:
	music.play()
