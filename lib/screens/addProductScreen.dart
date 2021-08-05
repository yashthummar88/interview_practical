import 'package:flutter/material.dart';
import 'package:practical_task_interview/helper/db_helper.dart';
import 'package:practical_task_interview/helper/db_product.dart';
import 'package:practical_task_interview/models/product_model.dart';

class AddProductScreen extends StatefulWidget {
  static const route = 'addProduct';

  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  Future? allProducts;

  TextEditingController? _nameController = TextEditingController();
  TextEditingController? _typeController = TextEditingController();
  TextEditingController? _quantityController = TextEditingController();
  GlobalKey<FormState> _formkeyproduct = GlobalKey<FormState>();
  Future? fetchAttribute;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allProducts = dbproduct.getAllData();
    fetchAttribute = dbh.getAllAttribute();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Product"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: Container(
          child: FutureBuilder(
            future: fetchAttribute,
            builder: (context, AsyncSnapshot snapProducts) {
              if (snapProducts.hasError) {
                return Center(
                  child: Text(snapProducts.error.toString()),
                );
              } else if (snapProducts.connectionState ==
                  ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return FutureBuilder(
                future: allProducts,
                builder: (context, AsyncSnapshot ss) {
                  if (ss.hasError) {
                    return Center(
                      child: Text("ERROR: ${ss.error}"),
                    );
                  } else {
                    if (ss.hasData) {
                      print("helo");
                      List<Product> data = ss.data;
                      return ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, i) {
                          return ListTile(
                            leading: Text(
                              "${data[i].id}",
                              style: TextStyle(color: Colors.red),
                            ),
                            title: Text(
                              "${data[i].name}",
                              style: TextStyle(
                                color: Colors.deepPurple,
                                fontSize: 30,
                                letterSpacing: 1,
                              ),
                            ),
                            subtitle: Text(
                              "${data[i].type}",
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 18,
                                letterSpacing: 1,
                              ),
                            ),
                            trailing: Text("${data[i].quantity}"),
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
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          openForm();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  openForm() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Add Product"),
            content: Form(
              key: _formkeyproduct,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter type .....";
                      }
                      return null;
                    },
                    controller: _typeController,
                    decoration: InputDecoration(
                      hintText: "Enter Type",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter Name .....";
                      }
                      return null;
                    },
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: "Enter Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Please enter Name .....";
                      }
                      return null;
                    },
                    controller: _quantityController,
                    decoration: InputDecoration(
                      hintText: "Enter Quantity",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              OutlinedButton(
                onPressed: () {
                  _nameController!.clear();
                  _quantityController!.clear();
                  _typeController!.clear();
                  Navigator.of(context).pop();
                },
                child: Text("cancel"),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formkeyproduct.currentState!.validate()) {
                    int number = await dbproduct.addData(
                      products: Product(
                        name: _nameController?.text,
                        quantity: int.parse(_quantityController!.text),
                        type: _typeController?.text,
                      ),
                    );
                    setState(() {
                      allProducts = dbproduct.getAllData();
                    });
                    _nameController!.clear();
                    _quantityController!.clear();
                    _typeController!.clear();
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
}
