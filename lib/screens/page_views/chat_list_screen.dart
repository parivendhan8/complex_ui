import 'package:Complex_ui/resouces/firebase_repository.dart';
import 'package:Complex_ui/utils/universal_variables.dart';
import 'package:Complex_ui/utils/utilities.dart';
import 'package:Complex_ui/widgets/appbar.dart';
import 'package:flutter/material.dart';
import 'package:Complex_ui/widgets/custom_tile.dart';

class ChatListScreen extends StatefulWidget {
  @override
  _ChatListScreenState createState() => _ChatListScreenState();
}

// global variable
final FirebaseRepository _repository = FirebaseRepository();

class _ChatListScreenState extends State<ChatListScreen> {
  String currentUserId;
  String initials = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _repository.getCurrentUser().then((value) {
      setState(() {
        currentUserId = value.uid;
        initials = Utils.getInitials(value.displayName);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalVariables.blackColor,
      appBar: customAppBar(context),
      floatingActionButton: NewChatButton(),
      body: ChatListContainer(currentUserId: currentUserId,),
    );
  }

  CustomAppBar customAppBar(BuildContext context) {
    return CustomAppBar(
        title: UserCircle(text: initials,),
      /*  title: Container(
          child: Text(''),
        ),*/
        actions: [
          IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
        ],
        leading: IconButton(
          icon: Icon(
            Icons.notifications,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        centerTitle: true);
  }
}

class UserCircle extends StatelessWidget {
  final String text;

  UserCircle({this.text = ''});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: UniversalVariables.separatorColor,
      ),
      child: Stack(
        children: <Widget>[
         Align(
           alignment: Alignment.center,
           child:  Text(
             "$text",
             style: TextStyle(
               fontWeight: FontWeight.bold,
               color: UniversalVariables.lightBlueColor,
               fontSize: 13,
             ),
           ),
         ),

          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: UniversalVariables.onlineDotColor,

              ),
            ),

          )

        ],
      ),
    );
  }
}

class NewChatButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient:UniversalVariables.fabGradient,
//        shape: BoxShape.circle
      borderRadius: BorderRadius.circular(50)
      ),
      child: Icon(
        Icons.edit,
        color: Colors.white,
        size: 25,
      ),
      padding: EdgeInsets.all(15),
    );
  }
}

class ChatListContainer extends StatefulWidget {
  
  String currentUserId = '';

  ChatListContainer({@required this.currentUserId});

  @override
  _ChatListContainerState createState() => _ChatListContainerState();
}

class _ChatListContainerState extends State<ChatListContainer> {

  

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(itemBuilder: (context, index) {
        return CustomTile(
          mini: false,
          onTap: () {},
          title: Text('Sample'),
          subtitle: Text('Hello', style: TextStyle(color: Colors.white, fontSize: 12),),
          leading: Container(
            constraints: BoxConstraints(maxHeight: 60, maxWidth: 60),
            child: Stack(
              children: <Widget>[
                CircleAvatar(
                  maxRadius: 30,
                  backgroundColor: Colors.grey,
                  backgroundImage: NetworkImage('https://lh3.googleusercontent.com/a-/AOh14Gh5C0UV_hfJrfr9W6p5iabbWKa5lVEKQnpHZWzI=s96-c'),),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: UniversalVariables.blackColor
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
      padding: EdgeInsets.all(10),
        itemCount: 2,
      ),

    );
  }
}


