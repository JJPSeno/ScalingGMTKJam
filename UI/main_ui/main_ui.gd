extends CanvasLayer
enum FRIEND_TYPES {ADDING, MULTIPLYING}
@onready var hand: Node = $Hand
@onready var set_up: Node = $SetUp


# will change as more friends are added to set_up
var set_up_pos : Vector2 = Vector2(105, 150)

# will change as more cards are added to hand
var hand_pos : Vector2 = Vector2(120, 475)

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
	add_to_hand(FRIEND_TYPES.ADDING)


func add_to_hand(type: FRIEND_TYPES):
	var card_to_add = GameManager.generate_card(type)
	card_to_add.position = hand_pos
	hand_pos.x += 194
	hand.add_child(card_to_add)


func add_to_set_up(type: FRIEND_TYPES):
	var friend_to_add = GameManager.generate_friend(type)
	friend_to_add.position = set_up_pos
	set_up_pos.x += 100
	set_up.add_child(friend_to_add)
