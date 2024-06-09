import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class AddContactPage extends StatefulWidget {
  const AddContactPage({super.key});
  @override
  _AddContactPageState createState() => _AddContactPageState();
}

class _AddContactPageState extends State<AddContactPage> {
  String? firstname;
  String? lastname;
  String? email;
  String? phone;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Add Contact",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    firstnameField,
                    lastnameField,
                    emailField,
                    numberField,
                    addContactButton
                  ])),
        ));
  }

  // Requires Firstname and Lastname field to have an input
  Widget get firstnameField => Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text("First Name"),
          ),
          onSaved: (value) => setState(() => firstname = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter a first name";
            }
            return null;
          },
        ),
      );

  Widget get lastnameField => Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text("Last Name"),
          ),
          onSaved: (value) => setState(() => lastname = value),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return "Please enter a last name";
            }
            return null;
          },
        ),
      );

  //
  Widget get emailField => Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text("Email"),
          ),
          onSaved: (value) => setState(() => email = value),
          validator: (value) {
            if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
                    .hasMatch(value!) &&
                value.isNotEmpty) {
              return 'Please submit a valid email address';
            }
            return null;
          },
        ),
      );

  Widget get numberField => Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text("Phone Number"),
          ),
          onSaved: (value) => setState(() => phone = value),
          validator: (value) {
            return null;
          },
        ),
      );

  Widget get addContactButton => Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              _formKey.currentState!.save();
              final newContact = Contact()
                ..name.first = firstname!
                ..name.last = lastname!
                ..phones = [Phone(phone!)]
                ..emails = [Email(email!)];
              await newContact.insert();

              if (context.mounted) Navigator.pop(context);
            }
          },
          child: const Text("Add")));
}

/*
,*/
