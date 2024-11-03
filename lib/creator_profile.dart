import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const CircleAvatar(
                radius: 60.0,
                backgroundImage: NetworkImage(
                    'https://media.sproutsocial.com/uploads/2022/06/profile-picture.jpeg'),
              ),
              Text(
                'Shri Harsh S Kotecha',
                style: TextStyle(
                  fontFamily: 'DancingScript',
                  fontSize: 40,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Flutter Developer',
                style: TextStyle(
                  fontFamily: 'SourceSans',
                  color: Colors.teal.shade100,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  letterSpacing: 2.5,
                ),
              ),
              SizedBox(
                height: 20,
                width: 150,
                child: Divider(
                  color: Colors.teal.shade100,
                ),
              ),
              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Icon(
                      Icons.call,
                      color: Colors.teal.shade900,
                    ),
                    title: Text(
                      '+91 8086182228',
                      style: TextStyle(
                        fontFamily: 'SourceSans',
                        color: Colors.teal.shade900,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                color: Colors.white,
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: ListTile(
                    leading: Icon(
                      Icons.mail,
                      color: Colors.teal.shade900,
                    ),
                    title: Text(
                      'shriharshkotecha.sk@gmail.com',
                      style: TextStyle(
                        fontFamily: 'SourceSans',
                        color: Colors.teal.shade900,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
