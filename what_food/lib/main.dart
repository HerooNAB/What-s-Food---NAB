import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:what_food/Screens/Welcome/welcome_screen.dart';

List<CameraDescription> cameras;

Future<Null> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomeScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        /*LoginPage.id: (context) => LoginPage(),
        SignupPage.id: (context) => SignupPage(),
        Homepage.id: (context) => Homepage(),
        Profile.id: (context) => Profile(),*/
      },
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
