extends Node


const GAME_SCENE_PATH: String = "res://oldMain.tscn"

var _loading: bool  = true;
var _loadStatus: Array = [0]; # funny way to get the load status cause godot is dumb

@onready var tipLabel: RichTextLabel = %Tips
@onready var loadingMusic: AudioStreamPlayer = %LoadingMusic
@onready var loadingBar: ProgressBar = %LoadingBar
@onready var scrollingAnimation: AnimationPlayer = %ScrollingAnimation
@onready var uiBackground: TextureRect = %SideScrollingImage
@onready var allUi = ["res://SpriteImages/HellHoundImage.jpg", "res://SpriteImages/LavaDeerImage.jpg"]

var possibleTips = ["Legends say that the evil castle can spawn fix it felix", "Make sure to collect all the delicous meats as possible"]

var _log: Log

func _enter_tree() -> void:
	_log = Log.new(get_script())

func _ready() -> void:
	_log.info("Loading game....")
	startGameLoad();
	changeTip() # show tip immediately
	changeTipEverySoOften()
	replayScrolling()

func startGameLoad() -> void:
	var error: Error = ResourceLoader.load_threaded_request(GAME_SCENE_PATH, "PackedScene");
	if (error != Error.OK):
		_log.error("Failed to load game scene: ", error);

func changeTipEverySoOften() -> void:
	const TIP_CHANGE_TIME: float = 5.0;
	var timer: Timer = Timer.new();
	timer.wait_time = TIP_CHANGE_TIME;
	timer.autostart = true;
	timer.one_shot = false;
	timer.timeout.connect(changeTip)
	add_child(timer)

func changeTip() -> void:
	tipLabel.text = possibleTips[randi_range(0, possibleTips.size() - 1)]

func _process(_delta: float) -> void:
	if (!_loading):
		return;

	var loadingProgress: int = PollGameLoadStatus();
	loadingBar.value = loadingProgress;

	if (loadingProgress == 100): 
		_loading = false;
		_log.info("Starting game...");
		StartGame();

func PollGameLoadStatus() -> int:
	var loadStatus: ResourceLoader.ThreadLoadStatus = ResourceLoader.load_threaded_get_status(GAME_SCENE_PATH, _loadStatus);
	match (loadStatus):
		ResourceLoader.ThreadLoadStatus.THREAD_LOAD_FAILED:
			_log.error("Failed to load game scene: ", loadStatus);
			_loading = false;
		ResourceLoader.ThreadLoadStatus.THREAD_LOAD_INVALID_RESOURCE:
			_log.info("Invalid resource: ", loadStatus);
			_loading = false;
		ResourceLoader.ThreadLoadStatus.THREAD_LOAD_IN_PROGRESS:
			return _loadStatus[0] as int;
		ResourceLoader.ThreadLoadStatus.THREAD_LOAD_LOADED:
			return 100;
		_: # default
			return 1
	return 0;


func StartGame() -> void: 
		#// might still be setting up current scene, so just wait for it to finish.
		await get_tree().process_frame
		var gameScenePacked: PackedScene = GetGameScene();
		get_tree().change_scene_to_packed(gameScenePacked);


func GetGameScene() -> PackedScene: 
	return ResourceLoader.load_threaded_get(GAME_SCENE_PATH) as PackedScene;


func replayScrolling() -> void:
	uiBackground.texture = load(allUi[randi_range(0, allUi.size() - 1)])
	scrollingAnimation.play("ScrollImage")
	

func _on_scrolling_animation_animation_finished(anim_name: StringName) -> void:
	replayScrolling()

	



