extends CharacterBody2D

var horizontal_speed = 200 # Horizontal speed of the player
var vertical_speed = 150 # Vertical speed of the player
var playAnimation = false

# Called when the node enters the scene tree for the first time.
func _ready():
    pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):

    # Get the input from the player
    var horizontal_input = Input.get_action_strength("right") - Input.get_action_strength("left")
    var vertical_input = Input.get_action_strength("down") - Input.get_action_strength("up")
    
    # Set the velocity of the player
    velocity.x = horizontal_input * horizontal_speed
    velocity.y = vertical_input * vertical_speed

    # Flip the player sprite and animation
    if horizontal_input != 0:
        $playerSprite.flip_h = horizontal_input < 0
    if velocity.x != 0 || velocity.y != 0:
        $playerSprite.play("default")
    
        
    # Make the player shoot
    if Input.is_action_just_pressed("shoot"):
        $playerSprite.play("shooting")
        playAnimation = false
        while !playAnimation:
            velocity.x = 0
            velocity.y = 0
    
    # Keep this on the bottom of the _process function
    move_and_slide()


# Called when the animation is looped
func _on_player_sprite_animation_looped():
    if $playerSprite.animation == "shooting":
        $playerSprite.play("default")
        playAnimation = true
        shoot()

func shoot():
    pass # for now
