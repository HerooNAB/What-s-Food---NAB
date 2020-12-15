import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';
import 'package:what_food/main.dart';
import 'dart:math' as math;
import 'models.dart';

import 'rounded_button.dart';

import 'camera.dart';
import 'boundedbox.dart';

class HomePage extends StatefulWidget {
  final List<CameraDescription> cameras;

  HomePage(this.cameras);

  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> _recognitions;
  int _imageHeight = 0;
  int _imageWidth = 0;
  String _model = "";

  @override
  void initState() {
    super.initState();
  }

  //Đọc model đã train để nhận diện vật thể
  loadModel() async {
    String res;
    switch (_model) {
      case yolo:
        res = await Tflite.loadModel(
          model: "assets/yolov2_tiny.tflite",
          labels: "assets/yolov2_tiny.txt",
        );
        break;

      case mobilenet:
        res = await Tflite.loadModel(
            model: "assets/mobilenet_v1_1.0_224.tflite",
            labels: "assets/mobilenet_v1_1.0_224.txt");
        break;

      case detect:
        res = await Tflite.loadModel(
            model: "assets/detect.tflite", labels: "assets/labelmap.txt");
        break;

      case posenet:
        res = await Tflite.loadModel(
            model: "assets/posenet_mv1_075_float_from_checkpoints.tflite");
        break;

      default:
        res = await Tflite.loadModel(
            model: "assets/ssd_mobilenet.tflite",
            labels: "assets/ssd_mobilenet.txt");
    }
    print('Đọc model thành công');
  }

  onSelect(model) {
    setState(() {
      _model = model;
    });
    loadModel();
  }

  setRecognitions(recognitions, imageHeight, imageWidth) {
    setState(() {
      _recognitions = recognitions;
      _imageHeight = imageHeight;
      _imageWidth = imageWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          image: const DecorationImage(
            image: NetworkImage(
                'https://res.cloudinary.com/dwbo0xln4/image/upload/v1604290439/yzzez6csfg7grtefsdhd.jpg'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(15),
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
            bottomLeft: Radius.circular(15),
          ),
        ),
        child: _model == ""
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '   SELECT MODEL ',
                      style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white70),
                    ),
                    RoundedButton(
                      text: ssd,
                      press: () => onSelect(ssd),
                    ),
                    RoundedButton(
                      text: yolo,
                      press: () => onSelect(yolo),
                    ),
                    RoundedButton(
                      text: mobilenet,
                      press: () => onSelect(mobilenet),
                    ),
                    RoundedButton(
                      text: posenet,
                      press: () => onSelect(posenet),
                    ),
                    RoundedButton(
                      text: detect,
                      press: () => onSelect(detect),
                    ),
                  ],
                ),
              )
            : Stack(
                children: [
                  Camera(
                    widget.cameras,
                    _model,
                    setRecognitions,
                  ),
                  BndBox(
                      _recognitions == null ? [] : _recognitions,
                      math.max(_imageHeight, _imageWidth),
                      math.min(_imageHeight, _imageWidth),
                      screen.height,
                      screen.width,
                      _model),
                ],
              ),
      ),
    );
  }
}
