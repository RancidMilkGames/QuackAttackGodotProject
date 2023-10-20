## Class for save data
##
## Save data is set to auto-update when the version number is changed.
## This means to add more vars without breaking compatibility,
## you just have to update the version number and [param save_var_names] variable 
## when adding/removing vars.
##
class_name GameSave extends Resource

# Meta
## Version of save data. Be sure to update when changing GameSave to avoid breaks.
var version: float = 1.1

# Game Save Data
## Highest score the player has recieved.
var high_score: int = 0

## List of var names. Needs updated when vars are changed.
## Also be sure to update the [param version] number on changes.
var save_var_names: Array[String] = [
	"high_score",
]
