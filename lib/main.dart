import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: practic8(),
        ),
      ),
    );
  }

  Scrollbar practic8() {
    return Scrollbar(
          thickness: 10,
          child: RefreshIndicator(
            onRefresh: () async {},
            child: SingleChildScrollView(
              keyboardDismissBehavior:
                  ScrollViewKeyboardDismissBehavior.onDrag,
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Container(
                    color: Colors.blue,
                    width: 200,
                    child: TextField(),
                  ),
                  Container(color: Colors.amber, height: 300,),
                  Container(color: Colors.black, height: 300,),
                  Container(color: Colors.green, height: 300,),
                  Container(color: Colors.red, height: 300,),
                ],
              ),
            ),
          ),
        );
  }

  Container practic7() {
    return Container(
      width: 500,
      height: 1000,
      margin: EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: Colors.red,
        border: Border.all(color: Colors.black, width: 10),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        alignment: Alignment.centerRight,
        child: Icon(Icons.lock),
        padding: EdgeInsets.only(right: 15),
      ),
    );
  }

  Container practic6() {
    return Container(
      alignment: Alignment.topRight,
      child: Container(color: Colors.red, width: 20, height: 20),
      width: 300,
      height: 500,
      margin: EdgeInsets.all(50),
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.purpleAccent,
        border: Border.all(color: Colors.black, width: 10),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }

  Align practic5() {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.only(right: 10, bottom: 20),
        child: Text('Всем привет!'),
      ),
    );
  }

  Image practic4() {
    return Image.network(
      'https://avatars.mds.yandex.net/i?id=f1fcb60efa9775b9cb3a8a311c73b457_l-5259770-images-thumbs&n=13',
      errorBuilder: (context, error, StackTrace) {
        debugPrint('Image error: $error'); // реальная причина
        return const Text('Фото не найдено');
      },
      fit: BoxFit.cover,
      //width: 100,
      //height: 100,
      color: Color(0xFFFF0000),
      colorBlendMode: BlendMode.colorBurn,
    );
  }

  ElevatedButton practic3() {
    return ElevatedButton(
      onPressed: () {
        print('Привет!');
      },
      child: Icon(Icons.add),
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF00D9FF),
        foregroundColor: Colors.blue,
        elevation: 3,
        //shadowColor: Colors.deepOrange,
        side: BorderSide(color: Colors.blueAccent, width: 3),
        fixedSize: Size(80, 80),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Icon practic2() {
    return Icon(
      Icons.check,
      size: 62,
      fontWeight: FontWeight.bold,
      color: Color(0xFF19C619),
    );
  }
}
