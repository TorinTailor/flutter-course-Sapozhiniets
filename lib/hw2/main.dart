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
        backgroundColor: Color(0xFFFBF1DF),
        appBar: AppBar(
          toolbarHeight: 60,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Библиотека игр",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight(700)),
              ),
              Text("8 игр в списке", style: TextStyle(fontSize: 15)),
            ],
          ),
        ),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.only(top: 5, left: 15, right: 15),
            children: [
              Container(
                //height: 150,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 90,
                          decoration: BoxDecoration(
                            color: Color(0xFF4FAE27),
                            border: Border.all(
                              width: 3,
                              color: Color(0xFF4FAE27),
                            ),
                          ),
                          child: Image.asset("assets/01.png"),
                        ),
                        Positioned(
                          left: 55,
                          top: 5,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(
                              Icons.favorite,
                              size: 20,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "No Man's Sky",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight(700),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text("Hello Games - 2016"),
                          SizedBox(height: 5),
                          Wrap(
                            runSpacing: 5,
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                //alignment: Alignment.center,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Color(0xFF88CF8E),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  "Открытый мир",
                                  style: TextStyle(color: Color(0xFF297137)),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: 5),
                              Container(
                                padding: EdgeInsets.all(5),
                                //alignment: Alignment.center,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Color(0xFF88CF8E),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  "Космос",
                                  style: TextStyle(color: Color(0xFF297137)),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 90,
                          decoration: BoxDecoration(
                            color: Color(0xFF4FAE27),
                            border: Border.all(
                              width: 3,
                              color: Color(0xFF715731),
                            ),
                          ),
                          child: Image.asset("assets/02.png"),
                        ),
                        Positioned(
                          left: 55,
                          top: 5,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(
                              Icons.favorite,
                              size: 20,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Factorio",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight(700),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text("Wube Software STD - 2020"),
                          SizedBox(height: 5),
                          Wrap(
                            runSpacing: 5,
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Color(0xFF88CF8E),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  "Автоматизация",
                                  style: TextStyle(color: Color(0xFF297137)),
                                ),
                              ),
                              SizedBox(width: 5),
                              Container(
                                padding: EdgeInsets.all(5),
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Color(0xFF88CF8E),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  "Строительство фабрики",
                                  style: TextStyle(color: Color(0xFF297137)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 90,
                          decoration: BoxDecoration(
                            color: Color(0xFF4FAE27),
                            border: Border.all(
                              width: 3,
                              color: Color(0xFF1E00C9),
                            ),
                          ),
                          child: Image.asset("assets/03.png"),
                        ),
                        Positioned(
                          left: 55,
                          top: 5,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(
                              Icons.favorite,
                              size: 20,
                              color: const Color(0xFF5F5F5F),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Mass Effect™ Legendary Edition",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight(700),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text("Elecronic Art - 2021"),
                          SizedBox(height: 5),
                          Wrap(
                            runSpacing: 5,
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Color(0xFF88CF8E),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  "Глубокий сюжет",
                                  style: TextStyle(color: Color(0xFF297137)),
                                ),
                              ),
                              SizedBox(width: 5),
                              Container(
                                padding: EdgeInsets.all(5),
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Color(0xFF88CF8E),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  "Ролевая игра",
                                  style: TextStyle(color: Color(0xFF297137)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 90,
                          decoration: BoxDecoration(
                            color: Color(0xFF321C09),
                            border: Border.all(
                              width: 3,
                              color: Color(0xFF321C09),
                            ),
                          ),
                          child: Image.asset("assets/05.png"),
                        ),
                        Positioned(
                          left: 55,
                          top: 5,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(
                              Icons.favorite,
                              size: 20,
                              color: const Color(0xFF5F5F5F),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Darksiders III Deluxe Edition",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight(700),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text("THQ Nordic - 2018"),
                          SizedBox(height: 5),
                          Wrap(
                            runSpacing: 5,
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Color(0xFF88CF8E),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  "Слешер",
                                  style: TextStyle(color: Color(0xFF297137)),
                                ),
                              ),
                              SizedBox(width: 5),
                              Container(
                                padding: EdgeInsets.all(5),
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Color(0xFF88CF8E),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  "Экшен",
                                  style: TextStyle(color: Color(0xFF297137)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 90,
                          decoration: BoxDecoration(
                            color: Color(0xFF4FAE27),
                            border: Border.all(
                              width: 3,
                              color: Color(0xFFC0B6F5),
                            ),
                          ),
                          child: Image.asset("assets/06.png"),
                        ),
                        Positioned(
                          left: 55,
                          top: 5,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(
                              Icons.favorite,
                              size: 20,
                              color: const Color(0xFFFF0000),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Detroit: Become Human",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight(700),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text("Quantic Dream - 2020"),
                          SizedBox(height: 5),
                          Wrap(
                            runSpacing: 5,
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Color(0xFF88CF8E),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  "Глубокий сюжет",
                                  style: TextStyle(color: Color(0xFF297137)),
                                ),
                              ),
                              SizedBox(width: 5),
                              Container(
                                padding: EdgeInsets.all(5),
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Color(0xFF88CF8E),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  "Решения с последствиями",
                                  style: TextStyle(color: Color(0xFF297137)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 90,
                          decoration: BoxDecoration(
                            color: Color(0xFF4FAE27),
                            border: Border.all(
                              width: 3,
                              color: Color(0xFF000000),
                            ),
                          ),
                          child: Image.asset("assets/07.png"),
                        ),
                        Positioned(
                          left: 55,
                          top: 5,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(
                              Icons.favorite,
                              size: 20,
                              color: const Color(0xFF5F5F5F),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "The Elder Scrolls V: Skyrim Special Edition",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight(700),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text("Bethesda Softworks - 2016"),
                          SizedBox(height: 5),
                          Wrap(
                            runSpacing: 5,
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Color(0xFF88CF8E),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  "Открытый мир",
                                  style: TextStyle(color: Color(0xFF297137)),
                                ),
                              ),
                              SizedBox(width: 5),
                              Container(
                                padding: EdgeInsets.all(5),
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Color(0xFF88CF8E),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  "Ролевая игра",
                                  style: TextStyle(color: Color(0xFF297137)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 90,
                          decoration: BoxDecoration(
                            color: Color(0xFF4FAE27),
                            border: Border.all(
                              width: 3,
                              color: Color(0xFF3EBDEF),
                            ),
                          ),
                          child: Image.asset("assets/04.png"),
                        ),
                        Positioned(
                          left: 55,
                          top: 5,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(
                              Icons.favorite,
                              size: 20,
                              color: const Color(0xFF5F5F5F),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "The Witcher 3: Wild Hunt — Remastered",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight(700),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text("CD PROJEKT RED - 2015"),
                          SizedBox(height: 5),
                          Wrap(
                            runSpacing: 5,
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Color(0xFF88CF8E),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  "Открытый мир",
                                  style: TextStyle(color: Color(0xFF297137)),
                                ),
                              ),
                              SizedBox(width: 5),
                              Container(
                                padding: EdgeInsets.all(5),
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Color(0xFF88CF8E),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  "Ролевая игра",
                                  style: TextStyle(color: Color(0xFF297137)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1, color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: 90,
                          decoration: BoxDecoration(
                            color: Color(0xFF4FAE27),
                            border: Border.all(
                              width: 3,
                              color: Color(0xFF1F1748),
                            ),
                          ),
                          child: Image.asset("assets/08.png"),
                        ),
                        Positioned(
                          left: 55,
                          top: 5,
                          child: Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Icon(
                              Icons.favorite,
                              size: 20,
                              color: const Color(0xFFFF0000),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Kerbal Space Program: Complete Edition",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight(700),
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text("Private Division - 2015"),
                          SizedBox(height: 5),
                          Wrap(
                            runSpacing: 5,
                            children: [
                              Container(
                                padding: EdgeInsets.all(5),
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Color(0xFF88CF8E),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  "Космос",
                                  style: TextStyle(color: Color(0xFF297137)),
                                ),
                              ),
                              SizedBox(width: 5),
                              Container(
                                padding: EdgeInsets.all(5),
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Color(0xFF88CF8E),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: Text(
                                  "Симулятор",
                                  style: TextStyle(color: Color(0xFF297137)),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
