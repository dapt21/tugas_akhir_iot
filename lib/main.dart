import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ta_iot/displayData.dart';
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
    DatabaseReference refNitrit = FirebaseDatabase.instance.ref("displayNitrit");
    DatabaseReference refSuhu = FirebaseDatabase.instance.ref("displaySuhu");
    DatabaseReference refKelembaban = FirebaseDatabase.instance.ref("displayKelembaban");

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
        stream: refNitrit.onValue,
        builder: (context, dataNitrit) {
          return StreamBuilder(
            stream: refSuhu.onValue,
            builder: (context, dataSuhu) {
              return StreamBuilder(
                stream: refKelembaban.onValue,
                builder: (context, dataKelembaban) {
                  if(dataNitrit.hasData && dataSuhu.hasData && dataKelembaban.hasData){
                    var displayNitrit = dataNitrit.data!.snapshot.children.toList();
                    int nitritAtas = int.parse(displayNitrit[0].value.toString());
                    int nitritBawah = int.parse(displayNitrit[1].value.toString());
                    int nitritTengah = int.parse(displayNitrit[2].value.toString());
                    bool cekNitrit = ((nitritAtas + nitritTengah + nitritBawah) / 3) < 15;

                    var displaySuhu = dataSuhu.data!.snapshot.children.toList();
                    int suhuAtas = int.parse(displaySuhu[0].value.toString());
                    int suhuBawah = int.parse(displaySuhu[1].value.toString());
                    int suhuTengah = int.parse(displaySuhu[2].value.toString());
                    bool cekSuhu = ((suhuAtas + suhuTengah + suhuBawah) / 3) >= 26 && ((suhuAtas + suhuTengah + suhuBawah) / 3) <= 29;

                    var displayKelembaban = dataKelembaban.data!.snapshot.children.toList();
                    int kelembabanAtas = int.parse(displayKelembaban[0].value.toString());
                    int kelembabanBawah = int.parse(displayKelembaban[1].value.toString());
                    int kelembabanTengah = int.parse(displayKelembaban[2].value.toString());
                    bool cekKelembaban = ((kelembabanAtas + kelembabanTengah + kelembabanBawah) / 3) >= 75 &&
                      ((kelembabanAtas + kelembabanTengah + kelembabanBawah) / 3) <= 95;
                    return Column(
                    children: [
                      Flexible(
                        child: DisplayData(
                          data1: nitritAtas, 
                          data2: nitritTengah, 
                          data3: nitritBawah, 
                          teks: "Nitrit", 
                          cek: cekNitrit
                        ),
                      ),
                      Flexible(
                        child: DisplayData(
                          data1: suhuAtas, 
                          data2: suhuTengah, 
                          data3: suhuBawah, 
                          teks: "Suhu", 
                          cek: cekSuhu
                        ),
                      ),
                      Flexible(
                        child: DisplayData(
                          data1: kelembabanAtas, 
                          data2: kelembabanTengah, 
                          data3: kelembabanBawah, 
                          teks: "Kelembaban", 
                          cek: cekKelembaban
                        ),
                      ),
                    ],
                  );
                  } else{
                    return Center(child: CircularProgressIndicator());
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}