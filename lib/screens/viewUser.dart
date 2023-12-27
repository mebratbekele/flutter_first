import 'package:flutter/material.dart';
import 'package:security_system/model/User.dart';
import 'package:url_launcher/url_launcher.dart';

class ViewUser extends StatefulWidget {
  final UserDetail user;

  const ViewUser({Key? key, required this.user}) : super(key: key);

  @override
  State<ViewUser> createState() => _ViewUserState();
}

class _ViewUserState extends State<ViewUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("SQLite CRUD"),
        ),
        body: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                " Detail Informations",
                style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: Colors.blueGrey,
                    fontSize: 30),
              ),
              Divider(),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text('Name :',
                      style: TextStyle(
                          color: Colors.teal,
                          fontSize: 22,
                          fontWeight: FontWeight.w600)),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(widget.user.name ?? '',
                        style: TextStyle(fontSize: 20, color: Colors.black)),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text('Contact :',
                      style: TextStyle(
                          color: Colors.teal,
                          fontSize: 22,
                          fontWeight: FontWeight.w600)),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: TextButton(
                      onPressed: () async {
                        // Handle tapping on contact information
                        final url =
                            'tel:${widget.user.contact}'; // Construct phone call URL
                        // if (await canLaunch(url)) {
                        //   // Check if call can be launched
                        await launch(url); // Initiate phone call
                        // } else {
                        // Handle failure to launch call
                        // print('Unable to launch call: ${widget.user.contact}');
                        //}
                      },

                      // ignore: sort_child_properties_last
                      child: Row(
                        children: [
                          const Icon(Icons.phone),
                          Text(
                            widget.user.contact ?? '',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                        backgroundColor: Colors.white,
                        padding: EdgeInsets.all(10.0),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Description :',
                      style: TextStyle(
                          color: Colors.teal,
                          fontSize: 22,
                          fontWeight: FontWeight.w600)),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Text(widget.user.description ?? '',
                        style:
                            const TextStyle(fontSize: 20, color: Colors.black)),
                  )
                ],
              )
            ],
          ),
        ));
  }
}
