class_name CurrencyManager
extends RefCounted

const DID_NOT_CHANGE = 0

var amount: int = 0

signal onCurrencyChanged(amount: int)

func add(amnt: int) -> void:
  if(amnt == DID_NOT_CHANGE):
    return
  
  if amnt < 0:
    push_error("Cannot add negative amount to currency")
    return

  amount += amnt
  onCurrencyChanged.emit(amount)

func remove(amnt: int) -> void:
  if amnt == DID_NOT_CHANGE:
    return

  if amnt < 0:
    push_error("Cannot subtract negative amount from currency")
    return

  amount -= amnt
  onCurrencyChanged.emit(amount)
