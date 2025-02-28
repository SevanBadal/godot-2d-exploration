extends Node

@onready var time = $Timer # use if referencing many times

func get_time_elapsed():
	return time.wait_time - time.time_left
