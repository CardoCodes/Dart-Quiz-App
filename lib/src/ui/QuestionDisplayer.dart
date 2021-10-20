
import 'dart:io';

import '../model/Question.dart';


class QuestionDisplayer {

  ///display questions from given quiz.
  dynamic displayQuizQuestions(quiz) {
    var userAnswer;
    for (var i = 0; i < quiz.questions.length; i++) {
      print('\nQuestion Number ${i + 1}: ' + quiz.questions[i].stem);

      if (quiz.questions[i] is MultipleChoiceQuestion) {
        for(var j = 0; j < quiz.questions[i].options.length; j++){
          print('${j+1}: ' + quiz.questions[i].options[j]);
        }
        print('Type answer here: ');
        userAnswer = stdin.readLineSync();
        try {
          userAnswer = int.parse(userAnswer);
          while (userAnswer < 0 ||
              userAnswer > quiz.questions[i].options.length) {
            print('Error: Make sure the integer is between answer size');
            userAnswer = stdin.readLineSync();
            userAnswer = int.parse(userAnswer);
          }
        } on FormatException {
          print('Formatting Error: Please make sure to type an Integer next time.');
        }
      } else {
        print('Type answer here: ');
        userAnswer = stdin.readLineSync();
      }
      quiz.questions[i].userAnswer = userAnswer;
    }
    return quiz;
  }

  ///display questions from incorrect given quiz.
  dynamic displayIncorrectQuestions(quiz){
    var wrongQuestions = quiz.wrongQuestions;
    for(var i = 0; i < wrongQuestions.length; i++){
      print('Incorrect Question ${i+1}: ');
      print(wrongQuestions[i].stem);
      print('Correct Answer: ');
      print(wrongQuestions[i].stem);
    }
  }
}