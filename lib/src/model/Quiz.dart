
class Quiz{
  ///Quiz has a List of questions and a name.
  List<dynamic> _questions = [];
  String _name;


  Quiz(this._questions, this._name);

  String get name => _name;
  List<dynamic> get questions => _questions;

  ///Returns the grade of the quiz.
  int grade() {
    var currGrade = 0;
    _questions.forEach((e) => currGrade += e.isCorrect()? 1:0);
    return currGrade;
  }

  ///Check to see if the quiz is complete.
  bool isComplete() {
    bool retBool = true;
    _questions.forEach((e){
      if (e.userAnswer == null) retBool = false;
    });
    return retBool;
  }

  /// get the questions that the user got wrong.
  List<dynamic> get wrongQuestions {
    List<dynamic> wrongQ = _questions;
    _questions.forEach((q) {
      if(!q.isCorrect()) wrongQ.add(q);
    });
    return wrongQ;
  }

}