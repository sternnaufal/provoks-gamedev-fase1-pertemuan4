extends CanvasLayer
# ^ CanvasLayer: node yang menampilkan UI di layer terpisah dari dunia game.
#   UI tidak terpengaruh oleh camera atau transformasi dunia.

# KONSEP: @onready — memastikan node sudah siap sebelum diakses.
#          Sama seperti get_node(), tapi dipanggil otomatis setelah _ready().
@onready var score_label = $ScoreLabel
@onready var lives_label = $LivesLabel
@onready var start_label = $StartLabel

# FUNGSI: _ready()
# APA:     Menghubungkan signal dari GameManager ke fungsi update UI.
# PARAM:   Tidak ada.
# KEMBALI: Tidak ada.
# KONSEP:  Menghubungkan signal GameManager ke UI — memisahkan logika dari tampilan.
func _ready():
    var gm = get_node("/root/Main/GameManager")
    if gm:
        gm.score_changed.connect(_on_score_changed)
        gm.lives_changed.connect(_on_lives_changed)
        gm.game_started.connect(_on_game_started)

# FUNGSI: _input(event)
# APA:     Menangani input untuk memulai game (tekan Enter/Space).
# PARAM:   event — objek InputEvent yang terjadi.
# KEMBALI: Tidak ada.
# KONSEP:  Input handling via _input() — alternate dari Input.get_axis().
#          is_action_pressed("ui_accept") — mendeteksi tombol Enter/Space.
func _input(event):
    if event.is_action_pressed("ui_accept"):
        var gm = get_node("/root/Main/GameManager")
        if gm and not gm.is_started:
            gm.start_game()

# FUNGSI: _on_score_changed(score)
# APA:     Update teks score_label saat score berubah.
# PARAM:   score — nilai skor baru (int) dari signal.
# KEMBALI: Tidak ada.
# KONSEP:  str() — mengkonversi integer/float ke string untuk ditampilkan di Label.
func _on_score_changed(score):
    score_label.text = "Score: " + str(score)

# FUNGSI: _on_lives_changed(lives)
# APA:     Update teks lives_label saat nyawa berubah.
# PARAM:   lives — nilai nyawa baru (int) dari signal.
# KEMBALI: Tidak ada.
func _on_lives_changed(lives):
    lives_label.text = "Lives: " + str(lives)

# FUNGSI: _on_game_started()
# APA:     Menyembunyikan teks "Press Enter to Start" saat game dimulai.
# PARAM:   Tidak ada.
# KEMBALI: Tidak ada.
func _on_game_started():
    start_label.visible = false
