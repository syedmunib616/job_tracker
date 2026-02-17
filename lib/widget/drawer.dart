import 'package:flutter/material.dart';
// class AppDrawer extends StatelessWidget {
//   const AppDrawer({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     return Drawer(
//       child: Column(
//         children: [
//           // 🔥 TOP PROFILE HEADER
//           Container(
//             height: 220,
//             width: double.infinity,
//             padding: EdgeInsets.only(top: 40),
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [Colors.deepPurple, Colors.blueAccent],
//                 begin: Alignment.topLeft,
//                 end: Alignment.bottomRight,
//               ),
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(30),
//                 bottomRight: Radius.circular(30),
//               ),
//             ),
//             child: Column(
//               children: [
//                 CircleAvatar(
//                   radius: 45,
//                   backgroundColor: Colors.white,
//                   child: Icon(Icons.person, size: 50, color: Colors.black),
//                 ),
//                 SizedBox(height: 10),
//                 Text(
//                   "Munib",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold),
//                 ),
//                 Text(
//                   "munib@example.com",
//                   style: TextStyle(color: Colors.white70),
//                 ),
//               ],
//             ),
//           ),
//
//           // MENU ITEMS
//           Expanded(
//             child: ListView(
//               children: [
//                 drawerItem(Icons.dashboard, "Dashboard", () {
//                   Navigator.pushReplacementNamed(context, "/");
//                 }),
//
//                 drawerItem(Icons.work, "Job List", () {
//                   Navigator.pushReplacementNamed(context, "/job");
//                 }),
//
//                 drawerItem(Icons.add, "Add Job", () {
//                   Navigator.pushReplacementNamed(context, "/addJob");
//                 }),
//
//                 drawerItem(Icons.info, "Job Detail", () {
//                   Navigator.pushReplacementNamed(context, "/detail");
//                 }),
//
//                 Divider(),
//
//                 drawerItem(Icons.logout, "Logout", () {}),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget drawerItem(IconData icon, String title, VoidCallback onTap) {
//     return ListTile(
//       leading: Icon(icon, color: Colors.deepPurple),
//       title: Text(title, style: TextStyle(fontSize: 16)),
//       onTap: onTap,
//     );
//   }
// }
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
        ),
        child: Column(
          children: [
            // 🔥 TOP PROFILE HEADER
            Container(
              height: 220,
              width: double.infinity,
              padding: EdgeInsets.only(top: 40),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.2),
                    blurRadius: 20,
                  ),
                ],
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.white.withOpacity(0.1),
                    child: Icon(Icons.person, size: 50, color: Colors.white),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Munib",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    "munib@example.com",
                    style: TextStyle(color: Colors.white70),
                  ),
                ],
              ),
            ),

            // MENU ITEMS
            Expanded(
              child: ListView(
                children: [
                  drawerItem(context, Icons.dashboard, "Dashboard", "/"),
                  drawerItem(context, Icons.work, "Job List", "/job"),
                  drawerItem(context, Icons.add, "Add Job", "/addJob"),
                  drawerItem(context, Icons.info, "Job Detail", "/detail"),

                  Divider(color: Colors.white24),

                  drawerItem(context, Icons.logout, "Logout", "/login"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget drawerItem(
      BuildContext context, IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          letterSpacing: 1.1,
        ),
      ),
      onTap: () {
        Navigator.pushReplacementNamed(context, route);
      },
      hoverColor: Colors.white10,
    );
  }
}

// class AppDrawer extends StatelessWidget {
//   const AppDrawer({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: [
//           UserAccountsDrawerHeader(
//             accountName: Text("Munib"),
//             accountEmail: Text("munib@example.com"),
//             currentAccountPicture: CircleAvatar(
//               child: Icon(Icons.person, size: 40),
//             ),
//           ),
//
//           ListTile(
//             leading: Icon(Icons.dashboard),
//             title: Text("Dashboard"),
//             onTap: () {
//               Navigator.pushReplacementNamed(context, "/");
//             },
//           ),
//
//           ListTile(
//             leading: Icon(Icons.work),
//             title: Text("Job List"),
//             onTap: () {
//               Navigator.pushReplacementNamed(context, "/job");
//             },
//           ),
//
//           ListTile(
//             leading: Icon(Icons.add),
//             title: Text("Add Job"),
//             onTap: () {
//               Navigator.pushReplacementNamed(context, "/addJob");
//             },
//           ),
//
//           ListTile(
//             leading: Icon(Icons.info),
//             title: Text("Job Detail"),
//             onTap: () {
//               Navigator.pushReplacementNamed(context, "/detail");
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
