class_name Currency
extends RefCounted

enum Type {
  HONOR,
  SCIENCE,
  SOLDIERS,
  MANA,
  LIFE,
  PASSION,
  DEATH,
  HARMONY
}

var amount: int
var type: Type

func _init(_type: Type, _amount: int):
  amount = _amount
  type = _type