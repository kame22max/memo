class Memo {
  int? id;
  String title;
  String content;

  Memo({
    this.id,
    required this.title,
    required this.content,
  });

  // MapからMemoオブジェクトへの変換
  factory Memo.fromMap(Map<String, dynamic> json) => Memo(
        id: json['id'],
        title: json['title'],
        content: json['content'],
      );

  // MemoオブジェクトからMapへの変換
  Map<String, dynamic> toMap() => {
        'id': id,
        'title': title,
        'content': content,
      };
}
