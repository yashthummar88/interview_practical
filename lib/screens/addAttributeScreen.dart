import 'package:flutter/material.dart';
import 'package:practical_task_interview/helper/db_helper.dart';
import 'package:practical_task_interview/models/attribute_model.dart';

class AddAttributeScreen extends StatefulWidget {
  static const route = 'addAttribute';

  @override
  _AddAttributeScreenState createState() => _AddAttributeScreenState();
}

class _AddAttributeScreenState extends State<AddAttributeScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _atribute = TextEditingController();
  late Future fetchAttribute;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchAttribute = dbh.getAllAttribute();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Attribute"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openForm();
        },
        child: Icon(Icons.add),
      ),
      body: SafeArea(
        child: Container(
          child: FutureBuilder(
            future: fetchAttribute,
            builder: (context, AsyncSnapshot ss) {
              if (ss.hasError) {
                return Center(
                  child: Text("ERROR: ${ss.error}"),
                );
              } else {
                if (ss.hasData) {
                  print("helo");
                  List<Attribute> data = ss.data;
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        leading: Text("${data[i].id}"),
                        title: Text("${data[i].attribute}"),
                        trailing: IconButton(
                          onPressed: () async {
                            await dbh.deleteProduct(data[i].id);
                            setState(() {
                              fetchAttribute = dbh.getAllAttribute();
                            });
                          },
                          icon: Icon(Icons.delete),
                        ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }
            },
          ),
        ),
      ),
    );
  }

  openForm() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Add Attribute"),
            content: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter Attribute .....";
                      }
                      return null;
                    },
                    controller: _atribute,
                    decoration: InputDecoration(
                      hintText: "Enter Attribute",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              OutlinedButton(
                onPressed: () {
                  _atribute.clear();
                  Navigator.of(context).pop();
                },
                child: Text("cancel"),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    int number = await dbh.insertData(
                      s: Attribute(
                        attribute: _atribute.text,
                      ),
                    );
                    _atribute.clear();
                    refreshData();
                    Navigator.of(context).pop();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Data inserted at Id: $number"),
                      ),
                    );
                  }
                },
                child: Text("Add"),
              ),
            ],
          );
        });
  }

  refreshData() {
    setState(() {
      fetchAttribute = dbh.getAllAttribute();
    });
  }
}
