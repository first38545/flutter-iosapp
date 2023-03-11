import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'my_model.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart' as path_provider;

class PageB extends StatefulWidget {
  const PageB({Key? key}) : super(key: key);

  @override
  _PageBState createState() => _PageBState();
}

class _PageBState extends State<PageB> {
  final _nameController = TextEditingController();
  final _itemController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late Box<MyModel> _myBox;
  List<Item> items = [];
  late File _image;
  late final ImagePicker _picker;
  bool _hasImage = false;

  @override
  void initState() {
    super.initState();
    _myBox = Hive.box<MyModel>('myBox');
    _picker = ImagePicker();
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _hasImage = true;
      });
    }
  }

  Future<String?> _saveImage() async {
    if (!_hasImage) {
      return null;
    }

    final appDir = await path_provider.getApplicationDocumentsDirectory();
    final fileName = path.basename(_image.path);
    final savedImage = await _image.copy('${appDir.path}/$fileName');
    return savedImage.path;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _itemController.dispose();
    super.dispose();
  }

  void _addItem() {
    final name = _nameController.text;
    if (name.isNotEmpty && items.length != 0) {
      final myModel = MyModel(name: name, items: items);
      myModel.items.addAll(items);
      _myBox.add(myModel);
      _nameController.clear();

      FocusScope.of(context).unfocus();
      Navigator.of(context).pop();
    }
  }

  void _saveItem() async {
    final itemName = _itemController.text;
    final imagePath = await _saveImage();
    if (itemName.isNotEmpty && imagePath != null) {
      final newItem = Item(name: itemName, imagePath: imagePath);
      items.add(newItem);
      _itemController.clear();
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFF0DA90), Color(0xFF96A87C)])),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            // appBar: AppBar(
            //   leading: BackButton(
            //     color: Color(0xFF92B4E7),
            //     onPressed: () => Navigator.of(context).pop(),
            //   ),
            //   title: const Text('Page B'),
            //   centerTitle: true,
            // ),
            body: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF86AC91),
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 15,
                          offset: Offset(2, 4), // Shadow position
                        ),
                      ],
                    ),
                    height: 960,
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(children: [
                        Text(
                          "Name",
                          style: TextStyle(
                            fontFamily: 'Apple Berry',
                            fontSize: 40,
                          ),
                        ),
                        TextField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Color(0xFFF2E1AC),
                          ),
                          style: TextStyle(
                            fontFamily: 'Apple Berry',
                            fontSize: 40,
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFFF2E1AC),
                            onPrimary: Colors.black,
                          ),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    backgroundColor: Color(0xFF86AC91),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40))),
                                    content: Stack(
                                      children: <Widget>[
                                        Positioned(
                                          right: -40.0,
                                          top: -40.0,
                                          child: InkResponse(
                                            onTap: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: CircleAvatar(
                                              child: Icon(Icons.close),
                                              backgroundColor: Colors.red,
                                            ),
                                          ),
                                        ),
                                        Form(
                                          key: _formKey,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              Text(
                                                "Fruit Name",
                                                style: TextStyle(
                                                  fontFamily: 'Apple Berry',
                                                  fontSize: 40,
                                                ),
                                              ),
                                              TextField(
                                                controller: _itemController,
                                                decoration:
                                                    const InputDecoration(
                                                  filled: true,
                                                  fillColor: Color(0xFFF2E1AC),
                                                ),
                                                style: TextStyle(
                                                  fontFamily: 'Apple Berry',
                                                  fontSize: 35,
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  final pickedFile =
                                                      await _picker.getImage(
                                                          source: ImageSource
                                                              .gallery);
                                                  if (pickedFile != null) {
                                                    final imageFile =
                                                        File(pickedFile.path);
                                                    setState(() {
                                                      _image = imageFile;
                                                    });
                                                  }
                                                },
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(Icons
                                                        .add_photo_alternate),
                                                    SizedBox(width: 8.0),
                                                    Text("Upload Image"),
                                                  ],
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    primary: Color(0xFFF2E1AC),
                                                    onPrimary: Colors.black,
                                                  ),
                                                  child: Text(
                                                    "Submit",
                                                    style: TextStyle(
                                                      fontFamily: 'Apple Berry',
                                                      fontSize: 30,
                                                    ),
                                                  ),
                                                  onPressed: _saveItem,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: const Text(
                            'Add item',
                            style: TextStyle(
                              fontFamily: 'Apple Berry',
                              fontSize: 35,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        Expanded(
                          child: ValueListenableBuilder<Box<MyModel>>(
                            valueListenable:
                                Hive.box<MyModel>('myBox').listenable(),
                            builder: (context, box, _) {
                              return ListView.builder(
                                itemCount: items.length,
                                itemBuilder: (context, index) {
                                  return Card(
                                    color: Color(0xFFF2E1AC),
                                    child: ListTile(
                                      title: Text(
                                        items[index].name,
                                        style: TextStyle(
                                          fontFamily: 'Apple Berry',
                                          fontSize: 30,
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Color(0xFFF2E1AC),
                            onPrimary: Colors.black,
                          ),
                          child: Text(
                            "Save",
                            style: TextStyle(
                              fontFamily: 'Apple Berry',
                              fontSize: 35,
                            ),
                          ),
                          onPressed: _addItem,
                        )
                      ]),
                    ),
                  ),
                ],
              ),
            ),
            resizeToAvoidBottomInset: false));
  }
}
