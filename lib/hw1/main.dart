// ЛР 1 — шесть независимых виджетов.
//
// Как сдавать: скопируйте этот файл целиком себе в main.dart, допишите
// шесть функций ниже вместо , запустите — все шесть элементов должны
// появиться на экране. Пришлите готовый файл на проверку.
//
// Основной виджет трогать не нужно. Редактируйте там, где написано .

import 'package:flutter/material.dart';

void main() {
  runApp(const Lab1App());
}

class Lab1App extends StatelessWidget {
  const Lab1App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('ЛР 1')),
        body: ListView(
          
          
          children: [
              Text(
                'Task 1:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              task1(),
              const SizedBox(height: 4),
              Divider(),
              const SizedBox(height: 4),
              Text(
                'Task 2:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              task2(),

              const SizedBox(height: 4),
              Divider(),
              const SizedBox(height: 4),
              Text(
                'Task 3:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              task3(),
              const SizedBox(height: 4),
              Divider(),
              const SizedBox(height: 4),
              Text(
                'Task 4:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              task4(),
              const SizedBox(height: 4),
              Divider(),
              const SizedBox(height: 4),
              Text(
                'Task 5:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              task5(),
              const SizedBox(height: 4),
              Divider(),
              const SizedBox(height: 4),
              Text(
                'Task 6:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              task6(),
            ],
            )
            
          
        
      ),
    );
  }
}

// 1. Заголовок — Text, крупный жирный текст чёрного цвета, обрезается в одну строку, если не помещается.
Widget task1() {
  // замените Placeholder на Text()
  return Text(
    "Tетрагидропиранилциклопентилтетрагидропиридопиридиновые, гидразинокарбонилметилбромфенилдигидробенздиазепиновые и кокамидопропилпропиленгликольдимонийхлоридфосфатные соединения.",
    style: TextStyle(fontSize: 50, fontWeight: FontWeight(900)),
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
  );
}

// 2. Подпись — небольшой, нежирный курсивный текст белого цвета, обрезается в две строки
// Также реализуйте подложку из тёмно-серого контейнера с закруглениями, чтобы текст было видно
Widget task2() {
  // замените Placeholder на ...
  return Container(
    //width: 30,
    //height: 60,
    decoration: BoxDecoration(
      color: Color(0xFF979595),
      border: Border.all(width: 2, color: Colors.grey),
      borderRadius: BorderRadius.circular(5),
    ),
    child: Text(
      "Артемида — в древнегреческой мифологии вечно юная богиня охоты, женского целомудрия, покровительница всего живого на Земле, дающая счастье в браке и помощь при родах, позднее стала богиней Луны. ",
      overflow: TextOverflow.ellipsis,
      style: TextStyle(fontStyle: FontStyle.italic, color: Color(0xffffffff)),
      maxLines: 2,
    ),
  );
}

// 3. Иконка — любая Icon на ваш вкус,
// с применением цвета и размером.
Widget task3() {
  //  замените Placeholder на...
  return Icon(
    Icons.rocket_rounded,
    size: 80,
    fontWeight: FontWeight.w900,
    color: Colors.red,
  );
}

// 4. Кнопка с иконкой избранного — большая иконка сердца красного цвета без фона.
// При нажатии пишет в консоль "Вы добавили в избранное"
Widget task4() {
  // замените Placeholder на ...
  return ElevatedButton(
    onPressed: () {
      print("Вы добавили в избранное");
    },
    child: Icon(Icons.favorite, color: Colors.red, size: 100),
  );
}

// 5. Кнопка «Подробнее» — кнопка с текстом и обводкой, при нажатии пишет в консоль "Узнать детали"
Widget task5() {
  // замените Placeholder на ...
  return ElevatedButton(
    onPressed: () {
      print("Узнать детали");
    },
    style: ElevatedButton.styleFrom(
      side: BorderSide(width: 3, color: const Color(0xFFFF6201)),
    ),
    child: Text("Подробнее"),
  );
}

// 6. Изображение в стиле Polaroid—  выберите любое из каталога по ссылке
// https://picsum.photos/ (необходим vpn), либо используйте https://docs.flutter.dev/assets/images/dash/dash-fainting.gif
// Добавьте чёрную обводку, а внутри белую рамку в стиле фотографии Polaroid (https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAeKRHzUEOMCX836O6p8R5-XBkrSlf8C4go4C7f1q8ClnmlFaV9emSrUFL&s=10)
// Для реализации используйте Container
Widget task6() {
  // замените Placeholder на Container()
  return Container(
    width: 340,

    decoration: BoxDecoration(
      color: Colors.white,
      border: Border.all(color: Colors.black),
    ),
    padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 80),
    child: Image.asset('assets/275850_2.jpg', height: 200,),
  );
}
