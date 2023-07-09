extends Node3D

var nerd: bool
var cool: bool
var weeb: bool
var roleplayer: bool
var type: int = randi_range(1,4)


func _ready() -> void:
  if(type == 1):
    nerd = true;
  elif(type == 2):
    cool = true
  elif(type == 3):
    weeb = true
  else:
    roleplayer = true
