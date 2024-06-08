// TODO Implement this library.
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactslistPage extends StatefulWidget {
  const ContactslistPage({super.key});

  @override
  State<ContactslistPage> createState() => _ContactslistPageState();
}

class _ContactslistPageState extends State<ContactslistPage> {
  List<Contact>? _contacts;
  bool _permissionDenied = false;

  @override
  void initState() {
    super.initState();
    initialize();
  }

  void initialize() {
    FlutterContacts.addListener(() => _fetchContacts());
    _fetchContacts();
  }

  Future _fetchContacts() async {
    if (!await FlutterContacts.requestPermission()) {
      setState(() => _permissionDenied = true);
    } else {
      var contacts = await FlutterContacts.getContacts(withAccounts: true);
      setState(() => _contacts = contacts);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Own Contacts App'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add),
              tooltip: 'Add new Contacts',
              onPressed: () {
                if (context.mounted) {
                Navigator.of(context).pushNamed(
                  '/addcontact',
                );
              }
              }
            )
          ],
        ),
        body: _body());
  }

  Widget _body() {
    if (_permissionDenied) {
      return const Center(child: Text('Permission denied'));
    }
    if (_contacts == null) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
        itemCount: _contacts!.length,
        itemBuilder: (context, i) => ListTile(
            title: Text(_contacts![i].displayName),
            onTap: () async {
              final fullContact =
                  await FlutterContacts.getContact(_contacts![i].id, withAccounts: true);
              if (context.mounted) {
                Navigator.of(context).pushNamed(
                  '/contact',
                  arguments: fullContact,
                );
              }
            }));
  }
}

