import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_assigment/presentation/components/circular_avatar_widget.dart';
import 'package:flutter_assigment/presentation/model/mail.dart';
import 'package:flutter_assigment/utility/colors.dart';
import 'package:flutter_assigment/utility/utility.dart';
import 'package:webview_flutter/webview_flutter.dart';

class RenderWebView extends StatefulWidget {
  const RenderWebView({super.key, required this.mail});

  final Mail mail;

  @override
  State<RenderWebView> createState() => _RenderWebViewState();
}

class _RenderWebViewState extends State<RenderWebView> {
  late final WebViewController _controller;
  String htmlContent = '';
  bool isFav = false;
  bool showDetailContainer = false;

  @override
  void initState() {
    super.initState();
    isFav = widget.mail.isFavourite;
    _controller = WebViewController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadFile();
    });
  }

  Future<void> loadFile() async {
    await _controller.loadFlutterAsset(widget.mail.htmlPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.archive_outlined,
                color: kBlackColor.withOpacity(0.7)),
            onPressed: () {
              // Handle the search action here.
            },
          ),
          IconButton(
            icon:
                Icon(Icons.delete_rounded, color: kBlackColor.withOpacity(0.7)),
            onPressed: () {
              // Handle the mail action here.
            },
          ),
          IconButton(
            icon: Icon(
              Icons.mail,
              color: kBlackColor.withOpacity(0.7),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          IconButton(
            icon: Icon(Icons.more_horiz, color: kBlackColor.withOpacity(0.7)),
            onPressed: () {
              showBottomSheet();
            },
          ),
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(
            height: 4,
          ),
          _buildSubject(),
          _buildLabel(),
          const SizedBox(
            height: 16,
          ),
          _buildSenderDetails(),
          if (showDetailContainer)
            const SizedBox(
              height: 12,
            ),
          if (showDetailContainer) _buildEmailsDetailContainer(),
          SizedBox(
            height: MediaQuery.of(context).size.height,
            child: WebViewWidget(
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                Factory<VerticalDragGestureRecognizer>(
                    () => VerticalDragGestureRecognizer()),
                Factory<HorizontalDragGestureRecognizer>(
                    () => HorizontalDragGestureRecognizer()),
                Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()),
              },
              controller: _controller,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          _buildButtons(),
        ],
      ),
    );
  }

  void showBottomSheet() {
    showModalBottomSheet(
        elevation: 0,
        context: context,
        builder: (BuildContext context) {
          return Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(0.0),
                ),
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  _buildOption("Snooze"),
                  const SizedBox(
                    height: 8,
                  ),
                  _buildOption("Move"),
                  const SizedBox(
                    height: 8,
                  ),
                  _buildOption("Label"),
                  const SizedBox(
                    height: 8,
                  ),
                  _buildOption("Mark as important"),
                  const SizedBox(
                    height: 8,
                  ),
                  _buildOption("Mute"),
                  const SizedBox(
                    height: 8,
                  ),
                  _buildOption("Unsubscribe"),
                  const SizedBox(
                    height: 8,
                  ),
                  _buildOption("Report spam"),
                  const SizedBox(
                    height: 8,
                  ),
                  _buildOption("Print all"),
                  const SizedBox(
                    height: 8,
                  ),
                  _buildOption("Add to tasks"),
                  const SizedBox(
                    height: 8,
                  ),
                  _buildOption("Cancel"),
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ));
        });
  }

  Widget _buildOption(String title) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(
            color: kBlackColor, fontSize: 14, fontWeight: FontWeight.w400),
      ),
      onTap: () {
        Navigator.pop(context);
      },
    );
  }

  Widget _buildSubject() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Text(
        widget.mail.msg,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
        maxLines: 3,
      ),
    );
  }

  Widget _buildLabel() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
                color: kLightGreyColor.withOpacity(0.4),
                borderRadius: const BorderRadius.all(Radius.circular(4))),
            child: const Padding(
              padding: EdgeInsets.all(4.0),
              child: Center(
                  child: Text(
                "Inbox",
                style: TextStyle(
                    color: kBlackColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w400),
              )),
            ),
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

  Widget _buildSenderDetails() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_buildAvatarWithDetails(), _buildIcons()],
      ),
    );
  }

  Widget _buildAvatarWithDetails() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircularAvatarWidget(
          margin: 0,
          titleText: getFirstTwoLetters(widget.mail.sender),
        ),
        const SizedBox(
          width: 12,
        ),
        _buildDetailWidget()
      ],
    );
  }

  Widget _buildDetailWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              widget.mail.sender,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            const SizedBox(
              width: 6,
            ),
            Text(
              widget.mail.date,
              style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  color: kBlack45Color),
            ),
          ],
        ),
        Row(
          children: [
            const Text(
              "to me",
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 12,
                  color: kBlack45Color),
            ),
            IconButton(
                onPressed: () {
                  showDetailContainer = !showDetailContainer;
                  setState(() {});
                },
                icon: Icon(
                  showDetailContainer
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: kBlack45Color,
                ))
          ],
        ),
      ],
    );
  }

  Widget _buildIcons() {
    return Row(
      children: [
        IconButton(
            onPressed: null,
            icon: Icon(
              Icons.reply,
              color: kBlackColor.withOpacity(0.7),
            )),
        IconButton(
          icon: Icon(Icons.more_horiz, color: kBlackColor.withOpacity(0.7)),
          onPressed: () {
            showBottomSheet();
          },
        ),
      ],
    );
  }

  Widget _buildEmailsDetailContainer() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(color: kLightGreyColor, width: 1),
            borderRadius: const BorderRadius.all(Radius.circular(8))),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildListTile("From", widget.mail.sender),
              const SizedBox(
                height: 10,
              ),
              _buildListTile("To", "princeshandalaya@gmail.com"),
              const SizedBox(
                height: 10,
              ),
              _buildListTile("Date", widget.mail.date),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListTile(String title, String subTitle) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: kGreyColor, fontSize: 12, fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          width: 32,
        ),
        Text(
          subTitle,
          style: const TextStyle(
              color: kBlackColor, fontSize: 12, fontWeight: FontWeight.w400),
          textAlign: TextAlign.end,
        )
      ],
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            child: OutlinedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.resolveWith<OutlinedBorder?>(
                    (states) {
                  return RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8));
                }),
              ),
              onPressed: () {
                // Handle the first button's action.
              },
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.reply_outlined, color: kBlack45Color),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "Reply",
                    style: TextStyle(
                        color: kBlack45Color,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: OutlinedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.resolveWith<OutlinedBorder?>(
                    (states) {
                  return RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8));
                }),
              ),
              onPressed: () {
                // Handle the second button's action.
              },
              child: const Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.forward_5_outlined, color: kBlack45Color),
                  SizedBox(
                    width: 4,
                  ),
                  Text(
                    "Forward",
                    style: TextStyle(
                        color: kBlack45Color,
                        fontSize: 14,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
