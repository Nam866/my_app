import 'package:flutter/material.dart';
import 'package:my_app/db/model.dart';
import 'package:my_app/db/database.dart';
import 'package:my_app/views/detail_view.dart';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appTitle = 'My Note';
    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: BuildBody(),
      ),
    );
  }
}

class BuildBody extends StatefulWidget {
  @override
  _BuildBodyState createState() => _BuildBodyState();
}

class _BuildBodyState extends State<BuildBody> {
  DatabaseHelper databaseHelper = DatabaseHelper();

  Future<List<ListModel>> listItems;
  List<ListModel> noteListmain = List<ListModel>();

  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    refreshDataList();
  }

  refreshDataList() {
    setState(() {
      getAllData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(20),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(
                  flex: 4,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Text("Tiêu đề :"),
                        Flexible(
                          child: TextField(
                            controller: titleController,
                          ),
                        ),
                        RaisedButton(
                          child: Text("Thêm"),
                          onPressed: () {
                            setState(() {
                              insertData();
                              FocusScope.of(context).unfocus();
                            });
                          },
                        )
                      ],
                    ),
                  )),
              Flexible(
                  flex: 9,
                  child: ListView.builder(
                      itemCount: noteListmain.length,
                      itemBuilder: (BuildContext context, int position) {
                        return InkWell(
                          child: Card(
                            color: Colors.white,
                            elevation: 2.0,
                            child: ListTile(
                              leading: CircleAvatar(
                                backgroundColor: Colors.black,
                                child: Icon(Icons.assessment),
                              ),
                              title: Text(
                                this.noteListmain[position].title,
                              ),
                              trailing: GestureDetector(
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.grey,
                                ),
                                onTap: () {
                                  deleteData(this.noteListmain[position].id);
                                },
                              ),
                            ),
                          ),
                          onTap: () {
                            updateData(this.noteListmain[position].id,
                                this.noteListmain[position].title);
                          },
                        );
                      }))
            ]));
  }

  void insertData() async {
    int result;
    String title = titleController.text;
    result = await databaseHelper.insertData(ListModel(title));
    print('inserted row id: $result');
    titleController.text = '';
    refreshDataList();
  }

  void getAllData() async {
    final noteMapList = await databaseHelper.getDbData();
    setState(() {
      noteListmain = noteMapList;
    });
  }

  void updateData(int id, String title) async {
    bool result =
        await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return DetailsPage(id, title);
    }));
    if (result == true) {
      refreshDataList();
    }
  }

  void deleteData(int itemId) async {
    int result = await databaseHelper.deleteData(itemId);
    refreshDataList();
  }
}
