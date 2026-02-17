import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Munib"),
            accountEmail: Text("munib@example.com"),
            currentAccountPicture: CircleAvatar(
              child: Icon(Icons.person, size: 40),
            ),
          ),

          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text("Dashboard"),
            onTap: () {
              Navigator.pushReplacementNamed(context, "/");
            },
          ),

          ListTile(
            leading: Icon(Icons.work),
            title: Text("Job List"),
            onTap: () {
              Navigator.pushReplacementNamed(context, "/job");
            },
          ),

          ListTile(
            leading: Icon(Icons.add),
            title: Text("Add Job"),
            onTap: () {
              Navigator.pushReplacementNamed(context, "/addJob");
            },
          ),

          ListTile(
            leading: Icon(Icons.info),
            title: Text("Job Detail"),
            onTap: () {
              Navigator.pushReplacementNamed(context, "/detail");
            },
          ),
        ],
      ),
    );
  }
}
