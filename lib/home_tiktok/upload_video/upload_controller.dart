import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/home_tiktok/global.dart';
import 'package:spotify_clone/home_tiktok/home_screen.dart';
import 'package:spotify_clone/home_tiktok/upload_video/video.dart';
import 'package:video_compress/video_compress.dart';


class UploadController extends GetxController
{
  compressVideoFile(String videoFilePath) async
  {
    final compressedVideoFilePath = await VideoCompress.compressVideo(videoFilePath, quality: VideoQuality.LowQuality);

    return compressedVideoFilePath!.file;
  }
// xu li up load video firebase
  uploadCompressedvideoFileToFirebasetorage(String videoID, String videoFilePath) async
  {
    UploadTask videoUploadTask = FirebaseStorage.instance.ref()
        .child("All Videos")
        .child(videoID)
        .putFile(await compressVideoFile(videoFilePath));

    TaskSnapshot snapshot = await videoUploadTask;

   String downloadUrlOfUploadedVideo = await snapshot.ref.getDownloadURL(); // url tai xuong cac video da tai len

   return downloadUrlOfUploadedVideo;
  }

  getThumbnailImage(String videoFilePath) async
  {
    final thumbnailImages= await VideoCompress.getFileThumbnail(videoFilePath);

    return thumbnailImages;
  }
  uploadThumbnailImageToFirebaseStorage(String videoID, String videoFilePath) async
  {
    UploadTask thumbnailUploadTask = FirebaseStorage.instance.ref()
        .child("All thumbnails")
        .child(videoID)
        .putFile(await getThumbnailImage(videoFilePath));

    TaskSnapshot snapshot = await thumbnailUploadTask;

    String downloadUrlOfUploadedThumbnail = await snapshot.ref.getDownloadURL();

    return downloadUrlOfUploadedThumbnail;
  }
  saveVideoInformationToFirestoreDatabase(String artistSongName, String descriptionTags,String videoFilePath,BuildContext context) async
  {
    try
    {
      DocumentSnapshot userDocumentSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser?.uid )
          .get();
       String videoID = DateTime.now().microsecondsSinceEpoch.toString();

       // Up load video Storage
   String videoDownloadUrl = await uploadCompressedvideoFileToFirebasetorage(videoID, videoFilePath);

       // upload thumbnail to storage
      String thumbnailDownloadUrl = await uploadThumbnailImageToFirebaseStorage(videoID, videoFilePath);
       // save overall video info to firestore database
      Video videoObject = Video(
        userID: FirebaseAuth.instance.currentUser?.uid,
        userName: "Binh",
        videoID: videoID,
        totalComments: 0,
        totalShares: 0,
        likesList: [],
        artistSongName: artistSongName,
        descriptionTags: descriptionTags,
        videoUrl: videoDownloadUrl,
        thumbnailUrl: thumbnailDownloadUrl,
        publishedDateTime: DateTime.now().millisecondsSinceEpoch,
      );

      await FirebaseFirestore.instance.collection("videos").doc(videoID).set(videoObject.toJson());
      showProgressBar = false;
      Get.to(const HomeScreen());
      
      Get.snackbar("new Video", "You have successfully. Uploaded your new video ");

    }
    catch(errorMsg)
    {
      debugPrint(errorMsg.toString());
      Get.snackbar("Video Upload Unsuccessfull","Error occurred, your video is not upload, Try Again.");
    }
  }
}