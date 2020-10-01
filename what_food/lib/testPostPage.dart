// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';

// import 'Models/UserData.dart';
// import 'Models/post.dart';
// import 'Services/PostsService.dart';

// class CreatePostScreen extends StatefulWidget {
//   @override
//   _CreatePostScreenState createState() => _CreatePostScreenState();
// }

// class _CreatePostScreenState extends State<CreatePostScreen> {
//   File _image;
//   TextEditingController _captionController = TextEditingController();

//   String _caption = '';

//   bool _isLoading = false;

//   /*_showSelectImageDialog() {
//     return Platform.isIOS ? _androidDialog() :_iosBottomSheet();
//   }*/

//   _iosBottomSheet() {
//     showCupertinoModalPopup(
//       context: context,
//       builder: (BuildContext context) {
//         return CupertinoActionSheet(
//           title: Text('Thêm ảnh'),
//           actions: <Widget>[
//             CupertinoActionSheetAction(
//               child: Text('Chụp ảnh'),
//               onPressed: () => _handleImage(ImageSource.camera),
//             ),
//             CupertinoActionSheetAction(
//               child: Text('Chọn từ thư viện'),
//               onPressed: () => _handleImage(ImageSource.gallery),
//             ),
//           ],
//           cancelButton: CupertinoActionSheetAction(
//             child: Text('Hủy'),
//             onPressed: () => Navigator.pop(context),
//           ),
//         );
//       },
//     );
//   }

//   /*_androidDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return SimpleDialog(
//           title: Text('Thêm ảnh'),
//           children: <Widget>[
//             SimpleDialogOption(
//               child: Text('Chụp ảnh'),
//               onPressed: () => _handleImage(ImageSource.camera),
//             ),
//             SimpleDialogOption(
//               child: Text('Chọn từ thư viện'),
//               onPressed: () => _handleImage(ImageSource.gallery),
//             ),
//             SimpleDialogOption(
//               child: Text(
//                 'Hủy',
//                 style: TextStyle(
//                   color: Colors.redAccent,
//                 ),
//               ),
//               onPressed: () => Navigator.pop(context),
//             ),
//           ],
//         );
//       },
//     );
//   }*/

//   _handleImage(ImageSource source) async {
//     Navigator.pop(context);
//     File imageFile = await ImagePicker.pickImage(source: source);
//     if (imageFile != null) {
//       setState(() {
//         _image = imageFile;
//       });
//     }
//   }

//   _submit() async {
//     if (!_isLoading && _image != null && _caption.isNotEmpty) {
//       setState(() {
//         _isLoading = true;
//       });

//       // Create post
//       String imageUrl = await PostsService.uploadPost(_image);
//       Post post = Post(
//         imageUrl: imageUrl,
//         caption: _caption,
//       );
//       PostsService.createPost(post);

//       // Reset data
//       _captionController.clear();

//       setState(() {
//         _caption = '';

//         _image = null;
//         _isLoading = false;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final height = MediaQuery.of(context).size.height;
//     final width = MediaQuery.of(context).size.width;
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         title: Text(
//           'Đăng Bài',
//           style: TextStyle(
//             color: Colors.black,
//           ),
//         ),
//         actions: <Widget>[
//           IconButton(
//             icon: Icon(Icons.add),
//             onPressed: _submit,
//           ),
//         ],
//       ),
//       body: GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: SingleChildScrollView(
//           child: Container(
//             height: height,
//             child: Column(
//               children: <Widget>[
//                 _isLoading
//                     ? Padding(
//                         padding: EdgeInsets.only(bottom: 10.0),
//                         child: LinearProgressIndicator(
//                           backgroundColor: Colors.blue[200],
//                           valueColor: AlwaysStoppedAnimation(Colors.blue),
//                         ),
//                       )
//                     : SizedBox.shrink(),
//                 GestureDetector(
//                   onTap: _iosBottomSheet,
//                   child: Container(
//                     height: width,
//                     width: width,
//                     color: Colors.grey[300],
//                     child: _image == null
//                         ? Icon(
//                             Icons.add_a_photo,
//                             color: Colors.white70,
//                             size: 150.0,
//                           )
//                         : Image(
//                             image: FileImage(_image),
//                             fit: BoxFit.cover,
//                           ),
//                   ),
//                 ),
//                 SizedBox(height: 20.0),
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 30.0),
//                   child: TextField(
//                     controller: _captionController,
//                     style: TextStyle(fontSize: 18.0),
//                     decoration: InputDecoration(
//                       labelText: 'Nội Dung',
//                     ),
//                     onChanged: (input) => _caption = input,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
