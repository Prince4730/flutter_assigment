class Mail {
  const Mail(
      {required this.sender,
      required this.sub,
      required this.msg,
      required this.date,
      required this.isUnread,
      this.isFavourite = false,
      required this.htmlPath});

  final String sender;

  final String sub;
  final String msg;
  final String date;
  final bool isUnread;
  final bool isFavourite;
  final String htmlPath;
}
