import 'package:flutter/material.dart';
import '../chats.dart';
import '../themes/inherited_theme.dart';
import '../widgets/home_page/hovered_item.dart';
import 'new_category_page.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  _MyHomePageState get myState => _MyHomePageState();
  @override
  State<StatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Map<String, Icon> listofChats = <String, Icon>{};

  @override
  Widget build(BuildContext context) {
    if (listofChats.isEmpty) listofChats.addAll(chats());
    final style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontSize: 25),
      primary: Theme.of(context).primaryColor,
      minimumSize: const Size(200, 40),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          widget.title,
          style: const TextStyle(fontSize: 30),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: (() => Inherited.of(context).changeTheme()),
            icon: const Icon(Icons.invert_colors),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
          ),
        ],
      ),
      drawer: Drawer(backgroundColor: Theme.of(context).primaryColor),
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 40),
          ),
          botButton(style, context),
          const Padding(
            padding: EdgeInsets.only(top: 40.0),
          ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: listofChats.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Divider(
                    height: 5,
                    thickness: 5,
                    color: Theme.of(context).shadowColor,
                  ),
                  HoveredItem(
                    listofChats.keys.elementAt(index),
                    'No events. Click to create one.',
                    listofChats.values.elementAt(index).icon!,
                    _bottomSheet(
                      context,
                      listofChats.keys.elementAt(index),
                      listofChats.values.elementAt(index),
                    ),
                  ),
                  Divider(
                    height: 5,
                    thickness: 5,
                    color: Theme.of(context).shadowColor,
                  ),
                ],
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: () => {
          _createChat(context),
        },
        tooltip: 'Button',
        child: Icon(
          Icons.add,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
      ),
      bottomNavigationBar: navBar(context),
    );
  }

  void _createChat(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewCategoryPage()),
    );

    var res = Map<String, Icon>.from(result).entries;
    setState(() {
      listofChats.addEntries(res);
    });
  }

  Row botButton(ButtonStyle style, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          style: style,
          onPressed: () {},
          icon: Icon(
            Icons.question_answer,
            size: 30.0,
            color: Theme.of(context).highlightColor,
          ),
          label: Text(
            'Questionnaire Bot',
            style: TextStyle(color: Theme.of(context).highlightColor),
          ),
        ),
      ],
    );
  }

  BottomNavigationBar navBar(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Theme.of(context).bottomAppBarColor,
      selectedItemColor: Theme.of(context).colorScheme.secondary,
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.task),
          label: 'Daily',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Timeline',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.explore),
          label: 'Explore',
        )
      ],
    );
  }

  void _editChat(BuildContext context, String title, Icon icon) async {
    Navigator.pop(context);
    listofChats.removeWhere((key, value) => key == title && value == icon);
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewCategoryPage.edit(
          title: title,
          icon: icon,
        ),
      ),
    );

    var res = Map<String, Icon>.from(result).entries;
    setState(() {
      listofChats.addEntries(res);
    });
  }

  Container _bottomSheet(BuildContext context, String title, Icon icon) {
    return Container(
      padding: const EdgeInsets.all(5),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TextButton(
            child: Row(children: [
              const Icon(
                Icons.info,
                color: Color.fromARGB(255, 3, 201, 125),
              ),
              const Padding(
                padding: EdgeInsets.all(5),
              ),
              Text(
                'Info',
                style:
                    TextStyle(fontSize: 25, color: Theme.of(context).hintColor),
              ),
            ]),
            onPressed: null,
          ),
          TextButton(
            child: Row(children: [
              const Icon(
                Icons.attach_file,
                color: Colors.green,
              ),
              const Padding(
                padding: EdgeInsets.all(5),
              ),
              Text(
                'Pin/Unpin page',
                style:
                    TextStyle(fontSize: 25, color: Theme.of(context).hintColor),
              ),
            ]),
            onPressed: null,
          ),
          TextButton(
            child: Row(children: [
              const Icon(
                Icons.archive,
                color: Colors.yellow,
              ),
              const Padding(
                padding: EdgeInsets.all(5),
              ),
              Text(
                'Archive page',
                style:
                    TextStyle(fontSize: 25, color: Theme.of(context).hintColor),
              ),
            ]),
            onPressed: null,
          ),
          TextButton(
            child: Row(children: [
              const Icon(
                Icons.edit,
                color: Colors.blue,
              ),
              const Padding(
                padding: EdgeInsets.all(5),
              ),
              Text(
                'Edit page',
                style:
                    TextStyle(fontSize: 25, color: Theme.of(context).hintColor),
              ),
            ]),
            onPressed: () => _editChat(context, title, icon),
          ),
          TextButton(
            child: Row(children: [
              const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              const Padding(
                padding: EdgeInsets.all(5),
              ),
              Text(
                'Delete page',
                style:
                    TextStyle(fontSize: 25, color: Theme.of(context).hintColor),
              ),
            ]),
            onPressed: () => {
              Navigator.pop(context),
              setState(
                () {
                  listofChats.removeWhere((key, value) => key == title);
                },
              ),
            },
          ),
        ],
      ),
    );
  }
}