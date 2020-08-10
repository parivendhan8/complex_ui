import 'package:Complex_ui/resouces/firebase_repository.dart';
import 'package:Complex_ui/screens/page_views/chat_list_screen.dart';
import 'package:Complex_ui/utils/universal_variables.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseRepository _repository = FirebaseRepository();
  PageController _pageController;
  int page = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    double _labelFontSize = 10;

    return Scaffold(
      backgroundColor: UniversalVariables.blackColor,
      body: PageView(
        children: <Widget>[
          Container(child: ChatListScreen(),),
          Center(child: Text(' Message List ')),
          Center(child: Text(' Contact List ')),
        ],
        onPageChanged: (value) => onpageChange(value),
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: CupertinoTabBar(
              backgroundColor: UniversalVariables.blackColor,
              items: [
                bottomNav(Icons.chat, "Chat", 0),
                bottomNav(Icons.call, "Calls", 1),
                bottomNav(Icons.contacts, "Contacts", 2),
              ],
          currentIndex: page,
            onTap: navigation,
          ),
        ),
      ),
    );


  }

  onpageChange(int value) {
    setState(() {
      page = value;
    });
  }

  void navigation(int page){
    _pageController.jumpToPage(page);
  }

  BottomNavigationBarItem bottomNav(IconData chat, String title, int position) {
    return BottomNavigationBarItem(
      icon: Icon(chat,
          color: (page == position)
              ? UniversalVariables.lightBlueColor
              : UniversalVariables.greyColor),
      title: Text(
        title,
        style: TextStyle(
            fontSize: 10,
            color: (page == position)
                ? UniversalVariables.lightBlueColor
                : UniversalVariables.greyColor),
      ),

    );
  }


}
