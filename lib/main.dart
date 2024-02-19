import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'My App.dart';

Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey:  "AIzaSyB5bkaQWUrEjL-gSvSNPQ1yRieetBOCYUE",
        appId: "1:718471820672:android:f992e8f292a25a96bebd65",
        messagingSenderId: "718471820672",
        storageBucket: "investment-78a9e.appspot.com",
        projectId: "investment-78a9e")
  );

  runApp(const MyApp());
}



/*

 */