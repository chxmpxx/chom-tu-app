import 'dart:io';

import 'package:chom_tu/constants/themes/colors.dart';
import 'package:chom_tu/features/wardrobe/providers/wardrobe_controller.dart';
import 'package:chom_tu/features/wardrobe/providers/wardrobe_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:camera/camera.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

List<CameraDescription>? cameras;

class WardrobeCameraScreen extends StatefulWidget {
  const WardrobeCameraScreen({Key? key}) : super(key: key);

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

    var wardrobeProvider = Provider.of<WardrobeProvider>(context, listen: false);

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
      bottomNavigationBar: cameraNavigationBar(context, wardrobeProvider),
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
                SvgPicture.asset('assets/icons/b2_gallery_1.svg', color: kColorsWhite),
                const SizedBox(height: 5),
                Text('Gallery', style: Theme.of(context).textTheme.bodyText2),
              ],
            ),
          ),
          InkWell(
            onTap: (){
              takePhoto(context, wardrobeProvider);
            },
            child: SvgPicture.asset('assets/icons/b2_shot_1.svg', color: kColorsWhite)
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
                flash ? SvgPicture.asset('assets/icons/b2_flash_2.svg', color: kColorsWhite) : SvgPicture.asset('assets/icons/b2_flash_1.svg', color: kColorsWhite),
                const SizedBox(height: 5),
                Text('Flash', style: Theme.of(context).textTheme.bodyText2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void openGallery(BuildContext context, WardrobeProvider wardrobeProvider) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if(pickedFile != null) {
      Map<String, dynamic> data = await WardrobeController().wardrobeDetection(pickedFile.path);
      setWardrobeData(wardrobeProvider, pickedFile.path, data);
      setState(() {
        wardrobeProvider.setPath(pickedFile.path);
        wardrobeProvider.isGallery = true;
        
        Navigator.pushNamed(context, '/wardrobe_edit_info');
      });
    } else {
      print('No Image selected');
      Navigator.pushNamed(context, '/wardrobe_camera');
    }
  }

  void takePhoto(context, WardrobeProvider wardrobeProvider) async {
    final path = join((await getTemporaryDirectory()).path, "${DateTime.now()}.png");
    XFile picture = await _cameraController!.takePicture();
    picture.saveTo(path);

    await WardrobeController().wardrobeDetection(path);
    Map<String, dynamic> data = await WardrobeController().wardrobeDetection(path);
    setWardrobeData(wardrobeProvider, path, data);

    wardrobeProvider.setPath(path);
    wardrobeProvider.isGallery = false;
    Navigator.pushNamed(context, '/wardrobe_edit_info');
    // Navigator.push(context, MaterialPageRoute(builder: (_) => WardrobeCameraEditScreen()));
  }

  void setWardrobeData(WardrobeProvider wardrobeProvider, path, Map<String, dynamic> data) {
    wardrobeProvider.setData('Category', data['category']);
    wardrobeProvider.setData('Sub Category', data['subCategory']);
    wardrobeProvider.setData('Color', data['color']);
    wardrobeProvider.setData('Type', data['type']);
  }

}