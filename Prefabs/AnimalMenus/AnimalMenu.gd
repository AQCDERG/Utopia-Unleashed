class_name AnimalMenu
extends Control

@onready var animalGamerTag: RichTextLabel = %AnimalGamerTag
@onready var animalHealth: RichTextLabel = %AnimalHealth
@onready var animalAction: RichTextLabel = %AnimalAction
const lavaDeerMenu = preload("res://Prefabs/AnimalMenus/LavaDeer/LavaDeerMenu.tscn")
const hellHoundMenu := preload("res://Prefabs/AnimalMenus/Hellhound/HellhoundMenu.tscn")
const hunterMenu := preload("res://Prefabs/AnimalMenus/Hunter/HunterMenu.tscn")

