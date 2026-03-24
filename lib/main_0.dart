import 'package:flutter/material.dart';
import 'package:recepieapp/Theme/app_colors.dart';
import 'package:recepieapp/Theme/app_theme.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  int counter = 0;
  void incrementCounter() {
    setState(() {
      counter = counter + 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: Text(
          "Recepie App",
          style: Theme.of(context).textTheme.displayLarge
        ),
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Text(
                    "Chicken Biryani",
                    style: Theme.of(context).textTheme.displayMedium!.copyWith(color: Colors.white),
                  ),
                  const Text(
                    "You have pressed the button this times",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                  Text(
                    "$counter",
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.pink.shade100,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => incrementCounter(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
