import 'package:flutter/material.dart';
import 'package:students_details/Screens/studentdetailsscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        
      ),
      // home: const StudentDetails(),
      home: SidebarLayout(currentScreen: const StudentDetails()),
    );
  }
}

class SidebarLayout extends StatelessWidget {
  final Widget currentScreen;

  const SidebarLayout({Key? key, required this.currentScreen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Drawer(
            child: ListView(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.teal,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(
                          'https://example.com/your_profile_image.jpg',
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Your Name',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: const Text('Home'),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    // Navigate to the home screen (StudentDetails)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StudentDetails(),
                      ),
                    );
                  },
                ),
                // Add more ListTile items for other screens or functionalities
              ],
            ),
          ),
          Expanded(
            child: currentScreen,
          ),
        ],
      ),
    );
  }
}
