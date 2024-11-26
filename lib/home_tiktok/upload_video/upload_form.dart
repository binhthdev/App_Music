import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spotify_clone/home_tiktok/upload_video/upload_controller.dart';
import 'package:simple_circular_progress_bar/simple_circular_progress_bar.dart';
import 'package:spotify_clone/home_tiktok/global.dart';
import 'package:video_player/video_player.dart';

import '../../widgets/input_text_widget.dart';


class UploadForm extends StatefulWidget
{
  final File videoFile;
  final String videoPath;

  UploadForm({required this.videoFile, required this.videoPath});

  @override
  State<UploadForm> createState() => _UploadFormState();
}

class _UploadFormState extends State<UploadForm>
{
  UploadController uploadVideoController = Get.put(UploadController());
  VideoPlayerController? playerController;
  TextEditingController artistSongTextEditingController = TextEditingController();
  TextEditingController descriptionTagsTextEditingController = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    setState(() {
      playerController = VideoPlayerController.file(widget.videoFile);
    });

    playerController!.initialize();
    playerController!.play();
    playerController!.setVolume(2);
    playerController!.setLooping(true);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();

    playerController!.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [

            //display video player
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.3,
              child: VideoPlayer(playerController!),
            ),

            const SizedBox(
              height: 30,
            ),

            showProgressBar == true
                ? Container(
              child: const SimpleCircularProgressBar(
                progressColors: [
                  Colors.green,
                  Colors.blueAccent,
                  Colors.red,
                  Colors.amber,
                  Colors.purpleAccent,
                ],
                animationDuration: 20,
                backColor: Colors.white38,
              ),
            )
                :Column(
              children: [

                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputWidget(
                    textEditingController: artistSongTextEditingController,
                    labelString:"Artist - Song",
                    iconData: Icons.music_video_sharp,
                    isObsure: false,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputWidget(
                    textEditingController: descriptionTagsTextEditingController,
                    labelString:"Description - Tags",
                    iconData: Icons.slideshow_sharp,
                    isObsure: false,
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),

                Container(
                  width: MediaQuery.of(context).size.width - 38,
                  height: 54,
                  decoration: const BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: InkWell(
                    onTap:()
                    {
                      if(artistSongTextEditingController.text.isNotEmpty
                         && descriptionTagsTextEditingController.text.isNotEmpty)
                      {
                          uploadVideoController.saveVideoInformationToFirestoreDatabase(
                              artistSongTextEditingController.text,
                              descriptionTagsTextEditingController.text,
                              widget.videoPath,
                              context
                          );
                          setState(() {
                            showProgressBar = true;
                          });
                      }
                    },
                    child: const Center(
                      child: Text(
                        "Upload Now",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
              ],
            ),

          ],
        ),
      ),
    );
  }
}
