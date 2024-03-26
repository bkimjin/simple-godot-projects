extends Node

## SceneHandler is the container for the different scenes that gets initialized.
## For example, this scene will initially load the main menu, but can also be
## used to load the game.

## Loads the main menu. Main menu can be referenced from within the game.
func _ready():
	load_main_menu()


## Connects the buttons from MainMenu to functions by signals
func load_main_menu():
	$"MainMenu/MC/VBC/NewGame".connect("pressed", on_new_game_pressed)
	$"MainMenu/MC/VBC/Exit".connect("pressed", on_quit_pressed)
	$"MainMenu/MC/VBC/Options".connect("pressed", on_options_pressed)


## Shows the Load Game scene.
func on_load_game_pressed():
	pass


## Starts new game scene.
func on_new_game_pressed():
	$"MainMenu".queue_free()
	# change scenes using instantiate and call deferred, otherwise engine crashes 
	var game_scene: Node2D = load("res://Scenes/MainScenes/game_scene.tscn").instantiate()
	game_scene.connect("game_finished", unload_game)
	call_deferred('add_child', game_scene)


## Shows the options scene
func on_options_pressed():
	var options_menu: Control = load("res://Scenes/option_menu.tscn").instantiate()
	call_deferred('add_child', options_menu)


## Shows credits scene
func on_credit_pressed():
	pass


## Quits the game
func on_quit_pressed():
	get_tree().quit()


func unload_game(result):
	$GameScene.queue_free()
	var main_menu = load("res://Scenes/UIScenes/main_menu.tscn").instantiate()
	add_child(main_menu)
	load_main_menu()
