extends Node

const POOL_SIZE: int = 8

var _players: Array[AudioStreamPlayer] = []
var _cache: Dictionary = {}


func _ready() -> void:
	for i in POOL_SIZE:
		var player := AudioStreamPlayer.new()
		player.bus = &"SFX"
		add_child(player)
		_players.append(player)


func play(path: String, volume_db: float = 0.0, pitch_scale: float = 1.0) -> void:
	var stream := _get_stream(path)
	if stream == null:
		push_warning("SFX: Could not load audio at '%s'" % path)
		return

	var player := _get_available_player()
	if player == null:
		push_warning("SFX: All %d audio players are busy" % POOL_SIZE)
		return

	player.stream = stream
	player.volume_db = volume_db
	player.pitch_scale = pitch_scale
	player.play()


func play_random(paths: Array[String], volume_db: float = 0.0, pitch_scale: float = 1.0) -> void:
	if paths.is_empty():
		return
	play(paths.pick_random(), volume_db, pitch_scale)


func _get_stream(path: String) -> AudioStream:
	if _cache.has(path):
		return _cache[path]
	if not ResourceLoader.exists(path):
		return null
	var stream: AudioStream = load(path)
	_cache[path] = stream
	return stream


func _get_available_player() -> AudioStreamPlayer:
	for player in _players:
		if not player.playing:
			return player
	return null
