import 'package:spotify_clone/data/model/podcast.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class PodcastDatasource {
  Future<List<Podcast>> getPodcastList();
  Future<String> getSongUrl(String fileName);
  Future<String> getPodcastImageUrl(String imageName);
}

class PodcastFirebaseDatasource extends PodcastDatasource {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  Future<String> getPodcastImageUrl(String imageName) async {
    try {
      final ref = _storage.ref().child('podcasts/$imageName');
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      print("Lỗi khi tải URL hình ảnh podcast từ Firebase: $e");
      return Future.error("Không thể tải hình ảnh podcast từ Firebase Storage. Vui lòng kiểm tra lại đường dẫn và quyền truy cập.");
    }
  }

  @override
  Future<String> getSongUrl(String fileName) async {
    try {
      final ref = _storage.ref().child('songs/$fileName');
      final url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      print("Lỗi khi tải URL bài hát từ Firebase: $e");
      return Future.error("Không thể tải bài hát từ Firebase Storage. Vui lòng kiểm tra lại đường dẫn và quyền truy cập.");
    }
  }

  @override
  Future<List<Podcast>> getPodcastList() {
    // Chưa triển khai, có thể thêm sau
    throw UnimplementedError();
  }
}

class PodcastLocalDatasource extends PodcastDatasource {
  @override
  Future<List<Podcast>> getPodcastList() async {
    return [
      Podcast(
        "The-Joe-Rogan-Experience.jpg",
        "The Joe Rogan Experience",
      ),
      Podcast(
        "The-Iced-coffe-hour.jpg",
        "The Iced Coffee Hour",
      ),
      Podcast(
        "Startalk.jpg",
        "StarTalk Radio",
      ),
      Podcast(
        "shxts-ngigs.jpg",
        "ShxtsNGigs",
      ),
      Podcast(
        "podcast-p.jpg",
        "Podcast P",
      ),
      Podcast(
        "NFR-Podcast.jpg",
        "NFR Podcast",
      ),
      Podcast(
        "Modern-Wisdom.jpg",
        "Modern Wisdom",
      ),
      Podcast(
        "Huberman-Lab.jpg",
        "Huberman Lab",
      ),
      Podcast(
        "Fresh&Fit.jpg",
        "Fresh&Fit Podcast",
      ),
      Podcast(
        "Distractible.jpg",
        "Distractible",
      ),
      Podcast(
        "JordanB.Peterson-Podcast.jpg",
        "The Jordan B. Peterson Podcast",
      ),
      Podcast(
        "American-English.jpg",
        "American English Podcast",
      ),
      Podcast(
        "Comedy-is-joke.jpg",
        "COMEDY IS JOKE",
      ),
      Podcast(
        "Bad-Friends.jpg",
        "Bad Friends Podcast",
      ),
      Podcast(
        "HotBoxIn.jpg",
        "Hotboxin",
      ),
    ];
  }

  @override
  Future<String> getSongUrl(String fileName) async {
    // Không cần thiết cho LocalDatasource
    return '';
  }

  @override
  Future<String> getPodcastImageUrl(String imageName) async {
    return '';
  }
}
