import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_assigment/presentation/components/circular_avatar_widget.dart';
import 'package:flutter_assigment/presentation/model/mail.dart';
import 'package:flutter_assigment/presentation/components/mail_title_widget.dart';
import 'package:flutter_assigment/utility/assert_path.dart';
import 'package:flutter_assigment/utility/colors.dart';

class GmailDashboard extends StatefulWidget {
  const GmailDashboard({super.key});

  @override
  State<GmailDashboard> createState() => _GmailDashboardState();
}

class _GmailDashboardState extends State<GmailDashboard> {
  List<Mail> mails = [];
  List<Mail> originalMails = [];
  final scrollController = ScrollController();
  bool showIconWithText = true;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addListener();
    mails = const [
      Mail(
          sender: 'Happilo',
          sub: 'Purchase',
          msg: 'Thank you for your purchase',
          date: '1 May',
          isUnread: false,
          htmlPath: htmlFile1),
      Mail(
          sender: 'Hopscotch',
          sub: 'Order Shipped',
          msg: 'Hi, Prince your order is shipped ',
          date: '2 May',
          isUnread: true,
          htmlPath: htmlFile2),
      Mail(
          sender: 'noise',
          sub: 'Order Placed',
          msg: 'Hi, Prince your order number is 1335',
          date: '3 May',
          isUnread: false,
          htmlPath: htmlFile3),
      Mail(
          sender: 'Happilo',
          sub: 'Purchase',
          msg: 'Thank you for your purchase',
          date: '1 May',
          isUnread: false,
          htmlPath: htmlFile1),
      Mail(
          sender: 'Hopscotch',
          sub: 'Order Shipped',
          msg: 'Hi, Prince your order is shipped ',
          date: '2 May',
          isUnread: true,
          htmlPath: htmlFile2),
      Mail(
          sender: 'noise',
          sub: 'Order Placed',
          msg: 'Hi, Prince your order number is 1335',
          date: '3 May',
          isUnread: false,
          htmlPath: htmlFile3),
      Mail(
          sender: 'Happilo',
          sub: 'Purchase',
          msg: 'Thank you for your purchase',
          date: '1 May',
          isUnread: false,
          htmlPath: htmlFile1),
      Mail(
          sender: 'Hopscotch',
          sub: 'Order Shipped',
          msg: 'Hi, Prince your order is shipped ',
          date: '2 May',
          isUnread: true,
          htmlPath: htmlFile2),
      Mail(
          sender: 'noise',
          sub: 'Order Placed',
          msg: 'Hi, Prince your order number is 1335',
          date: '3 May',
          isUnread: false,
          htmlPath: htmlFile3),
      Mail(
          sender: 'Happilo',
          sub: 'Purchase',
          msg: 'Thank you for your purchase',
          date: '1 May',
          isUnread: false,
          htmlPath: htmlFile1),
      Mail(
          sender: 'Hopscotch',
          sub: 'Order Shipped',
          msg: 'Hi, Prince your order is shipped ',
          date: '2 May',
          isUnread: true,
          htmlPath: htmlFile2),
      Mail(
          sender: 'noise',
          sub: 'Order Placed',
          msg: 'Hi, Prince your order number is 1335',
          date: '3 May',
          isUnread: false,
          htmlPath: htmlFile3),
      Mail(
          sender: 'Happilo',
          sub: 'Purchase',
          msg: 'Thank you for your purchase',
          date: '1 May',
          isUnread: false,
          htmlPath: htmlFile1),
      Mail(
          sender: 'Hopscotch',
          sub: 'Order Shipped',
          msg: 'Hi, Prince your order is shipped ',
          date: '2 May',
          isUnread: true,
          htmlPath: htmlFile2),
      Mail(
          sender: 'noise',
          sub: 'Order Placed',
          msg: 'Hi, Prince your order number is 1335',
          date: '3 May',
          isUnread: false,
          htmlPath: htmlFile3),
      Mail(
          sender: 'Happilo',
          sub: 'Purchase',
          msg: 'Thank you for your purchase',
          date: '1 May',
          isUnread: false,
          htmlPath: htmlFile1),
      Mail(
          sender: 'Hopscotch',
          sub: 'Order Shipped',
          msg: 'Hi, Prince your order is shipped ',
          date: '2 May',
          isUnread: true,
          htmlPath: htmlFile2),
      Mail(
          sender: 'noise',
          sub: 'Order Placed',
          msg: 'Hi, Prince your order number is 1335',
          date: '3 May',
          isUnread: false,
          htmlPath: htmlFile3),
    ];
    originalMails = mails;
  }



  void addListener() {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (showIconWithText == true) {
          setState(() {
            showIconWithText = false;
          });
        }
      } else {
        if (scrollController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (showIconWithText == false) {
            setState(() {
              showIconWithText = true;
            });
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: _buildDrawer(),
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            _buildMailsList()
          ],
        ),
      ),
      floatingActionButton: _buildFaqButton(),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  Drawer _buildDrawer() {
    return Drawer(
      elevation: 0,
      backgroundColor: kWhiteColor,
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: kWhiteColor),
            accountName: Text(
              'Prince Kumar',
              style: TextStyle(color: kBlackColor, fontSize: 16),
            ),
            accountEmail: Text('princeshandalaya@gmail.com',
                style: TextStyle(color: kBlack45Color, fontSize: 16)),
            currentAccountPicture: CircularAvatarWidget(
              titleText: "PC",

              //  backgroundImage: AssetImage('assets/profile_image.jpg'), // Add your profile image
            ),
          ),
          _buildDrawerOption("All inboxes", Icons.message),
          _buildDrawerOption("Primary", Icons.photo),
          _buildDrawerOption("Promotions", Icons.bookmark_add_outlined),
          _buildDrawerOption("Starred", Icons.star_border),
          _buildDrawerOption("Sent", Icons.send),
          _buildDrawerOption("Drafts", Icons.drafts),
          _buildDrawerOption("Spam", Icons.warning_amber),

          // Add more drawer items as needed
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      children: [
        Expanded(child: _buildTextField()),
        const CircularAvatarWidget(
          titleText: "P",
        ),
        const SizedBox(
          width: 12,
        ),
      ],
    );
  }

  Widget _buildFaqButton() {
    if (showIconWithText) {
      return FloatingActionButton(
          backgroundColor: kWhiteColor,
          onPressed: () {},
          elevation: 6.0,
          shape: const CircleBorder(),
          child: Icon(
            Icons.edit_outlined,
            color: Theme.of(context).primaryColor,
          ));
    }
    return FloatingActionButton.extended(
      elevation: 6.0,
      icon: Icon(
        Icons.edit_outlined,
        color: Theme.of(context).primaryColor,
      ),
      label: Text(
        'Compose',
        style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 14),
      ),
      // Add you
      backgroundColor: kWhiteColor,
      onPressed: null,
    );
  }

  Widget _buildTextField() {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 4),
      child: TextField(
        cursorColor: Theme.of(context).primaryColor,
        onChanged: _filterList,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kLightPinkColor),
            borderRadius:
                BorderRadius.circular(4.0), // Change border color on focus
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: kLightPinkColor),
            borderRadius: BorderRadius.circular(4.0),
          ),
          border: OutlineInputBorder(
            gapPadding: 4,
            borderSide: const BorderSide(color: kLightGreyColor),

            borderRadius: BorderRadius.circular(
              4.0,
            ), // Adjust the corner radius
          ),
          labelText: 'Search email',
          labelStyle: const TextStyle(
            color: kBlack45Color,
            fontSize: 16,
            letterSpacing: 0.4,
          ),
          suffixIcon: const Icon(
            Icons.search,
            color: kLightGreyColor,
          ),
          prefixIcon: IconButton(
            icon: Icon(
              Icons.menu,
              color: Theme.of(context).primaryColor,
            ), // Trailing icon
            onPressed: () {
              _scaffoldKey.currentState?.openDrawer();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerOption(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        title,
        style: const TextStyle(color: kBlackColor, fontSize: 14),
      ),
      onTap: () {
        _scaffoldKey.currentState?.closeDrawer();
      },
    );
  }

  Widget _buildMailsList() {
    return Expanded(
      child: ListView.builder(
        controller: scrollController,
        itemCount: mails.length + 1,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          if (index == 0) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildAppBar(),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 16, top: 4),
                  child: const Text(
                    'ALL INBOXES',
                    style: TextStyle(
                      color: kBlack45Color,
                      fontSize: 15,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            );
          }

          return MailTileWidget(
            mail: mails[index % mails.length],
          );
        },
      ),
    );
  }

  void _filterList(String query) {
    setState(() {
      mails = originalMails
          .where(
              (item) => item.sender.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }
}
