import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travel_application/components/app_bar.dart';
import 'package:travel_application/services/firebase_crud.dart';

class ShowBLog extends StatefulWidget {
  final String blogId;

  ShowBLog({this.blogId});
  @override
  _ShowBLogState createState() => _ShowBLogState();
}

class _ShowBLogState extends State<ShowBLog> {
  CrudMethods crudMethods = CrudMethods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(""),
      body: Stack(
        children: <Widget>[
          FutureBuilder(
            future: crudMethods.blogRef.doc(widget.blogId).get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error : ,${snapshot.error}"),
                  ),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                //firebase document data of map
                Map<String, dynamic> documentData = snapshot.data.data();

                //from map retrive image data into list

                return Container(
                  margin: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                  child: ListView(
                    children: [
                      Container(
                        height: 300,
                        decoration: BoxDecoration(
                            color: Colors.black45.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Stack(
                            children: [
                              Container(
                                child: Image.network(
                                  snapshot.data.data()['imgURL'],
                                  height: 300,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Container(
                              width: 380,
                              child: Text("${snapshot.data.data()['title']}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 10),
                        child: Row(
                          children: [
                            Container(
                              child: Text(
                                "Author Name: " +
                                    "${snapshot.data.data()['authorName']}",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                            ),
                            Spacer(),
                            Container(
                              child: Text(
                                "Date: " + "${snapshot.data.data()['date']}",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 15),
                        child: Text(
                          "${snapshot.data.data()['description']}",
                          style: TextStyle(),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(vertical: 25),
                      ),
                    ],
                  ),
                );
              }
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
