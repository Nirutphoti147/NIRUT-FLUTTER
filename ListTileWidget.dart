import 'package:flutter/material.dart';

class ListTileWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Card in ListView')),
        body: ListView.builder(
          itemCount: 10, // You can specify the number of cards
          itemBuilder: (context, index) {
            return Card(
              color: Color(0xfff0ead9),
              //borderOnForeground: true,
              elevation: 10,
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: EdgeInsets.all(15),
                child: ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Card $index'),
                  subtitle: Text('This is card number $index'),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.arrow_forward_ios,
                      //  color: Colors.lightBlueAccent,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ListItemPage()));
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class ListItemPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Card in ListView')),
        body: Center(
          child: Text(
            'Hello, Card in ListView!',
          ),
        ),
      ),
    );
  }
}
