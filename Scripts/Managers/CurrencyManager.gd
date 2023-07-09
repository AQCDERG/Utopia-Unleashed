class_name CurrencyManager
extends RefCounted

var amount: int = 0

signal onCurrencyChanged(amount: int)

func add(amnt: int) -> void:

  if amnt < 0:
    push_error("Cannot add negative amount to currency")
    return

  amount += amnt
  onCurrencyChanged.emit(amount)

func remove(amnt: int) -> void:
  if amnt == amount:
    return

  if amnt < 0:
    push_error("Cannot subtract negative amount from currency")
    return

  amount -= amnt
  onCurrencyChanged.emit(amount)