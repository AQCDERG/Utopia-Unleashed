class_name HealthComponent
extends Node

signal onDeath
signal onHealthChanged(newHealth: int)

var _health: int
@export var maxHealth: int = 100

func _enter_tree() -> void:
  _health = maxHealth

var currentHealth: int: 
  set(value):
    if(_health == value):
      return
    _health = value
    _clampToMaxHealth()
    _handleDeath()
    onHealthChanged.emit(_health)
  get:
    return _health

func _clampToMaxHealth() -> void:
  if(_health > maxHealth):
    _health = maxHealth

func _handleDeath() -> void:
  if(_health > 0):
    return
  _health = 0
  onDeath.emit()
    
func takeDamage(amount: int) -> void:
  if(amount < 0):
    push_error("take damage called with negative amount: " + str(amount))
    return
  currentHealth -= amount

func heal(amount: int) -> void:
  if(amount < 0):
    push_error("heal called with negative amount: " + str(amount))
    
  currentHealth += amount