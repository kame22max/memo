class Memo {
  int? id;
  String title;
  String content;
  DateTime createdAt;

  Memo({
    this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  // MapからMemoオブジェクトへの変換
  factory Memo.fromMap(Map<String, dynamic> json) => Memo(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        createdAt: DateTime.parse(json['created_at']),
      );

  // MemoオブジェクトからMapへの変換
  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'content': content,
        'created_at': createdAt.toIso8601String(), // ISO 8601形式で保存
      };
}
