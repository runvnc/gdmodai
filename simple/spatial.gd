extends Spatial

const looksize = 100
var lx = 100
var ly = 100

var img
var imgtext

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# load the Simple library
onready var data = preload("res://bin/simple.gdns").new()

func _on_Button_pressed():
	img = Image.new()
	img.create(100,100,false,Image.FORMAT_RGBA8)
	var imgdata = []
	var image = get_viewport().get_texture().get_data()
	image.lock()
	img.lock()

	for j in range(0,looksize):
		for i in range(0,looksize):
			var color = image.get_pixel(lx+i,ly+j)
			img.set_pixel(i,j,color)
			imgdata.append(color.to_rgba32())
	
	img.unlock()
	image.unlock()
	imgtext = ImageTexture.new()
	
	imgtext.create_from_image(img)
	var view = get_tree().current_scene.find_node("view")
	view.texture = imgtext
	print(data.get_data(imgdata))

#func _on_Button_pressed():
#	var imgdata = []
#	var view = get_tree().current_scene.find_node("view")
#	#view.draw_rect
#	view.set_texture(get_viewport().get_texture())
#	var image = get_viewport().get_texture().get_data()
#	#var itex = ImageTexture.new()
#
#	#itex.create_from_image(image)
#	#view.Texture = itex
#	for j in range(0,looksize):
#		for i in range(0,looksize):
#		  var color = image.get_pixel(lx+i,ly+j)
#		  imgdata.append(color.to_rgba32())
#
#	print("got image data")
#	print(data.get_data(imgdata))


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
