import 'package:exer7/pages/add_contact.dart';
import 'package:exer7/pages/edit_contact.dart';
import 'package:flutter/material.dart';
import 'pages/contactslist_page.dart';
import 'pages/display_contact.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => ContactslistPage(),
        '/contact': (context) => ContactPage(),
        '/editcontact': (context) => EditContactPage(),
        '/addcontact': (context) => AddContactPage(),
      },
    );
  }
}

