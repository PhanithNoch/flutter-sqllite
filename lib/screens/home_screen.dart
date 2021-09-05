import 'package:flutter/material.dart';
import 'package:flutter_sqllite/database/sql_helper.dart';
import 'package:flutter_sqllite/screens/add_screen.dart';

import 'edit_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> _journals = [];
  bool _isLoading = true;
  void _refreshJournal() async {
    final data = await SQLHelper.getItems();
    setState(() {
      _journals = data;
      _isLoading = false;
    });
  }
  @override
  void didChangeDependencies() {
    print("did change depandecies");
    super.didChangeDependencies();
  }

  void deleteItem(int id) async {
    await SQLHelper.deleteItem(id);
    _refreshJournal();
  }

  showConfirmAlertDialog(BuildContext context, int id) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Sure"),
      onPressed: () {
        deleteItem(id);
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Message"),
      content: Text("Are you sure you want to delete this item?"),
      actions: [
        cancelButton,
        continueButton,
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
    _refreshJournal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLLite'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _journals.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: EdgeInsets.all(15),
                  color: Colors.orange[200],
                  child: ListTile(
                    title: Text(_journals[index]['title']),
                    subtitle: Text(_journals[index]['description']),
                    trailing: SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                final title = _journals[index]['title'];
                                final des = _journals[index]['description'];
                                final id = _journals[index]['id'];
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditScreen(
                                            id: id, title: title, des: des)));
                              }),
                          IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                showConfirmAlertDialog(
                                    context, _journals[index]['id']);
                              })
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddScreen()));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
