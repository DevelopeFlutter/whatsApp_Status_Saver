// ignore_for_file: unrelated_type_equality_checks
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:video_player/video_player.dart';
import 'video_play_controller.dart';
class PlayStatus extends StatefulWidget {
  final String videoFile;
  const PlayStatus({
    Key? key,
    required this.videoFile,
  }) : super(key: key);
  @override
  _PlayStatusState createState() => _PlayStatusState();
}
class _PlayStatusState extends State<PlayStatus> {
  void _onLoading(bool t, String str) {
    if (t) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return SimpleDialog(
              children: <Widget>[
                Center(
                  child: Container(
                      padding: const EdgeInsets.all(10.0),
                      child: const CircularProgressIndicator()),
                ),
              ],
            );
          });
    } else {
      Navigator.pop(context);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: SimpleDialog(
                children: <Widget>[
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: <Widget>[
                          const Text(
                            'Great, Saved in Gallery',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                          ),
                          Text(str,
                              style: const TextStyle(
                                fontSize: 16.0,
                              )),
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                          ),
                          const Text('FileManager > wa_status_saver',
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.teal)),
                          const Padding(
                            padding: EdgeInsets.all(10.0),
                          ),
                          MaterialButton(
                            color: Colors.teal,
                            textColor: Colors.white,
                            onPressed: () => Navigator.pop(context),
                            child: const Text('Close'),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
    }
  }
  @override
  void initState(){
    recallMemory();
    super.initState();
  }
  recallMemory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    getvalue = prefs.getStringList('videopath')!;
  }
  List videos = [];
  void saveToGallery() async {
    print('Video Saved in Gallery');
    await GallerySaver.saveVideo(widget.videoFile);
  }
  var  getvalue = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          color: Colors.white,
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: StatusVideo(
        videoPlayerController:
        VideoPlayerController.file(File(widget.videoFile)),
        looping: true,
        videoSrc: widget.videoFile,
      ),
      // ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.teal,
          child: const  Icon(Icons.save),
          onPressed: ()async{
            SharedPreferences prefs = await SharedPreferences.getInstance();
            final originalVideoFile = File(widget.videoFile);
            List<String> newList = [];
            newList.add(originalVideoFile.path);
            prefs.setStringList('videopath',newList);
            if(getvalue.toString().contains(originalVideoFile.path)){
              print('nothing');
            }
            else {
              saveToGallery();
              setState(() {
                 getvalue = prefs.getStringList('videopath')!;
              });
            }

            // _onLoading(true, '');
            // final originalVideoFile = File(widget.videoFile);
            // if (!Directory('/storage/emulated/0/wa_status_saver')
            //     .existsSync()) {
            //   Directory('/storage/emulated/0/wa_status_saver')
            //       .createSync(recursive: true);
            // }
            // // final path = directory.path;
            // final curDate = DateTime.now().toString();
            // final newFileName =
            //     '/storage/emulated/0/wa_status_saver/VIDEO-$curDate.mp4';
            // await originalVideoFile.copy(newFileName);
            // _onLoading(
            //   false,
            //   'If Video not available in gallery\n\nYou can find all videos at',
            // );
            //
          }),
    );
  }
}
