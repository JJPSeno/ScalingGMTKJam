extends CanvasLayer
enum FRIEND_TYPES {ADDING, MULTIPLYING, ADDING2, EXPO}
@onready var hand: Node = $Hand
@onready var unleash_button: Button = $UnleashButton
@onready var boss_name: Label = $HealthComponent/boss_name
@onready var boss_health: Label = $HealthComponent/boss_health
@export var set_up: Node2D
const MARGIN = 25

# will change as more friends are added to set_up
var last_pos : Vector2 = Vector2(-MARGIN, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hand.visible = false
	GameManager.connect("set_up_card", add_to_set_up)
	Transition.connect("transition_finished", show_hand)
	if !Transition.animation_player.is_playing():
		Transition.animation_player.play("sweep_out")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func format(int_damage: int) -> String:
	var str_damage := String.num_int64(int_damage)
	var str_len := str_damage.length()
	var buffer : Array[String]
	var ret_string : String
	
	while str_len > 0:
		buffer.push_front(str_damage.right(3))
		str_damage = str_damage.left(max(str_len-3,0))
		str_len = str_damage.length()
	
	ret_string = ",".join(buffer)
	
	return ret_string

func populate_health_component(input_boss_name: String, input_boss_health: int):
	boss_name.text = "HEALTH OF\n"+input_boss_name
	boss_health.text = format(input_boss_health)

func generate_hand(hand_input: Array):
	while !hand_input.is_empty():
		add_to_hand(hand_input.pop_front())


func add_to_hand(type: FRIEND_TYPES):
	var card_to_add = GameManager.generate_card(type)
	hand.add_child(card_to_add)


func add_to_set_up(type: FRIEND_TYPES):
	var friend_to_add = GameManager.generate_friend(type)
	var sprite_rect = friend_to_add.sprite.get_size()
	GameManager.pipeline_queue.push_back({"type":type, "position": last_pos})
	last_pos += Vector2(
		sprite_rect.x + MARGIN,
		0
	) 
	
	friend_to_add.position = last_pos
	set_up.add_child(friend_to_add)


func show_hand():
	hand.visible = true


func hide_hand():
	hand.visible = false

func _on_unleash_button_pressed() -> void:
	GameManager.start_full_pipeline()
	unleash_button.queue_free()
	
