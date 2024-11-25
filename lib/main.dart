import 'package:app_life_cycle/sociallogin/socialLogin.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage((message)=> notificationBackground(message));
  runApp(const MyApp());
}

///Top Level Function for Notification
///Background Notification
///
@pragma('vm:entry-point')
Future<void> notificationBackground(RemoteMessage message) async{
  await Firebase.initializeApp();

}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: SocialLogin(),
    );
  }
}

class LifecycleExample extends StatefulWidget {
  final String keyValue; // Define the keyValue property in the widget class

  // Constructor
  LifecycleExample({Key? key, required this.keyValue}) : super(key: key);

  @override
  _LifecycleExampleState createState() => _LifecycleExampleState();
}

class _LifecycleExampleState extends State<LifecycleExample> {
  String _message = "Initial message";
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    _message = "Widget Created";
    print("initState called");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print("didChangeDependencies called");
  }

  @override
  void didUpdateWidget(covariant LifecycleExample oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Called when the widget's configuration changes
    if (oldWidget.keyValue != widget.keyValue) {
      print("didUpdateWidget called with new keyValue: ${widget.keyValue}");
      setState(() {
        _message = "Key Value Changed!";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("build called");
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_message),
            SizedBox(height: 20),
            Text("Counter: $_counter"),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _counter++;
                  _message = "Counter has been incremented!";
                });
              },
              child: Text("Increment Counter"),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactivate called");
  }

  @override
  void dispose() {
    super.dispose();
    print("dispose called");
  }
}



///AppLIFECYCLE
///
///
///
// class AppLifecycleDisplay extends StatefulWidget {
//   const AppLifecycleDisplay({super.key});
//
//   @override
//   State<AppLifecycleDisplay> createState() => _AppLifecycleDisplayState();
// }
//
// class _AppLifecycleDisplayState extends State<AppLifecycleDisplay> {
//   late final AppLifecycleListener _listener;
//   final ScrollController _scrollController = ScrollController();
//   final List<String> _states = <String>[];
//   late AppLifecycleState? _state;
//
//   @override
//   void initState() {
//     super.initState();
//     _state = SchedulerBinding.instance.lifecycleState;
//     _listener = AppLifecycleListener(
//       onShow: () => _handleTransition('show'),
//       onResume: () => _handleTransition('resume'),
//       onHide: () => _handleTransition('hide'),
//       onInactive: () => _handleTransition('inactive'),
//       onPause: () => _handleTransition('pause'),
//       onDetach: () => _handleTransition('detach'),
//       onRestart: () => _handleTransition('restart'),
//       onStateChange: _handleStateChange,
//     );
//     if (_state != null) {
//       _states.add(_state!.name);
//     }
//   }
//
//   @override
//   void dispose() {
//     _listener.dispose();
//     super.dispose();
//   }
//
//   void _handleTransition(String name) {
//     setState(() {
//       _states.add(name);
//     });
//     _scrollController.animateTo(
//       _scrollController.position.maxScrollExtent,
//       duration: const Duration(milliseconds: 200),
//       curve: Curves.easeOut,
//     );
//   }
//
//   void _handleStateChange(AppLifecycleState state) {
//     setState(() {
//       _state = state;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('App LifeCycle State'),
//           elevation: 0,
//         ),
//         body: Center(
//           child: SizedBox(
//             width: 300,
//             child: SingleChildScrollView(
//               controller: _scrollController,
//               child: Column(
//                 children: <Widget>[
//                   Text('Current State: ${_state ?? 'Not initialized yet'}'),
//                   const SizedBox(height: 30),
//                   Text('State History:\n  ${_states.join('\n  ')}'),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }


