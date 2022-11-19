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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF2E2340),
      ),
      child: Row(
        children: [
          Container(
            width: 100,
            height: 100,
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
            children: [
              Row(
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
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Text(
                      'Participants:',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.white30,
                      ),
                    ),
                  ),
                  ...participants.map((e) {
                    return Container(
                      width: 20,
                      height: 25,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        image: DecorationImage(
                          image: AssetImage(
                            e,
                          ),
                        ),
                      ),
                    );
                  })
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
