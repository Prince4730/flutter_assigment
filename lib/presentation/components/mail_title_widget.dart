import 'package:flutter/material.dart';
import 'package:flutter_assigment/presentation/components/circular_avatar_widget.dart';
import 'package:flutter_assigment/presentation/model/mail.dart';
import 'package:flutter_assigment/presentation/screens/render_web_view.dart';
import 'package:flutter_assigment/utility/colors.dart';
import 'package:flutter_assigment/utility/utility.dart';

class MailTileWidget extends StatefulWidget {
  const MailTileWidget({required this.mail, this.showCaseKey, Key? key})
      : super(key: key);

  final GlobalKey<State<StatefulWidget>>? showCaseKey;
  final Mail mail;

  @override
  State<MailTileWidget> createState() => _MailTileWidgetState();
}

class _MailTileWidgetState extends State<MailTileWidget> {
  bool isFav = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isFav = widget.mail.isFavourite;
  }

  @override
  Widget build(BuildContext context) {
    return _buildMain();
  }

  Widget _buildMain() {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => RenderWebView(
              mail: widget.mail,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.only(left: 6, right: 16, top: 8, bottom: 8),
        color: widget.mail.isUnread ? kPink200Color : kWhiteColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:[_buildAvatarAndTitleWidget(), _buildDateAndIcon()],
        ),
      ),
    );
  }

  Widget _buildAvatarAndTitleWidget() {
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircularAvatarWidget(
            titleText: getFirstTwoLetters(widget.mail.sender),
          ),
          const Padding(padding: EdgeInsets.only(left: 8)),
          _buildTitleWidget()
        ],
      ),
    );
  }

  Widget _buildDateAndIcon() {
    return SizedBox(
      width: 50,
      child: Column(
        children: [
          const SizedBox(
            height: 5,
          ),
          Text(
            widget.mail.date,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 12,
              color: Colors.grey,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          IconButton(
            onPressed: () {
              setState(() {
                isFav = !isFav;
              });
            },
            icon:
                isFav ? const Icon(Icons.star) : const Icon(Icons.star_border),
            color: isFav ? kYellowColor : kGreyColor,
          ),
        ],
      ),
    );
  }

  Widget _buildTitleWidget() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.mail.sender,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight:
                  widget.mail.isUnread ? FontWeight.bold : FontWeight.normal,
              fontSize: 17,
            ),
          ),
          Text(
            widget.mail.sub,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 16,
            ),
          ),
          Text(
            widget.mail.msg,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: widget.mail.isUnread
                  ? Theme.of(context).primaryColor
                  : Colors.black,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }


}
