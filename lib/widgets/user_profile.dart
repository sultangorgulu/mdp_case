import 'package:flutter/material.dart';
import 'package:mdp_case/models/user.dart';
import '../api_service.dart'; 

class UserProfileWidget extends StatefulWidget {
  const UserProfileWidget({super.key});

  @override
  _UserProfileWidgetState createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends State<UserProfileWidget> {
  late Future<User> futureUser;

  @override
  void initState() {
    super.initState();
    futureUser = fetchUserData(); 
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User>(
      future: futureUser,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          User user = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 32),
                CircleAvatar(
                  radius: 50, 
                  backgroundImage: NetworkImage(user.image),
                  onBackgroundImageError: (exception, stackTrace) {
                    print('Error loading profile image: $exception');
                  },
                ),
                const SizedBox(width: 24), 
                
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center, 
                    children: [
                      Text(
                        '${user.firstName} ${user.lastName}',
                        style: TextStyle(
                          color: Colors.indigo[300],
                          fontSize: 17, 
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 7), 
                      Text(
                        user.email,
                        style: const TextStyle(
                          fontSize: 13, 
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text('User not found'));
        }
      },
    );
  }
}
