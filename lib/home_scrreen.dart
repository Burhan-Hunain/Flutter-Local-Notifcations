import 'package:flutter/material.dart';
import 'package:hello/messaging/service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final NotificationService _notificationService = NotificationService();
  bool _isScheduled = false;

  @override
  void initState() {
    super.initState();
    _checkNotificationStatus();
  }

  void _checkNotificationStatus() async {
    // You can check if notification is scheduled using shared preferences
    // For simplicity, we'll just track it in state
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Notification Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.notifications_active,
              size: 80,
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            Text('Daily Notification', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(  'Get a notification every day at 8 PM',  style: TextStyle(fontSize: 16, color: Colors.grey),),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                await _notificationService.schedule8PMNotification();
                setState(() {
                  _isScheduled = true;
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Daily notification scheduled successfully'),

                    // Text('Daily notification scheduled for {$NotificationService.}'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: Text(
                'Schedule Daily Notification',
                style: TextStyle(fontSize: 18),
              ),
            ),

            ElevatedButton(
              onPressed: () async {
                print("LALALAL");
                await _notificationService.showTestNotificationIn10Seconds();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Test notification will appear in 10 seconds'),
                  ),
                );
              },
              child: const Text('Test Notification (10s)'),
            ),

            
            SizedBox(height: 20),
            if (_isScheduled)
              Text(
                '✓ Notification scheduled',
                style: TextStyle(color: Colors.green, fontSize: 16),
              ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () async {
                print("LALALAL");

                await _notificationService.cancelAllNotifications();
                setState(() {
                  _isScheduled = false;
                });
                print("LALALALAOOOOO");

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('All notifications cancelled!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: Text('Cancel All Notifications'),
            ),
          ],
        ),
      ),
    );
  }
}