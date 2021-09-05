import 'package:flutter/material.dart';
import 'package:flutter_sqllite/database/sql_helper.dart';

class EditScreen extends StatefulWidget {
  final String title;
  final String des;
  final int id;
  EditScreen({this.title, this.des, this.id});

  @override
  _EditScreenState createState() => _EditScreenState(id: id,title: title,description: des);
}

class _EditScreenState extends State<EditScreen> {
  _EditScreenState({this.title, this.description, this.id});
  final TextEditingController titleController = TextEditingController();
  final TextEditingController desController = TextEditingController();
  final String title;
  final String description;
  final int id;


  //to notify user when item update successfully.
  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Message"),
      content: Text("Created item successfully."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  @override
  void initState() {
    this.titleController.text = title;
    this.desController.text = description;

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Title",
              ),
            ),
            TextField(
              controller: desController,
              decoration: InputDecoration(
                hintText: "Description",
              ),
            ),
            TextButton(
                onPressed: () async {
                  final title = titleController.text;
                  final des = desController.text;
                  SQLHelper.updateItem(id, title, des);
                  showAlertDialog(context);

                },
                child: Text("Edit")),
          ],
        ),
      ),
    );
  }
}
