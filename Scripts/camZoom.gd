extends SpringArm3D
@export var cameraZoom: float = 0;
@export var zoomSpeed:  float = 0.2;
@export var zoomStandard: float = 1.0;
@export var standard: float = 0;
@export var camera: Camera3D


# Called when the node enters the scene tree for the first time.
func _input(event):
	if event.is_action_pressed("scroll_wheel_up"):
		if(camera.fov < 80):
			cameraZoom += zoomSpeed
			rotation.x -= zoomStandard/20;
			camera.fov+= zoomStandard;
			standard -= cameraZoom/2;
			#spring_length CHANGE THIS LATER TO FIX ZOOM!?!?!?!?
			#if(standard > -7.6):
				#camera.set_v_offset(standard);
	if event.is_action_pressed("scroll_wheel_down"):
		if(camera.fov > 46 && rotation.x < 0.1 ):
			cameraZoom -= zoomSpeed
			rotation.x += zoomStandard/20;
			camera.fov -= zoomStandard;
			standard += cameraZoom/2;
			#if(standard > -7.6):
				#camera.set_v_offset(standard);
		#print(rotation.x)
