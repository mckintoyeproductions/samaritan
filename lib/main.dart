import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'app_router.dart';


// import your router or home screen as you already do
// import 'app_router.dart'; // example

Future<void> _initFirebase() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase for the current platform (iOS/Android/Web)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Ensure we are authenticated for Firestore rules that require auth != null
  final auth = FirebaseAuth.instance;
  if (auth.currentUser == null) {
    await auth.signInAnonymously();
  }
}

void main() async {
  try {
    await _initFirebase();
  } catch (e, st) {
    // If something goes wrong during init, it’s helpful to see it in logs.
    // On web you’ll see this in the browser console.
    // You can also render a minimal error app if you prefer.
    // ignore: avoid_print
    print('Firebase init error: $e\n$st');
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Samaritan',
      // If you use GoRouter, replace with MaterialApp.router and your router.
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF5E60CE),
        useMaterial3: true,
      ),
      // home: YourHomeScreen(), // or MaterialApp.router(routerConfig: router)
      home: const _Bootstrap(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// Optional little gate that waits for FirebaseAuth to be ready (esp. on web)
class _Bootstrap extends StatelessWidget {
  const _Bootstrap({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'SamaritanApp',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        scaffoldBackgroundColor: Colors.grey.shade100,
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}
