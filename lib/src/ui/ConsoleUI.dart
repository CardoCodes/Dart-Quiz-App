import 'dart:io';

import '../net/WebClient.dart';
import '../model/QuizParser.dart';
import '../model/Quiz.dart';
import '../ui/QuestionDisplayer.dart';

///main controller to set up quiz.
void main() async{
  var questionDisplayer = QuestionDisplayer();
  var quiz;

  var userChoice = welcomeMessage();
  var numQuiz;

  if(userChoice == 1){
    numQuiz = promptQuizNumber();
    var response = await WebClient().getJsonQuiz(numQuiz);
    var questions = await QuizParser().generateQuiz(response);
    quiz = Quiz(questions, 'normalQuiz');

  } else {
    numQuiz = promptRandomAmount();
    var response = await WebClient().getJsonAllQuiz();
    var questions = await QuizParser().generatePracticeQuiz(response, numQuiz);
    quiz = Quiz(questions, 'randomQuiz');
  }

  var finishedQuiz = questionDisplayer.displayQuizQuestions(quiz);
  print('Grade: ${finishedQuiz.grade()}/ ${finishedQuiz.questions.length}');
  //questionDisplayer.displayIncorrectQuestions(finishedQuiz);
}

///welcome message and ask user for quiz.
dynamic welcomeMessage() {
  try {
    print(
        'Welcome to my quiz app! Would you like to take a real quiz or practice quiz? \n 1: Real Quiz \n 2: Practice Quiz');
    var userIn = stdin.readLineSync();
    var num = int.parse(userIn!);

    while (num < 1 || num > 2) {
      print('Formatting Error: Make sure to use 1 or 2');
      userIn = stdin.readLineSync();
      num = int.parse(userIn!);
    }
    return num;
  } on FormatException {
    print('Formatting Error: Make sure to use 1 or 2');
    welcomeMessage();
  }
}

  ///prompt user for random amount of questions.
  dynamic promptRandomAmount(){
    try {
      print(
          'How many questions would you like your random quiz to be composed of(1-50)?');
      var userIn = stdin.readLineSync();
      var num = int.parse(userIn!);

      while (num < 1 || num > 50) {
        print('Formatting Error: Make sure to use 1 or 50');
        userIn = stdin.readLineSync();
        num = int.parse(userIn!);
      }
      return num;
    } on FormatException {
      print('Formatting Error: Make sure to use 1 or 50');
      promptRandomAmount();
    }
  }

  ///prompt user for which quiz to take
  dynamic promptQuizNumber(){
    try {
      print(
          'What quiz number of pre-generated quizzes would you like(1-9)?');
      var userIn = stdin.readLineSync();
      var num = int.parse(userIn!);

      while (num < 1 || num > 9) {
        print('Formatting Error: Make sure to use 1 or 9');
        userIn = stdin.readLineSync();
        num = int.parse(userIn!);
      }
      return num;
    } on FormatException {
      print('Formatting Error: Make sure to use 1 or 9');
      promptQuizNumber();
    }
  }