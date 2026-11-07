extends CanvasLayer
# ^ CanvasLayer: layer UI terpisah dari dunia game.

@onready var final_score_label = $VBoxContainer/ScoreLabel
@onready var restart_button = $VBoxContainer/RestartButton

# FUNGSI: _ready()
# APA:     Hubungkan signal restart_button dan signal game_over dari GameManager.
# PARAM:   Tidak ada.
# KEMBALI: Tidak ada.
# KONSEP:  Tombol (Button) di Godot punya signal pressed yang bisa di-hubungkan.
func _ready():
    restart_button.pressed.connect(_on_restart_pressed)

    var gm = get_node("/root/Main/GameManager")
    if gm:
        gm.game_over.connect(_on_game_over)  # Tampilkan screen ini saat game over.

# FUNGSI: _on_game_over()
# APA:     Menampilkan GameOver screen dan menampilkan skor akhir.
# PARAM:   Tidak ada.
# KEMBALI: Tidak ada.
# KONSEP:  visible = true — menampilkan/menyembunyikan node UI.
func _on_game_over():
    visible = true
    var gm = get_node("/root/Main/GameManager")
    if gm:
        final_score_label.text = "Final Score: " + str(gm.score)

# FUNGSI: _on_restart_pressed()
# APA:     Menyembunyikan GameOver screen dan memulai game baru.
# PARAM:   Tidak ada.
# KEMBALI: Tidak ada.
# KONSEP:  Game loop — dari game over kembali ke gameplay via restart.
func _on_restart_pressed():
    visible = false
    var gm = get_node("/root/Main/GameManager")
    if gm:
        gm.start_game()  # Reset semua state dan mulai ulang.
