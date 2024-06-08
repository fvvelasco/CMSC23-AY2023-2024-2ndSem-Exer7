import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';


class EditContactPage extends StatefulWidget {
  const EditContactPage({super.key});
  @override
  _EditContactPageState createState() => _EditContactPageState();
}

class _EditContactPageState extends State<EditContactPage>{
    String? firstname;
    String? lastname;
    String? email;
    String? phone;
    final _formKey = GlobalKey<FormState>();
    
  @override
  Widget build(BuildContext context){

    final contact = ModalRoute.of(context)!.settings.arguments as Contact;
    firstname = contact.name.first;
    lastname = contact.name.last;
    phone = contact.phones.first.number;
    email = contact.emails.first.address;


    return Scaffold(
      appBar: AppBar(title: const Text("Edit Contact")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key:_formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, 
            children: [
              firstnameField,
              lastnameField,
              emailField,
              numberField,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        contact.name.first = firstname!;
                        contact.name.last = lastname!;
                        contact.phones.first.number = phone!;
                        contact.emails.first.address = email!;
                        await contact.update();
                        if (mounted) Navigator.pop(context);
                      }
                    },
                    child: const Text("Update Contact")
                  )

              )
            ]
          )
        ),
      )
    );
  }

  Widget get firstnameField => Padding(
    padding: const EdgeInsets.all(8.0),
    child:
      TextFormField(
        initialValue: firstname,
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
    child:
      TextFormField(
        initialValue: lastname,
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
  
  Widget get emailField => Padding(
    padding: const EdgeInsets.all(8.0),
    child: 
      TextFormField(
        initialValue: email,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text("Email"),
          ),
          onSaved: (value) => setState(() => email = value),
          validator: (value) {
          if (!RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$').hasMatch(value!) && value.isNotEmpty)
          {
            return 'Please submit a valid email address';
          }
          return null;
          },
      ),
  );

  Widget get numberField => Padding(
    padding: const EdgeInsets.all(8.0),
    child: 
      TextFormField(
        initialValue: phone,
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
  
}