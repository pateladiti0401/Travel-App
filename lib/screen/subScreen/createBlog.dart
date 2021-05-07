import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

import 'package:travel_application/components/app_bar.dart';
import 'package:travel_application/constants.dart';
import 'package:travel_application/services/firebase_crud.dart';

class CreateBlog extends StatefulWidget {
  CreateBlog({Key key}) : super(key: key);

  @override
  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  CrudMethods crudMethods = new CrudMethods();

  String authorName, title, description, currentDate, time;
  final dateController = TextEditingController();

  final picker = ImagePicker();
  File selectedImage;
  bool _isLoading = false;

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  //function for uploading blog on click methods
  uploadBlog() async {
    var dateKey = new DateTime.now();
    var formatDate = new DateFormat('MMM d, yyyy');
    var formatTime = new DateFormat('EEEE, hh:mm aaa');

    //passing formated values into cuurent date and time string
    currentDate = formatDate.format(dateKey);
    time = formatTime.format(dateKey);

    if (selectedImage != null) {
      setState(() {
        _isLoading = true;
      });
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference firebaseStorageRef = storage
          .ref()
          .child("blogImages")
          .child("${randomAlphaNumeric(9)}.jpg");

      final UploadTask task = firebaseStorageRef.putFile(selectedImage);
      var downloadUrl = await (await task).ref.getDownloadURL();

      String url = downloadUrl.toString();

      print("this is doenload URL $url");

      Map<String, String> blogMap = {
        "imgURL": url,
        "authorName": authorName,
        "title": title,
        "description": description,
        "date": currentDate.toString(),
        "time": time
      };
      crudMethods.addData(blogMap).then((result) {
        Navigator.pop(context);
      });
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar("Crate Blog"),
      body: _isLoading
          ? Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : Container(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    // CustomAppBar(
                    //   title: "Create Blog",
                    //   hasBackArrow: true,
                    // ),
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        getImage();
                      },
                      child: selectedImage != null
                          ? Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              height: 180,
                              width: MediaQuery.of(context).size.width,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.file(
                                  selectedImage,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          : Container(
                              margin: EdgeInsets.symmetric(horizontal: 16),
                              height: 180,
                              width: MediaQuery.of(context).size.width,
                              child: Icon(
                                Icons.add_a_photo,
                                color: Colors.white,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black12,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        children: <Widget>[
                          TextField(
                            decoration:
                                InputDecoration(hintText: "Author Name"),
                            onChanged: (val) {
                              authorName = val;
                            },
                          ),
                          TextField(
                            decoration: InputDecoration(hintText: "Title"),
                            onChanged: (val) {
                              title = val;
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            minLines: 8,
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              hintText: "Enter something here...",
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                              ),
                            ),
                            onChanged: (val) {
                              description = val;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: RaisedButton.icon(
                        padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
                        onPressed: () {
                          uploadBlog();
                        },
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        color: Color(0xff007580),
                        label: Text(
                          "Upload",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Colors.white),
                        ),
                        icon: Icon(
                          Icons.file_upload,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
