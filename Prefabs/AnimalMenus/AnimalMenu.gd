class_name AnimalMenu
extends Control

# const lavaDeerMenu = preload("res://Prefabs/AnimalMenus/LavaDeer/LavaDeerMenu.tscn")
# const hellHoundMenu := preload("res://Prefabs/AnimalMenus/Hellhound/HellhoundMenu.tscn")
# const hunterMenu := preload("res://Prefabs/AnimalMenus/Hunter/HunterMenu.tscn")

@onready var animalGamerTag: RichTextLabel = %AnimalGamerTag
@onready var animalHealth: RichTextLabel = %AnimalHealth
@onready var animalAction: RichTextLabel = %AnimalAction

var animalGamerTagText: String = ""
var animalHealthText: String = ""
var animalActionText: String = ""

func _ready():
  animalGamerTag.text = animalGamerTagText
  animalHealth.text = animalHealthText
  animalAction.text = animalActionText

func configure(animal: Animal):
  animalGamerTagText = animal.gamerTag.username
  animalHealthText = str(animal.health.getHealth())

