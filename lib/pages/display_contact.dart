import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactPage extends StatefulWidget {
  @override
  _ContactPageState createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {

  @override
  Widget build(BuildContext context){

    final contact = ModalRoute.of(context)!.settings.arguments as Contact;

    return Scaffold(
      appBar: AppBar(title: Text(contact.displayName)),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('First name: ${contact.name.first}'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Last name: ${contact.name.last}'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                'Phone number: ${contact.phones.isNotEmpty ? contact.phones.first.number : '(none)'}'),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
                'Email address: ${contact.emails.isNotEmpty ? contact.emails.first.address : '(none)'}'),
          ),
          ElevatedButton(
            onPressed: () async {
              await contact.delete();
              if (mounted) Navigator.pop(context);
            }, 
            child: const Text("Delete")
          ),
          ElevatedButton(
            onPressed: () async {
              if (context.mounted) {
                Navigator.of(context).pushNamed(
                  '/editcontact',
                  arguments: contact,
                );
              }
            },
            child: const Text("Edit")
          ),
        ]),
      ));
  }
}