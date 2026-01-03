import 'package:flutter/material.dart';
import '../models/user.dart';
import '../utils/token_storage.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;

  @override
  void initState() {
    super.initState();
    loadUser();
  }

  void loadUser() async {
    final data = await TokenStorage.getUser();
    setState(() => user = data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Profile")),
      body: user == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Nama: ${user!.name}", style: TextStyle(fontSize: 18)),
                  SizedBox(height: 8),
                  Text("Email: ${user!.email}"),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () async {
                      await TokenStorage.logout();
                      Navigator.pushReplacementNamed(context, '/login');
                    },
                    child: Text("Logout"),
                  ),
                ],
              ),
            ),
    );
  }
}
