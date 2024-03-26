class Memo {
  int? id;
  String title;
  String content;
  DateTime register_date;
  DateTime edited_date; // 追加


  Memo({
    this.id,
    required this.title,
    required this.content,
    required this.register_date,
    required this.edited_date, // 追加

  });

  // MapからMemoオブジェクトへの変換
  factory Memo.fromMap(Map<String, dynamic> json) => Memo(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        register_date: DateTime.parse(json['register_date']),
    edited_date: DateTime.parse(json['edited_date']), // 追加

  );

  // MemoオブジェクトからMapへの変換
  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'content': content,
        'register_date': register_date.toIso8601String(),
    'edited_date': edited_date.toIso8601String(), // 追加

  };
}
