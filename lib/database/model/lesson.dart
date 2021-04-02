class Lesson{
  int id;
  String lessonName;
  String time;
  int dayName;

  Lesson({this.lessonName, this.time, this.dayName});

  Lesson.map(dynamic obj) {
    this.lessonName = obj["lessonName"];
    this.time = obj["time"];
    this.dayName= obj["dayName"];
  }

  String get getText => lessonName;
  String get getDate => time;
  int get getDayName => dayName;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["lessonName"] = lessonName;
    map["time"] = time;
    map["dayName"] = dayName;
    return map;
  }

  void setLessonId(int id) {
    this.id = id;
  }
}



