import 'package:flutter/material.dart';

void main() {
  runApp(RunMyApp());
}

class RunMyApp extends StatefulWidget {
  const RunMyApp({super.key});

  @override
  State<RunMyApp> createState() => _RunMyAppState();
}

class _RunMyAppState extends State<RunMyApp> {
  ThemeMode _themeMode = ThemeMode.system;

  // use this method to change the theme
  void changeTheme(ThemeMode themeMode) {
    setState(() {
      _themeMode = themeMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: Colors.white,
        cardColor: Colors.grey[200],
      ),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
        cardColor: Colors.grey[800],
      ),
      themeMode: _themeMode,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Theme Demo'),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              flex: 2,
              child: HomeScreen(),
            ),
            Expanded(
              flex: 1,
              child: SettingsScreen(changeTheme: changeTheme, themeMode: _themeMode),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: Card(
          margin: EdgeInsets.all(30),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            height: 160,
            width: 280,
            decoration: BoxDecoration(
              color: Theme.of(context).brightness == Brightness.light 
                  ? Colors.grey[300] 
                  : Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  'Mobile App Development Testing',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  final Function(ThemeMode) changeTheme;
  final ThemeMode themeMode;

  SettingsScreen({required this.changeTheme, required this.themeMode});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Choose the Theme:',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: 20),
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () => changeTheme(ThemeMode.light),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      color: themeMode == ThemeMode.light 
                          ? Colors.orange 
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.wb_sunny,
                          color: themeMode == ThemeMode.light 
                              ? Colors.white 
                              : Colors.orange,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Light',
                          style: TextStyle(
                            color: themeMode == ThemeMode.light 
                                ? Colors.white 
                                : Theme.of(context).textTheme.bodyMedium?.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10),
                GestureDetector(
                  onTap: () => changeTheme(ThemeMode.dark),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                    decoration: BoxDecoration(
                      color: themeMode == ThemeMode.dark 
                          ? Colors.indigo 
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.nightlight_round,
                          color: themeMode == ThemeMode.dark 
                              ? Colors.white 
                              : Colors.indigo,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Dark',
                          style: TextStyle(
                            color: themeMode == ThemeMode.dark 
                                ? Colors.white 
                                : Theme.of(context).textTheme.bodyMedium?.color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}