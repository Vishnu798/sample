class Event {
  final bool status;
  final String message;
  final List<Data> data;

  Event({
    required this.status,
    required this.message,
    required this.data,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        data:
            List<Data>.from(json["data"].map((x) => Data.fromJson(x)).toList()),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Data {
  final String title;
  final int date;
  final String description;

  Data({
    required this.title,
    required this.date,
    required this.description,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        title: json["title"] ?? "",
        date: getDate(json["date"] ?? ""),
        description: json["description"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "date": date,
        "description": description,
      };
}

int getDate(String date) {
  try {
    List<String> seperateDate = date.split('-');
    if (seperateDate[1].length == 1) {
      seperateDate[1] = '0${seperateDate[1]}';
    }
    if (seperateDate[2].length == 1) {
      seperateDate[2] = '0${seperateDate[2]}';
    }
    int dateInt =
        DateTime.parse(seperateDate[0] + seperateDate[1] + seperateDate[2])
            .millisecondsSinceEpoch;
    return dateInt;
  } catch (e) {
    throw Exception("error in date conversion");
  }
}
