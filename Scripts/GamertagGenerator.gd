class_name GamertagGenerator

enum CaseType {
  LOWER = 0,
  UPPER = 1,
  CAPITALIZE = 2
}

const MINIMUM_NUMBER: int = 1
const MAXIMUM_NUMBER: int = 999

var adjectives = [
    "Sneaky", "Epic", "Tactical", "Furious", "Chubby", "Fluffy", "Slimy", 
    "Crazy", "Silly", "Unbeatable", "Dancing", "Invisible", "Floating",
    "Farting", "Screaming", "Flying", "Sleeping", "Running", "Speedy", 
    "Salty", "Spicy", "Caffeinated", "Hyperactive", "Mischievous", "Chilling"
]

var nouns = [
    "Penguin", "Unicorn", "Ninja", "Pirate", "Zombie", "Robot", "Taco", "Potato", 
    "Chicken", "Panda", "Banana", "Goblin", "Bunny", "Alien", "Dinosaur",
    "Octopus", "Tomato", "Donkey", "Walrus", "Chimpanzee", "Giraffe", 
    "Sloth", "Pickle", "Ostrich", "Sasquatch", "Pony", "Llama", "Goose", "Wombat"
]

var special_chars = ["!", "@", "#", "$", "%", "&", "*"]

func generateGamerTag() -> String:
  var adjective: String = adjectives.pick_random()
  var noun: String = nouns.pick_random()
  var number: String = str(randi_range(MINIMUM_NUMBER, MAXIMUM_NUMBER))
  var special_char: String = special_chars.pick_random()

  var gamer_tag = adjective + noun + str(number) + special_char

  gamer_tag = _changeCaseRandomly(gamer_tag)

  return gamer_tag


func _changeCaseRandomly(input: String) -> String:
  # Keys are like "LOWER", "UPPER", "CAPITALIZE
  var randomCase: CaseType = CaseType.keys().pick_random() # randi_range(CaseType.LOWER, CaseType.CAPITALIZE)
  match randomCase:
    CaseType.LOWER:
      return input.to_lower()
    CaseType.UPPER:
      return input.to_upper()
    CaseType.CAPITALIZE:
      return input.capitalize()
    _:
      push_error("Invalid case type")
      return input