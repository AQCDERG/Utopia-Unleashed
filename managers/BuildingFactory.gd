class_name BuildingFactory
extends Node

const MAX_HEADQUARTERS_AMOUNT: int = 3

@export var headquatersPackedScene: PackedScene
@export var honorGeneratorPackedScene: PackedScene
@export var logCabinPackedScene: PackedScene
@export var evilCastlePackedScene: PackedScene 
@export var manaDogPackedScene: PackedScene

var _currentHeadquartersAmount: int = 0

func canCreateBuilding(type: Building.Type) -> bool:
  var cost: int = getBuildingCost(type)
  if (!_canAfford(cost)):
    return false

  if (type == Building.Type.HEADQUARTER):
    var canCreate: bool = canCreateHeadquarters()
    return canCreate
  # All other buildings.
  return true

func getBuildingCost(type: Building.Type) -> int:
  match type:
      Building.Type.HEADQUARTER:
          return Building.HEADQUARTER_PRICE
      Building.Type.HONOR_GENERATOR:
          return Building.HONOR_GENERATOR_PRICE
      Building.Type.LOG_CABIN:
          return Building.LOG_CABIN_PRICE
      Building.Type.EVIL_CASTLE:
          return Building.EVIL_CASTLE_PRICE
      Building.Type.MANA_DOG:
          return Building.MANA_DOG_PRICE
      _:
          push_error("Unknown building type: " + Building.Type.find_key(type))
          return 0

func _canAfford(cost: int) -> bool:
  var currentHonor: int = Game.world.honor.amount
  return currentHonor >= cost

func canCreateHeadquarters() -> bool:
  return _currentHeadquartersAmount < MAX_HEADQUARTERS_AMOUNT

func getBuilding(type: Building.Type) -> Building:
  var building: Building
  match type:
      Building.Type.HEADQUARTER:
          building = headquatersPackedScene.instantiate()
          _currentHeadquartersAmount += 1
      Building.Type.HONOR_GENERATOR:
          building = honorGeneratorPackedScene.instantiate()
      Building.Type.LOG_CABIN:
          building = logCabinPackedScene.instantiate()
      Building.Type.EVIL_CASTLE:
          building = evilCastlePackedScene.instantiate()
      Building.Type.MANA_DOG:
          building = manaDogPackedScene.instantiate()
      _:
        push_error("Unknown building type: " + Building.Type.find_key(type))
  return building