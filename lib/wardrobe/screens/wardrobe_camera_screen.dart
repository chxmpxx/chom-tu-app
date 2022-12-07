import 'dart:io';

import 'package:chom_tu/configs/themes/colors.dart';
import 'package:chom_tu/wardrobe/providers/wardrobe_image_provider.dart';
import 'package:chom_tu/wardrobe/screens/wardrobe_camera_edit_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

List<CameraDescription>? cameras;

class WardrobeCameraScreen extends StatefulWidget {
  WardrobeCameraScreen({Key? key}) : super(key: key);

  @override
  State<WardrobeCameraScreen> createState() => _WardrobeCameraScreenState();
}

class _WardrobeCameraScreenState extends State<WardrobeCameraScreen> {

  File? imageFile;
  final picker = ImagePicker();
  bool flash = false;
  bool frontCam = true;
  
  CameraController? _cameraController;
  Future<void>? cameraValue;

  @override
  void initState() {
    super.initState();
    _cameraController = CameraController(cameras![0], ResolutionPreset.high);
    cameraValue = _cameraController!.initialize();
  }

  @override
  Widget build(BuildContext context) {

    var wardrobeProvider = Provider.of<WardrobeImageProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: kColorsBlack,
      appBar: AppBar(
        backgroundColor: kColorsBlack,
        elevation: 0,
        toolbarHeight: 60,
        leading: IconButton(
          icon: SvgPicture.asset('assets/o3_back_1.svg', color: kColorsWhite),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            onPressed: () async {
              setState(() {
                frontCam = !frontCam;
              });
              int cameraPos = frontCam ? 0 : 1;
              _cameraController = CameraController(cameras![cameraPos], ResolutionPreset.high);
              cameraValue = _cameraController!.initialize();
            },
            icon: SvgPicture.asset('assets/a4_switch_1.svg', color: kColorsWhite)
          ),
        ],
      ),
      bottomNavigationBar: cameraNavigationBar(context, wardrobeProvider),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width,
          child: FutureBuilder(
            future: cameraValue,
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.done) {
                return CameraPreview(_cameraController!);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }
          ),
        ),
      )
    );
  }

  Widget cameraNavigationBar(context, wardrobeProvider) {
    return Container(
      height: 75,
      width: MediaQuery.of(context).size.width,
      color: kColorsBlack,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          InkWell(
            onTap: (){
              openGallery(context, wardrobeProvider);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset('assets/b2_gallery_1.svg', color: kColorsWhite),
                SizedBox(height: 5),
                Text('Gallery', style: Theme.of(context).textTheme.bodyText2),
              ],
            ),
          ),
          InkWell(
            onTap: (){
              takePhoto(context, wardrobeProvider);
            },
            child: SvgPicture.asset('assets/b2_shot_1.svg', color: kColorsWhite)
          ),
          InkWell(
            onTap: (){
              setState(() {
                flash = !flash;
              });
              flash ? _cameraController!.setFlashMode(FlashMode.torch) : _cameraController!.setFlashMode(FlashMode.off);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                flash ? SvgPicture.asset('assets/b2_flash_2.svg', color: kColorsWhite) : SvgPicture.asset('assets/b2_flash_1.svg', color: kColorsWhite),
                SizedBox(height: 5),
                Text('Flash', style: Theme.of(context).textTheme.bodyText2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void openGallery(BuildContext context, wardrobeProvider) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if(pickedFile != null) {
        wardrobeProvider.setPath(pickedFile.path);
        wardrobeProvider.isGallery = true;
        Navigator.push(context, MaterialPageRoute(builder: (_) => WardrobeCameraEditScreen()));
      } else {
        print('No Image selected');
        Navigator.pushNamed(context, '/wardrobe_camera');
      }
    });
  }

  void takePhoto(context, wardrobeProvider) async {
    final path = join((await getTemporaryDirectory()).path, "${DateTime.now()}.png");
    XFile picture = await _cameraController!.takePicture();
    picture.saveTo(path);

    wardrobeProvider.setPath(path);
    wardrobeProvider.isGallery = false;
    Navigator.push(context, MaterialPageRoute(builder: (_) => WardrobeCameraEditScreen()));
  }

}