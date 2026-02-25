import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_tracker/features/auth/view_models/auth_view_model.dart';
import 'package:job_tracker/core/constants/app_colors.dart';

class AppDrawer extends  ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {


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
                color: AppColors.textSecondary,
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
                  drawerItem(context, Icons.dashboard, "Dashboard", "/auth"),
                  drawerItem(context, Icons.work, "Job List", "/jobs"),
                 // drawerItem(context, Icons.add, "Add Job", "/addJob"),
                  drawerItem(context, Icons.info, "Job Detail", "/detail"),
                  drawerItem(context, Icons.settings, "Settings", "/settings"),
                  drawerItem(context, Icons.timer, "Opt Setup", "/optedit"),
                  Divider(color: Colors.white24),

                  // drawerItem(context, Icons.logout, "Logout", "/login"),
                  ListTile(
                    leading: Icon(Icons.logout, color: Colors.white),
                    title: Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        letterSpacing: 1.1,
                      ),
                    ),
                    onTap: () {
                      ref.read(authViewModelProvider.notifier).logout();
                    },
                    hoverColor: Colors.white10,
                  )
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
