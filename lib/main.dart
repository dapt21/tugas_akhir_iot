import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    ),
  );
}


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    DatabaseReference refDisplay = FirebaseDatabase.instance.ref("display");

    return Scaffold(
      backgroundColor: Color(0xFFFCFCFC),
      appBar: AppBar(
        backgroundColor: Color(0xFF08D9D6),
        title: Text(
          "IoT Sarang Burung Walet",
          style: GoogleFonts.comicNeue(
            color: Color(0xFF252A34),
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: refDisplay.onValue,
        builder: (context, snapshot) {
          var dataDisplay = snapshot.data?.snapshot.children.toList();
          String kelembaban = dataDisplay?[0].value.toString() ?? "0";
          String nitrit = dataDisplay?[1].value.toString() ?? "0";
          String suhu = dataDisplay?[2].value.toString() ?? "0";
          
          return Column(
            children: [
              Flexible(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    //Nitrit
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 18),
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                        color: int.parse(nitrit) < 15 ? Color(0xFF08D9D6) : Color(0xFFFF2E63),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            nitrit,
                            style: GoogleFonts.comicNeue(
                              fontSize: 50,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "Nitrit",
                            style: GoogleFonts.comicNeue(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Suhu
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 18),
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      decoration: BoxDecoration(
                        color: int.parse(suhu) >= 26 && int.parse(suhu) <= 29 ? Color(0xFF08D9D6) : Color(0xFFFF2E63),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            suhu,
                            style: GoogleFonts.comicNeue(
                              fontSize: 50,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "Suhu",
                            style: GoogleFonts.comicNeue(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    //Kelembaban
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 18),
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      decoration: BoxDecoration(
                        color: int.parse(kelembaban) >= 75 && int.parse(kelembaban) <= 95 ? Color(0xFF08D9D6) : Color(0xFFFF2E63),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            kelembaban,
                            style: GoogleFonts.comicNeue(
                              fontSize: 50,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            "Kelembaban",
                            style: GoogleFonts.comicNeue(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Flexible(
                flex: 6,
                child: Center(child: Text("Coming soon"))
              )
            ],
          );
        },
      ),
    );
  }
}