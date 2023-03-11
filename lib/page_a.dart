import 'package:flutter/material.dart';
import 'page_b.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';
import 'my_model.dart';

class PageA extends StatelessWidget {
  //const PageA({super.key});

  final box = Hive.box<MyModel>('myBox');

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color(0xFF86AC91),
        body: ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: (context, Box<MyModel> box, _) {
            final elements =
                List.generate(box.length, (index) => box.getAt(index)!.name);

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < elements.length; i += 2)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: SizedBox(
                            height: 100,
                            child: Card(
                              color: Color(0xFFF2E1AC),
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: Color(0xFFECD17D), width: 8),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: InkWell(
                                onTap: () {},
                                child: Center(
                                  child: Text(
                                    elements[i].toString(),
                                    style: TextStyle(
                                      fontFamily: 'Apple Berry',
                                      fontSize: 35,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      if (i + 1 < elements.length)
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: SizedBox(
                              height: 100,
                              child: Card(
                                color: Color(0xFFF2E1AC),
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                      color: Color(0xFFECD17D), width: 8),
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                child: InkWell(
                                  onTap: () {},
                                  child: Center(
                                    child: Text(
                                      elements[i + 1].toString(),
                                      style: TextStyle(
                                        fontFamily: 'Apple Berry',
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: SizedBox(
                    height: 100,
                    width: screenWidth * 0.2,
                    child: Card(
                      color: Color(0xFFF2E1AC),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Color(0xFFECD17D), width: 8),
                        borderRadius: BorderRadius.circular(40),
                      ),
                      child: InkWell(
                        onTap: () {
                          print(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => PageB()),
                          );
                          // final value = box.length + 1;
                          // final model = MyModel(name: value.toString());
                          // box.add(model);
                        },
                        child: Center(
                          child: Icon(
                            Icons.add,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
