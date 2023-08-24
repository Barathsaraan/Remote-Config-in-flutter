// main.dart
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Demo Project',
        theme: ThemeData(
          primarySwatch: Colors.yellow,
        ),
        home: const HomeScreen());
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
  Future<void> _initConfig() async {
    await _remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 1),
      minimumFetchInterval: const Duration(seconds: 2),
    ));

    _fetchConfig();
  }

  // Fetching, caching, and activating remote config
  void _fetchConfig() async {
    await _remoteConfig.fetchAndActivate();
  }

  @override
  void initState() {
    _initConfig();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(50),
            child: Text(
              _remoteConfig.getString('banner_text'),
              style: const TextStyle(fontSize: 30),
            ),
          ),
        ),
      ),
    );
  }
}

// import 'package:firebase_remote_config/firebase_remote_config.dart';

// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(
//     MaterialApp(
//       title: "Remote Config",
//       home: FutureBuilder<Remoteconfig>(
//         future: setupRemoteConfig(),
//         builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
//           return snapshot.hasData
//               ? Home(remoteConfig: snapshot.requireData)
//               : Container(
//                   child: Text("HAi Everyone there is no data Available"),
//                 );
//         },
//       ),
//     ),
//   );
// }

// class Home extends AnimatedWidget {
//   final RemoteConfig remoteConfig;
//   Home({required this.remoteConfig}) : super(listenable: remoteConfig);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Remote Config'),
//       ),
//       body: Column(
//         children: [
//           Image.network(""),
//           Text("data"),
//           Text("data"),
//           Text("data"),
//         ],
//       ),
//     );
//   }
// }

// Future<RemoteConfig> setupRemoteConfig() async {
//   final remoteconfig = RemoteConfig.instance;
//   await remoteconfig.fetch();
//   await remoteconfig.activate();
//   print(remoteconfig.getString(""));
//   return remoteconfig;
// }
