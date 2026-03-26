extends Node

func _ready():
	# GDWiimoteServer.connect_wiimotes is blocking!
	Thread.new().start(_connect_wiimotes_thread)

func _connect_wiimotes_thread():
	# Initialize loading screen
	print("Conectando Wii Remote...")
	# ...

	GDWiimoteServer.initialize_connection(true)
	call_deferred("_on_connection_complete")

func _on_connection_complete():
	# Hide loading screen
	# ...
	
	# Retrieve connected Wiimotes
	var connected_wiimotes = GDWiimoteServer.finalize_connection()
	print(connected_wiimotes)
	## can also retrieve later on with GDWiimoteServer.get_connected_wiimotes()
