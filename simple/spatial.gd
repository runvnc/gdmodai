extends Spatial

const looksize = 100
var lx = 80
var ly = 250

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
	
	img.lock()
	var arr = data.get_data(imgdata)
	print(arr[0])
	
	for j in range(0,looksize):
		for i in range(0,looksize):
			var color = Color.black
			if arr[j*100+i] != 0:
				color = Color.white
			img.set_pixel(i,j,color)
	img.unlock()
	imgtext.create_from_image(img)
	var view = get_tree().current_scene.find_node("view")
	view.texture = imgtext


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
