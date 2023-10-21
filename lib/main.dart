/*  main.dart
 *  Created by Ilya Chirkunov <xc@yar.net> on 28.12.2020.
 * Modified by Kids of Coder Dojo Club Glanmire Oct 2023
 * for Cork Community Radio
 */

import 'package:flutter/material.dart';
import 'package:radio_player/radio_player.dart';

import 'social_links.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final RadioPlayer _radioPlayer = RadioPlayer();
  bool isPlaying = false;
  List<String>? metadata; // add late modifier or use the ? can be null modifier.

  @override
  void initState() {
    super.initState();
    initRadioPlayer(); // initialise the radio player plugin
  }

  void initRadioPlayer() {
    _radioPlayer.setChannel(
      title: 'Cork Community Radio Player',
      url: 'http://stream.cr.ie:8002/mp3',
      //url: 'http://stream-uk1.radioparadise.com/aac-320',
      // Newstalk
      //url: https://ie.radioonline.fm/listen/Newstalk-106-108
      imagePath: 'assets/cccr.jpg',
    );

    _radioPlayer.stateStream.listen((value) {
      setState(() {
        isPlaying = value;
      });
    });

    _radioPlayer.metadataStream.listen((value) {
      setState(() {
        metadata = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Define the custom color using RGB values of radio station
    final customColor1 = Color.fromRGBO(115, 1, 3, 1.0); // CCR red brand color
    //final customColor2 = Color.fromRGBO(104, 34, 32, 1.0);
    return MaterialApp(
        home: Scaffold(
      appBar: null, // nothing in the App Bar
      body: SafeArea(
          // Safe area means no image in the system top status bar.
          child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            color: customColor1,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 250,
                  width: 250,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(
                      'assets/cccr.jpg',
                      fit: BoxFit.scaleDown, //.cover,
                    ),
                  ),
                ),

                //----------------
                // Listen Live Button
                ElevatedButton(
                  onPressed: () {
                    // Define the action to be performed when the button is pressed.
                    isPlaying ? _radioPlayer.pause() : _radioPlayer.play();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        customColor1), // Use your custom color
                  ),
                  child:
                      isPlaying // this is conditional syntax: If true ? Do This : else Do This
                          ? Image.asset(
                              'assets/listen_live_pause.jpg',
                              width: 140, // Adjust the width as needed
                              height: 100,
                              fit: BoxFit.contain, // This makes the image fill
                            )
                          : Image.asset(
                              'assets/listen_live.jpg',

                              width: 140, // Adjust the width as needed
                              height: 100,
                              fit: BoxFit.contain, // This makes the image fill
                            ),
                ),
// insert Social Media Icons here from separate file social_links.dart
                SocialMediaLinksRow(),

                //-----------
/*
                    FutureBuilder(
                      future: _radioPlayer.getArtworkImage(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        Image artwork;
                        if (snapshot.hasData) {
                          artwork = snapshot.data;
                        } else {
                          artwork = Image.asset(
                            'assets/cccr.jpg',
                            fit: BoxFit.scaleDown, //.cover,
                          );
                        }
                        return Container(
                          height: 250,
                          width: 250,
                          child: ClipRRect(
                            child: artwork,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        );
                      },
                    ),
                    */

                //--------------
                FutureBuilder(
                  future: _radioPlayer.getArtworkImage(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      // If there is artwork data, display it
                      return Container(
                        height: 250,
                        width: 250,
                        child: ClipRRect(
                          child: snapshot.data,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      );
                    } else {
                      // If there's no artwork data, display a placeholder or no image
                      return Container(
                        height: 250,
                        width: 250,
                        child: ClipRRect(
                          child: Image.asset(
                            'assets/ccr_placeholder.jpg', // Provide your placeholder image
                            fit: BoxFit.scaleDown, //.cover,
                          ),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      );
                    }
                  },
                ),

                //--------------

                SizedBox(height: 20),

                //=========================
                Text(
                  metadata?[0] ?? '',
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(
                      color: Colors.white10, fontWeight: FontWeight.bold, fontSize: 24),
                ),
                Text(
                  metadata?[1] ?? '',
                  softWrap: false,
                  overflow: TextOverflow.fade,
                  style: const TextStyle(
                      color: Colors.white10, fontWeight: FontWeight.bold, fontSize: 16),
                ),
                // metadata[2] has http link to album image.
                SizedBox(height: 20),

                //==================
              ],
            ),
          ),
        ),
      )),
    ));
  }
}
