import 'dart:io';

import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/profile/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

List<CameraDescription>? cameras;

class ProfileCameraScreen extends StatefulWidget {
  const ProfileCameraScreen({Key? key}) : super(key: key);

  @override
  State<ProfileCameraScreen> createState() => _ProfileCameraScreenState();
}

class _ProfileCameraScreenState extends State<ProfileCameraScreen> {

  File? imageFile;
  final picker = ImagePicker();
  bool flash = false;
  bool frontCam = false;
  
  CameraController? _cameraController;
  Future<void>? cameraValue;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
    if (cameras!.isEmpty) {
      throw CameraException("No cameras available.", "camera_unavailable");
    }
    _cameraController = CameraController(cameras![0], ResolutionPreset.high);
    cameraValue = _cameraController!.initialize();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: kColorsBlack,
      appBar: AppBar(
        backgroundColor: kColorsBlack,
        elevation: 0,
        toolbarHeight: 60,
        leading: IconButton(
          icon: SvgPicture.asset('assets/icons/o3_back_1.svg', color: kColorsWhite),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                frontCam = !frontCam;
              });
              int cameraPos = frontCam ? 0 : 1;
              _cameraController = CameraController(cameras![cameraPos], ResolutionPreset.high);
              cameraValue = _cameraController!.initialize();
            },
            icon: SvgPicture.asset('assets/icons/a4_switch_1.svg', color: kColorsWhite)
          ),
        ],
      ),
      bottomNavigationBar: cameraNavigationBar(context),
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: FutureBuilder(
            future: cameraValue,
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_cameraController!);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
          ),
        ),
      )
    );
  }

  Widget cameraNavigationBar(context) {
    return Container(
      height: 75,
      width: MediaQuery.of(context).size.width,
      color: kColorsBlack,
      child: Center(
        child: InkWell(
          onTap: (){
            takePhoto(context);
          },
          child: SvgPicture.asset('assets/icons/b2_shot_1.svg', color: kColorsWhite)
        ),
      )
    );
  }

  void takePhoto(context) async {
    var profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    final path = join((await getTemporaryDirectory()).path, "${DateTime.now()}.png");
    XFile picture = await _cameraController!.takePicture();
    picture.saveTo(path);

    profileProvider.setProfileImg(path);
    Navigator.pop(context);
  }
}