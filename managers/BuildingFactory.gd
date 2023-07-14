class_name BuildingFactory
extends Node

const MAX_HEADQUARTERS_AMOUNT: int = 3

var _currentHeadquartersAmount: int = 0

func _exampleFunctionThatDoesntServerAnyPurposeButToExplainScenes():
  var dogPacked: PackedScene = ManaDog.GetScene() # DATA
  var dogScene: ManaDog = dogPacked.instantiate() # INSTANCE/SCENE/NODE
  print(dogScene.name)
  # > ManaDog

  var kids: Array[Node] = dogScene.get_node("Effects").get_children()
  for kid in kids:
    print(kid.name)
  # > CreationFinishedParticle
  # > CreationParticle
  add_child(dogScene) # the instance is now added as a child under this factory node and is now in the scene tree

  var someNewNode: Node = Node.new()
  someNewNode.name = "SomeNewNode"
  add_child(someNewNode) 

func canCreateHeadquarters() -> bool:
  return _currentHeadquartersAmount < MAX_HEADQUARTERS_AMOUNT

func createBuilding(type: Building.Type) -> Building:
  match type:
    Building.Type.HEADQUARTER:
      _currentHeadquartersAmount += 1
      return HeadQuarters.GetScene().instantiate()
    Building.Type.HONOR_GENERATOR:
      return HonorGenerator.GetScene().instantiate()
    Building.Type.LOG_CABIN:
      return LogCabin.GetScene().instantiate()
    Building.Type.EVIL_CASTLE:
      print("DO")
      return EvilCastle.GetScene().instantiate()
    Building.Type.MANA_DOG:
      print("BO")
      return ManaDog.GetScene().instantiate()
    _:
      push_error("Unknown building type: " + Building.Type.find_key(type))
  return null

func getBuildingCost(type: Building.Type) -> Array[Currency]:
  match type:
    Building.Type.HEADQUARTER:
      return HeadQuarters.GetCurrencyCost()
    Building.Type.HONOR_GENERATOR:
      return HonorGenerator.GetCurrencyCost()
    Building.Type.LOG_CABIN:
      return LogCabin.GetCurrencyCost()
    Building.Type.EVIL_CASTLE:
      return EvilCastle.GetCurrencyCost()
    Building.Type.MANA_DOG:
      return ManaDog.GetCurrencyCost()
    _:
      push_error("Unknown building type: " + Building.Type.find_key(type))
      return []

