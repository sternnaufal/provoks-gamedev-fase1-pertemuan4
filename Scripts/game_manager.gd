extends Node
# ^ Node: node dasar tanpa properti visual. Cocok untuk script manajemen (GameManager).

# KONSEP: Signal — event yang bisa dikirim dan ditangkap oleh node lain.
#          Memisahkan GameManager (logika) dari UI (tampilan).
#          score_changed & lives_changed memberitahu UI untuk update teks.
#          game_over & game_started memberitahu node lain tentang perubahan state.
signal score_changed(new_score)
signal lives_changed(new_lives)
signal game_over
signal game_started

var score : int = 0    # Skor pemain saat ini.
var lives : int = 3    # Jumlah nyawa pemain.
var is_game_over : bool = false  # Apakah game sudah berakhir?
var is_started : bool = false    # Apakah game sudah dimulai?

# FUNGSI: _ready()
# APA:     Inisialisasi game ke state awal saat scene dimuat.
func _ready():
    reset_game()

# FUNGSI: reset_game()
# APA:     Mengembalikan semua variabel ke nilai awal dan emit signal.
# PARAM:   Tidak ada.
# KEMBALI: Tidak ada.
# KONSEP:  Memisahkan logika reset agar bisa dipanggil kapan saja (DRY - Don't Repeat Yourself).
#          emit() — mengirim signal ke semua node yang terhubung.
func reset_game():
    score = 0
    lives = 3
    is_game_over = false
    is_started = false
    score_changed.emit(score)    # Beri tahu UI: score berubah.
    lives_changed.emit(lives)    # Beri tahu UI: lives berubah.

# FUNGSI: start_game()
# APA:     Memulai game baru: reset state, set is_started = true, emit signal.
# PARAM:   Tidak ada.
# KEMBALI: Tidak ada.
# KONSEP:  State management — mengontrol kapan game berjalan/berhenti.
func start_game():
    reset_game()
    is_started = true
    game_started.emit()  # Beri tahu UI (dan node lain) bahwa game dimulai.

# FUNGSI: add_score(points)
# APA:     Menambah skor jika game sedang berjalan dan belum game over.
# PARAM:   points — jumlah poin yang akan ditambahkan (int).
# KEMBALI: Tidak ada.
func add_score(points: int):
    # KONSEP: Guard clause — cegah perubahan saat game tidak aktif.
    if is_game_over or not is_started:
        return
    score += points
    score_changed.emit(score)

# FUNGSI: lose_life()
# APA:     Mengurangi nyawa. Jika nyawa habis (<= 0), set game over.
# PARAM:   Tidak ada.
# KEMBALI: Tidak ada.
# KONSEP:  Game over condition — logika kapan game berakhir.
func lose_life():
    if is_game_over or not is_started:
        return
    lives -= 1
    lives_changed.emit(lives)
    if lives <= 0:
        is_game_over = true
        game_over.emit()  # Beri tahu node lain (misal: GameOver screen).
