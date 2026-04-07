extends Node2D
var loading

func _ready():
	# GDWiimoteServer.connect_wiimotes is blocking!
	loading = get_tree().get_current_scene().get_node("Loading")
	Thread.new().start(_connect_wiimotes_thread)

func _connect_wiimotes_thread():
	# Initialize loading screen
	call_deferred("_start_loading")
	print("Conectando Wii Remote...")
	# ...

	GDWiimoteServer.initialize_connection(true)
	call_deferred("_on_connection_complete")

func _on_connection_complete():
	# Hide loading screen
	loading.hide()
	# ...
	
	# Retrieve connected Wiimotes
	var connected_wiimotes = GDWiimoteServer.finalize_connection()
	print(connected_wiimotes)
	## can also retrieve later on with GDWiimoteServer.get_connected_wiimotes()

func _start_loading():
	loading.show()
