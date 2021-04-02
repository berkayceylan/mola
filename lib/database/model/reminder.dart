class Reminder{
  int id;
  String reminderName;
  String time;
  int dayName;

  Reminder({this.reminderName, this.time, this.dayName});

  Reminder.map(dynamic obj) {
    this.reminderName = obj["reminderName"];
    this.time = obj["time"];
    this.dayName= obj["dayName"];
  }

  String get getText => reminderName;
  String get getDate => time;
  int get getDayName => dayName;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["reminderName"] = reminderName;
    map["time"] = time;
    map["dayName"] = dayName;
    return map;
  }

  void setId(int id) {
    this.id = id;
  }
}



