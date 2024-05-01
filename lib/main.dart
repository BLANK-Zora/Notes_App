import 'package:flutter/material.dart';
import 'package:flutter_application_3/models/note_database.dart';
import 'package:flutter_application_3/pages/notes_page.dart';
import 'package:flutter_application_3/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  //Initialize the notes db
  WidgetsFlutterBinding.ensureInitialized();
  await NoteDatabase.initialize();
  runApp(
    MultiProvider(
      providers: [
        //Note provider
        ChangeNotifierProvider(create: (context) => NoteDatabase()),

        //Theme Provider
        ChangeNotifierProvider(create: (context) => ThemeProvider())
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    print(Provider.of<ThemeProvider>(context).themeData);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Notespage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
