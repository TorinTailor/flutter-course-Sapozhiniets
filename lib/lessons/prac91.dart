void main() {
  String name = 'Yaroslav';
  int age = 21;
  double grow = 1.87;
  bool isStd = true;
  print('Меня зовут $name. Мне $age год. Мой рост $grow м. Я студент? - $isStd.');

  String text = '   Flutter Developer   ';
  String result = text.trim().toUpperCase();
  print(result);

  List<String> products = ['Молоко', 'Хлеб'];
  products.add('Сыр');
  products.remove('Хлеб');
  print('В корзине: ${products.length} шт.');

   for (var i = 0; i <= 10; i++){
    i.isEven ? print('$i чётное') : print('$i');
  }

}



