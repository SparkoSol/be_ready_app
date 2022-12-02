import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EventsTile extends StatelessWidget {
  const EventsTile(
      {Key? key,
      required this.title,
      required this.date,
      required this.participants,
      required this.path})
      : super(key: key);

  final String title;
  final String date;
  final String path;
  final List<String> participants;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF2E2340),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 96,
            height: 96,
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  path,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    width: 160,
                    child: Text(
                      title,
                      style: GoogleFonts.poppins(
                          fontSize: 16, color: Colors.white, letterSpacing: 1),
                    ),
                  ),
                  Text(
                    date,
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: Colors.white70,
                    ),
                  ),
                ],
              ),
              // Row(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.symmetric(
              //           vertical: 10, horizontal: 10),
              //       child: Text(
              //         'Participants:',
              //         style: GoogleFonts.poppins(
              //           fontSize: 12,
              //           color: Colors.white30,
              //         ),
              //       ),
              //     ),
              //     const StackImages(),
              //   ],
              // )
            ],
          ),
        ],
      ),
    );
  }
}
