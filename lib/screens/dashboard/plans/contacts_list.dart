import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

import '../../../utils/theme.dart';

class ContactList extends StatefulWidget {
  final List<Contact> selectedContacts;

  const ContactList({Key? key, required this.selectedContacts})
      : super(key: key);

  @override
  _ContactListState createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  List<Contact>? contacts;
  List<Contact> selectedContacts = [];
  String searchQuery = '';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getContact();
    selectedContacts = List.from(widget.selectedContacts);
  }

  void getContact() async {
    setState(() {
      isLoading = true;
    });

    if (await FlutterContacts.requestPermission()) {
      contacts = await FlutterContacts.getContacts(
        withProperties: true,
        withPhoto: true,
      );
      // print(contacts);
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  List<Contact> getFilteredContacts() {
    if (searchQuery.isEmpty) {
      return contacts ?? [];
    } else {
      return contacts
              ?.where((contact) => contact.displayName
                  .toLowerCase()
                  .contains(searchQuery.toLowerCase()))
              .toList() ??
          [];
    }
  }

  void toggleSelection(Contact contact) {
    setState(() {
      if (selectedContacts.contains(contact)) {
        selectedContacts.remove(contact);
      } else {
        selectedContacts.add(contact);
      }
    });
  }

  bool isContactSelected(Contact contact) {
    return selectedContacts.contains(contact);
  }

  @override
  Widget build(BuildContext context) {
    final filteredContacts = getFilteredContacts();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      // appBar: AppBar(
      //   title: const Text('Contacts List'),
      // ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'assets/icons/back.png',
                      width: 30,
                    ),
                  ),
                  Text(
                    'Contact List',
                    style: displayNormalBiggerSlightlyBoldBlack,
                  ),
                  Container(width: 30),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 48,
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'Search Contacts',
                    labelStyle: displayNormalGrey1,
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.grey.shade300,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : filteredContacts.isEmpty
                        ? const Center(child: Text('No contacts found'))
                        : ListView.builder(
                            itemCount: filteredContacts.length,
                            itemBuilder: (BuildContext context, int index) {
                              final contact = filteredContacts[index];
                              Uint8List? image = contact.photo;
                              String num = contact.phones.isNotEmpty
                                  ? contact.phones.first.number
                                  : "--";
                              final isSelected = isContactSelected(contact);

                              return ListTile(
                                leading: contact.photo == null
                                    ? const CircleAvatar(
                                        child: Icon(Icons.person))
                                    : CircleAvatar(
                                        backgroundImage: MemoryImage(image!),
                                      ),
                                title: Text(
                                  contact.displayName,
                                  style: TextStyle(
                                    color: isSelected ? Colors.grey : null,
                                  ),
                                ),
                                subtitle: Text(
                                  num,
                                  style: TextStyle(
                                    color: isSelected ? Colors.grey : null,
                                  ),
                                ),
                                trailing: Checkbox(
                                  value: isSelected,
                                  onChanged: (bool? value) {
                                    toggleSelection(contact);
                                  },
                                ),
                                enabled: true,
                              );
                            },
                          ),
              ),
              if (selectedContacts.isNotEmpty) ...[
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context, selectedContacts),
                    child: const Text('CONFIRM'),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
