import 'dart:convert';
import 'package:http/http.dart' as http;

class WebClient{

  ///Gets quiz info for [numQuiz] as a json.
  Future getJsonQuiz(int numQuiz) async {
    final response = await http
        .get(Uri.parse(
        'http://www.cs.utep.edu/cheon/cs4381/homework/quiz?quiz=quiz0${numQuiz}'));
    Map mapDecode = json.decode(response.body);
    //check for response
    if (mapDecode['response'] == true) {
      return mapDecode;
    } else {
      return null;
    }
  }

  ///Generate a list with all the questions from quiz 1-9.
  Future getJsonAllQuiz() async {
    var randomPicker = List<int>.generate(9, (i) => i + 1)..shuffle();
    var questions = [];
    for( var i = 0; i < randomPicker.length; i++){
      var response = await http.get(Uri.parse('http://www.cs.utep.edu/cheon/cs4381/homework/quiz?quiz=quiz0${randomPicker[i]}'));
      Map mapDecode = json.decode(response.body);
      questions += mapDecode['quiz']['question'];
    }
    return(questions);
  }

}