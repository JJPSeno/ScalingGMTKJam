extends CanvasLayer
enum FRIEND_TYPES {ADDING, MULTIPLYING}
@onready var hand: Node = $Hand
@onready var set_up: Node = $SetUp

const MARGIN = 25

# will change as more friends are added to set_up
var last_pos : Vector2 = Vector2(-MARGIN, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
    GameManager.connect("set_up_card", add_to_set_up)
    generate_hand()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
    pass


func generate_hand():
    add_to_hand(FRIEND_TYPES.ADDING)
    add_to_hand(FRIEND_TYPES.ADDING)
    add_to_hand(FRIEND_TYPES.MULTIPLYING)
    add_to_hand(FRIEND_TYPES.MULTIPLYING)
    add_to_hand(FRIEND_TYPES.MULTIPLYING)
    add_to_hand(FRIEND_TYPES.ADDING)


func add_to_hand(type: FRIEND_TYPES):
    var card_to_add = GameManager.generate_card(type)
    hand.add_child(card_to_add)


func add_to_set_up(type: FRIEND_TYPES):
    var friend_to_add = GameManager.generate_friend(type)
    var sprite_rect = friend_to_add.sprite.get_size()
    
    last_pos += Vector2(
        sprite_rect.x + MARGIN,
        0
    ) 
    
    friend_to_add.position = last_pos
    set_up.add_child(friend_to_add)
