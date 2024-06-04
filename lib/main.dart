import 'package:bmi_calculator_rb/SplashScreen.dart';
import 'package:bmi_calculator_rb/about_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "BMI Calculator by RB",
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: const SplashScreen(),
    );
  }
}

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return MyHomeScreenState();
  }
}

class MyHomeScreenState extends State<MyHomeScreen> {
  var wtController = TextEditingController();
  var ftController = TextEditingController();
  var inController = TextEditingController();
  var result = "";
  var msg = "";
  var bgColor = Colors.lightBlue.shade100;

  @override
  Widget build(BuildContext context) {
    void calculateBMI() {
      var wt = wtController.text.toString();
      var ft = ftController.text.toString();
      var inch = inController.text.toString();

      if (wt != "" && ft != "" && inch != "") {
        // BMI Calculation
        var iWt = double.parse(wt);
        var iFt = int.parse(ft);
        var iInch = int.parse(inch);

        if ((iWt > 0) &&
            (iWt < 300) &&
            (iFt > 0) &&
            (iFt < 10) &&
            (iInch >= 0) &&
            (iInch < 12)) {
          var tInch = (iFt * 12) + iInch;
          var tCm = tInch * 2.54;
          var tM = tCm / 100;

          var bmi = iWt / (tM * tM);

          if (bmi > 25) {
            msg = "You're OverWeight!!!";
            bgColor = Colors.green.shade300;
          } else if (bmi < 18) {
            msg = "You're UnderWeight!!!";
            bgColor = Colors.red.shade600;
          } else {
            msg = "WOW! You're HEALTHY..!";
            bgColor = Colors.yellowAccent;
          }

          result = "$msg\n\nYour BMI is : ${bmi.toStringAsFixed(2)}";
        } else {
          bgColor = Colors.lightBlue.shade100;
          result = "Please, Enter valid parameters!";
        }

        setState(() {});
      } else {
        result = "Please, fill all the details!!";
        bgColor = Colors.lightBlue.shade100;

        setState(() {});
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "BMI Calculator",
          style: TextStyle(
              // fontFamily: "Josefin",
              fontWeight: FontWeight.bold),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.lightBlue.shade100,
                ),
                child: const Center(
                    child: Text(
                  "BMI Calculator",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ))),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return const MyHomeScreen();
                }));
              },
            ),
            ListTile(
              leading: const Icon(Icons.perm_identity),
              title: const Text("Author"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const AboutScreen();
                }));
              },
            ),
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: bgColor,
        child: Center(
          child: SizedBox(
            width: 300,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    children: [
                      // Padding(padding: EdgeInsets.only(top: 1)),

                      Text(
                        "B  M  I",
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        "C A L C U L A T O R",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
                      ),

                      Text(
                        "b y   R B   B h a t t i",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 24,
                      ),

                      TextField(
                        controller: wtController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          label: Text("Enter Weight(KG)"),
                          prefixIcon: Icon(Icons.line_weight),
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      TextField(
                        keyboardType: TextInputType.number,
                        controller: ftController,
                        decoration: const InputDecoration(
                          label: Text("Enter Height(ft) "),
                          prefixIcon: Icon(Icons.height),
                        ),
                      ),

                      const SizedBox(
                        height: 10,
                      ),

                      TextField(
                        keyboardType: TextInputType.number,
                        controller: inController,
                        decoration: const InputDecoration(
                          label: Text("Enter Height(inch)"),
                          prefixIcon: Icon(Icons.height),
                        ),
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      ElevatedButton(
                        onPressed: calculateBMI,
                        child: const Text(
                          "Calculate",
                          style: TextStyle(
                            // fontFamily: "Josefin",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 30,
                      ),

                      Text(
                        result,
                        style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Josefin"),
                      ),

                      // Padding(padding: EdgeInsets.only(bottom: 1)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
