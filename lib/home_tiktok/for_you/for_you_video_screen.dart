import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:video_player/video_player.dart';

class ForYouVideoScreen extends StatefulWidget {
  const ForYouVideoScreen({super.key});

  @override
  State<ForYouVideoScreen> createState() => _ForYouVideoScreenState();
}

class _ForYouVideoScreenState extends State<ForYouVideoScreen> {
  List<VideoPlayerController> _controllers = [];
  List<bool> _likedVideos = []; // Danh sách trạng thái "like" của từng video

  @override
  void initState() {
    super.initState();
    _loadAllVideos();
  }

  Future<void> _loadAllVideos() async {
    try {
      final storageRef = FirebaseStorage.instance.ref().child('All Videos');
      final ListResult result = await storageRef.listAll();

      for (var item in result.items) {
        final url = await item.getDownloadURL();
        final controller = VideoPlayerController.network(url);
        await controller.initialize();

        // Thêm phần tử vào cả _controllers và _likedVideos
        _controllers.insert(0, controller);      // Thêm controller vào đầu danh sách _controllers
        _likedVideos.insert(0, false);           // Mặc định video chưa được like, thêm vào đầu danh sách _likedVideos

        // Hoặc bạn có thể sử dụng add() nếu không cần sắp xếp lại:
        // _controllers.add(controller);
        // _likedVideos.add(false);
      }

      setState(() {});
    } catch (e) {
      print("Error loading videos: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _controllers.isEmpty
          ? Center(child: CircularProgressIndicator())
          : PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _controllers.length,
        itemBuilder: (context, index) {
          final controller = _controllers[index];
          return GestureDetector(
            onTap: () {
              if (controller.value.isPlaying) {
                controller.pause();
              } else {
                controller.play();
              }
            },
            child: Stack(
              children: [
                // Video player
                SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: controller.value.size.width,
                      height: controller.value.size.height,
                      child: VideoPlayer(controller),
                    ),
                  ),
                ),


                // Thả tim (Like) button
                Positioned(
                  top: 370,
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        // Lật trạng thái like của video hiện tại
                        _likedVideos[index] = !_likedVideos[index];
                      });
                    },
                    child: CircleAvatar(
                      radius: 23,
                      backgroundImage: AssetImage('assets/images/avatar.jpg'),
                    ),
                  ),
                ),
                Positioned(
                  top: 440,
                  right: 10,
                  child: IconButton(
                    icon: Icon(
                      _likedVideos[index]
                          ? Icons.favorite_border// Nếu chưa like, dùng icon 'favorite_border'
                          : Icons.favorite ,  // Nếu like, dùng icon 'favorite'
                      // Xu li chuyen mau
                      color: _likedVideos[index]
                          ? Colors.white // Nếu chưa like, màu trắng
                          : Colors.red, // Nếu đã like, màu đỏ
                      size: 30,
                    ),
                    onPressed: () {
                      setState(() {
                        // Lật trạng thái like của video hiện tại
                        _likedVideos[index] = !_likedVideos[index];
                      });
                    },
                  ),
                ),


                // Bình luận (Comment) button
                Positioned(
                  top: 500,
                  right: 10,
                  child: IconButton(
                    icon: Icon(
                      Icons.comment, // Bình luận
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }
}
