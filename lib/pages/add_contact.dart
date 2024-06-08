import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class AddContactPage extends StatefulWidget {
  @override
  _AddContactPageState createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage>{
  @override
  Widget build(BuildContext context){

    Contact _contact;

    return Scaffold(
      appBar: AppBar(title: Text("Add Contact")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          ElevatedButton(
            onPressed: () async {
              final newContact = Contact()
              ..name.first = 'John'
              ..name.last = 'Smith'
              ..phones = [Phone('555-123-4567')]
              ..emails = [Email('email@email.com')];
              await newContact.insert();
              Navigator.of(context).pop();
            },
            child: const Text("Add")
          ),
        ]),
      )
    );
  }
}