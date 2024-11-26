import 'package:flutter/material.dart';
import 'package:spotify_clone/constants/constants.dart';
import 'package:spotify_clone/ui/listening_on_screen.dart';
import 'package:spotify_clone/ui/track_view_screen.dart';
import 'package:just_audio/just_audio.dart';
import '../data/datasource/podcast_datasource.dart';

class BottomPlayer extends StatefulWidget {
  const BottomPlayer({super.key});

  @override
  State<BottomPlayer> createState() => _BottomPlayerState();
}

class _BottomPlayerState extends State<BottomPlayer> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isInPlay = false;
  bool _isLiked = false;
  String? podcastImageUrl;
  
  final List<String> _songList = [
    "Shape Of You.mp3",
    "In My Feelings.mp3",
    "Lovely.mp3", 
    "One Kiss.mp3",
    "Tonight.mp3",
    "Diamon.mp3" 
  ];

  int _currentSongIndex = 0; // Chỉ số bài hát hiện tại

  @override
  void initState() {
    super.initState();
    _loadAudio();
  }

  Future<void> _loadAudio() async {
    final datasource = PodcastFirebaseDatasource();

    try {
      // Lấy URL bài hát từ Firebase
      final url = await datasource.getSongUrl(_songList[_currentSongIndex]); // Lấy bài hát theo chỉ số
      await _audioPlayer.setUrl(url);

      // Lấy URL hình ảnh podcast từ Firebase và cập nhật state
      final imageUrl = await datasource.getPodcastImageUrl("player.png");
      setState(() {
        podcastImageUrl = imageUrl;
      });
    } catch (e) {
      print("Lỗi khi tải audio hoặc hình ảnh: $e");
    }
  }

  void _nextSong() {
    setState(() {
      _currentSongIndex = (_currentSongIndex + 1) % _songList.length; // Tăng chỉ số bài hát
    });
    _loadAudio(); // Tải bài hát mới
    _audioPlayer.play(); // Phát bài hát mới
  }

  void _previousSong() {
    setState(() {
      _currentSongIndex = (_currentSongIndex - 1 + _songList.length) % _songList.length; // Giảm chỉ số bài hát
    });
    _loadAudio(); // Tải bài hát mới
    _audioPlayer.play(); // Phát bài hát mới
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: [
          // Background image nếu có podcastImageUrl
          if (podcastImageUrl != null)
            Positioned.fill(
              child: Image.network(
                podcastImageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Trả về ảnh cục bộ khi không tải được ảnh từ URL
                  return Image.asset(
                    "images/home/chill-mix.png",
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),

          // Foreground UI
          Container(
            height: 61, // Đảm bảo container không bị quá nhỏ
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 83, 83, 83).withOpacity(0.2),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Điều chỉnh kích thước để tránh overflow
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Điều hướng đến TrackViewScreen khi nhấn vào thông tin bài hát
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const TrackViewScreen(),
                              ),
                            );
                          },
                          child: Expanded(
                            child: Text(
                              _songList[_currentSongIndex], // Hiển thị tên bài hát hiện tại
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                _isLiked ? Icons.favorite : Icons.favorite_border,
                                color: _isLiked ? MyColors.greenColor : MyColors.whiteColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isLiked = !_isLiked;
                                });
                              },
                            ),
                            // Nút Back
                            IconButton(
                              icon: Icon(
                                Icons.skip_previous,
                                color: MyColors.whiteColor,
                              ),
                              onPressed: _previousSong, // Gọi hàm quay lại bài hát trước
                            ),
                            // Nút Play/Pause
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _isInPlay = !_isInPlay;
                                });
                                _isInPlay ? _audioPlayer.play() : _audioPlayer.pause();
                              },
                              child: Icon(
                                _isInPlay ? Icons.pause : Icons.play_arrow,
                                color: MyColors.whiteColor,
                                size: 24,
                              ),
                            ),
                            // Nút Next
                            IconButton(
                              icon: Icon(
                                Icons.skip_next,
                                color: MyColors.whiteColor,
                              ),
                              onPressed: _nextSong, // Gọi hàm chuyển bài hát
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Thanh tiến trình
                  SliderTheme(
                    data: SliderThemeData(
                      overlayShape: SliderComponentShape.noOverlay,
                      thumbShape: SliderComponentShape.noThumb,
                      trackShape: const RectangularSliderTrackShape(),
                      trackHeight: 3,
                    ),
                    child: StreamBuilder<Duration?>( // Thanh tiến trình âm thanh
                      stream: _audioPlayer.durationStream,
                      builder: (context, snapshot) {
                        final duration = snapshot.data ?? Duration.zero;
                        return StreamBuilder<Duration>(
                          stream: _audioPlayer.positionStream,
                          builder: (context, snapshot) {
                            var position = snapshot.data ?? Duration.zero;
                            return Slider(
                              activeColor: const Color.fromARGB(255, 230, 229, 229),
                              inactiveColor: MyColors.lightGrey,
                              value: position.inMilliseconds.toDouble(),
                              max: duration.inMilliseconds.toDouble(),
                              onChanged: (value) {
                                _audioPlayer.seek(Duration(milliseconds: value.toInt()));
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

