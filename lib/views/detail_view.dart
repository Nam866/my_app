import 'package:flutter/material.dart';
import 'package:my_app/db/model.dart';
import 'package:my_app/db/database.dart';

class DetailsPage extends StatefulWidget {
  final int itemId;
  final String itemTitle;
  DetailsPage(this.itemId, this.itemTitle);
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  TextEditingController newTextController = new TextEditingController();
  DatabaseHelper databaseHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    setState(() {
      newTextController.text = widget.itemTitle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Chi tiết"),
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Text("Sửa tiêu đề"),
              TextFormField(
                controller: newTextController,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton(
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,
                    child: Text(
                      'Hủy',
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context, true);
                        //insertData();
                      });
                    },
                  ),
                  RaisedButton(
                    color: Theme.of(context).primaryColorDark,
                    textColor: Theme.of(context).primaryColorLight,
                    child: Text(
                      'Lưu',
                      textScaleFactor: 1.5,
                    ),
                    onPressed: () {
                      setState(() {
                        updateItem(
                            context, widget.itemId, newTextController.text);
                      });
                    },
                  ),
                ],
              )
            ],
          ),
        ));
  }

  void updateItem(BuildContext context, int itemId, String newItem) async {
    int result =
        await databaseHelper.updateData(ListModel.withId(itemId, newItem));
    Navigator.pop(context, true);
  }
}
