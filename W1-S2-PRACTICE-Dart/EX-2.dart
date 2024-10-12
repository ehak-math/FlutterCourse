void main() {
  // 1 - iLike
  String iLike = 'I like pizza';

  // 2 - toppings
  String toppings = 'with tomatoes';
  toppings += " and cheese";

  // 3 - message
  String message = '$iLike $toppings';
  print(message);

  // 4 - rbgColors
  List<String> rbgColors = ['red', 'blue', 'green'];
  print(rbgColors);

  // 5 - weekDays
  List<String> weekDays = ['monday', 'tuesday', 'wednesday'];
  weekDays.add('thursday');
  print(weekDays);

  // 6 - scores
  List<int> scores = [45,35,50];
  scores = [45,35,50, 78];
  print(scores);
}


