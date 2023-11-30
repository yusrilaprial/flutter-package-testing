import 'package:flutter/material.dart';
import 'package:testing/screen/home_screen.dart';

void main() {
  runApp(const MyApp());
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
        home: const HomeScreen());
  }
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Contoh Testing App")),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    color: Colors.amber,
                  ),
                  Container(
                    width: 100,
                    height: 90,
                    color: Colors.black,
                  ),
                  Container(
                    width: 20,
                    height: 20,
                    color: Colors.blue,
                  )
                ],
              ),
              Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                      color: Colors.greenAccent,
                      borderRadius: BorderRadius.circular(10)),
                  // color: Colors.amberAccent,
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                          width: 100,
                          height: 100,
                          child: Image(
                            image: AssetImage("assets/astral 1.jpg"),
                            fit: BoxFit.cover,
                          )),
                      Text(
                        "data",
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: Icon(Icons.abc_outlined, size: 80),
                      )
                    ],
                  ))
            ],
          ),
        ));
  }
}
