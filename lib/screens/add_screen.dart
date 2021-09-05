import 'package:flutter/material.dart';
import 'package:flutter_sqllite/database/sql_helper.dart';
class AddScreen extends StatefulWidget {
  const AddScreen({Key key}) : super(key: key);

  @override
  _AddScreenState createState() => _AddScreenState();
}
class _AddScreenState extends State<AddScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController desController = TextEditingController();
  bool _titleValidate = false;
  bool _desValidate = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todo Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListView(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                  hintText: "Title",
                errorText: _titleValidate ? 'Title Can\'t Be Empty' : null,
              ),
            ),
            TextField(
              controller: desController,
              decoration: InputDecoration(
                  hintText: "Description",
                errorText: _desValidate ? 'Description Can\'t Be Empty' : null,
              ),
            ),

            TextButton(onPressed: () async{
              setState(() {
                titleController.text.isEmpty ? _titleValidate = true : _titleValidate = false;
                titleController.text.isEmpty ? _desValidate = true : _desValidate = false;
              });
              final title = titleController.text;
              final des = desController.text;
              if(title.isNotEmpty && des.isNotEmpty){
                await SQLHelper.createItem(title, des);
                 showAlertDialog(context);
                clearForm();
              }
            }, child: Text("Save")),
          ],
        ),
      ),
    );
  }

  void clearForm(){
    titleController.text = '';
    desController.text = '';
  }

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

}
