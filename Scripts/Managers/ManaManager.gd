class_name ManaManager
extends StaticBody3D

signal onManaChanged(newMana: int)

var _mana: int
@export var maxMana: int = 100

var currentMana: int: 
  set(value):
    if(_mana == value):
      return
    _mana = value
    clampToMaxMana()
    clampToMinimumMana()
    onManaChanged.emit(_mana)
  get:
    return _mana

func _enter_tree() -> void:
  _mana = maxMana

func clampToMaxMana() -> void:
  if(_mana > maxMana):
    _mana = maxMana

func clampToMinimumMana() -> void:
  if(_mana > 0):
    return
  _mana = 0
    
func depleteMana(amount: int) -> void:
  if(amount < 0):
    push_error("depleteMana called with negative amount: " + str(amount))
    return
  currentMana -= amount

func rechargeMana(amount: int) -> void:
  if(amount < 0):
    push_error("rechargeMana called with negative amount: " + str(amount))
    return
  currentMana += amount