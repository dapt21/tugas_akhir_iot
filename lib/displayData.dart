import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

class DisplayData extends StatefulWidget {
  final String teks;
  final int data1, data2, data3;
  final bool cek;
  const DisplayData({super.key, required this.data1, required this.data2, required this.data3, required this.teks, required this.cek});
  
  @override
  State<DisplayData> createState() => _DisplayDataState();
}

class _DisplayDataState extends State<DisplayData> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Flexible(
            flex: 4,
            child: Center(
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 130),
                decoration: BoxDecoration(
                  color: widget.cek ? Color(0xFF08D9D6) : Color(0xFFFF2E63),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        ((widget.data1 + widget.data2 + widget.data3) / 3).toStringAsFixed(0),
                        style: GoogleFonts.comicNeue(
                          fontSize: 50,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        widget.teks,
                        style: GoogleFonts.comicNeue(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 2,
                  color: Colors.black,
                )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: Container(
                      child: Column(
                        children: [
                          Text(
                            widget.data1.toString(),
                            style: GoogleFonts.comicNeue(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            widget.teks + "\nBagian Atas",
                            style: GoogleFonts.comicNeue(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      child: Column(
                        children: [
                          Text(
                            widget.data2.toString(),
                            style: GoogleFonts.comicNeue(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            widget.teks + "\nBagian Tengah",
                            style: GoogleFonts.comicNeue(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: Container(
                      child: Column(
                        children: [
                          Text(
                            widget.data3.toString(),
                            style: GoogleFonts.comicNeue(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            widget.teks + "\nBagian Bawah",
                            style: GoogleFonts.comicNeue(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}