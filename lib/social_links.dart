// This file builds the social medial icons and urls Row Module
// It is called from main.dart to build the social media icons row in main.dart
// ChatGPT assisted code. Oct 2023.

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

// This code has the icons and colors and links for the social media buttons.
class SocialMediaLinksRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CircularSocialMediaIcon(
          icon: FontAwesomeIcons.facebook,
          backgroundColor: Colors.blue, // Blue background for Facebook
          url: 'https://www.facebook.com/CorkCityCommunityRadio',
        ),
        CircularSocialMediaIcon(
          icon: FontAwesomeIcons.instagram,
          backgroundColor: Colors.red, // Red background for Instagram
          url: 'https://www.instagram.com/corkcitycommunityradio/',
        ),
        CircularSocialMediaIcon(
            icon: FontAwesomeIcons.twitter,
            backgroundColor: Colors.blue, // Blue background for Twitter
            url: 'http://twitter.com/CorkCity_radio' //'https://twitter.com/',
            ),
        CircularSocialMediaIcon(
          icon: FontAwesomeIcons.youtube,
          backgroundColor: Colors.red, // Red background for Youtube
          url: 'https://youtube.com/channel/UChxo4t9JesLZKd2tjI_KmJg',
        ),
        CircularSocialMediaIcon(
          icon: FontAwesomeIcons.tiktok,
          backgroundColor: Colors.black, // Black background for TikTok
          url: 'https://www.tiktok.com/@corkcitycommunityradio?_t=8X9fGFmX9Da&_r=1',
        ),
      ],
    );
  }
}

// This code takes the icon, url link and container color
// It builds the icons in containers which can be tapped to goto Facebook etc
class CircularSocialMediaIcon extends StatelessWidget {
  final IconData icon;
  final String url; // links to  Cork Radio social media sites.
  final Color backgroundColor;

  // This code is called the Constructor: It is needed to setup memory for the variables.
  const CircularSocialMediaIcon({
    required this.icon,
    required this.url,
    required this.backgroundColor,
  });

// This code is a Future to launch the url link
// see docs on pub.dev for all options
  // We use the 'launch in browser'
  Future<void> launchInBrowser(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url'; // error msg if it fails for any reason
    }
  }

  // This code Builds the screen
  @override
  Widget build(BuildContext context) {
    // print("This is url format  $url");
    // This code adjusts the icon sizes for different screen sizes.
    // It uses the device screen size to determin how large the icons should be.
    double iconSize;
    double containerSize;

    // Get the screen width f your phone using MediaQuery
    double screenWidth = MediaQuery.of(context).size.width;

    // Define a maximum size for the container and icon .. to remain realistic
    double maxSize = 50.0; // Adjust as needed

    // Calculate the size based on screen width, ensuring it doesn't exceed the maximum
    containerSize = screenWidth / 8; // For example, divide the screen width into 1/8s
    iconSize = containerSize *
        0.6; // Adjust icon size as a fraction of container size - nice code ChatGPT

    // Apply a maximum size constraint
    containerSize = containerSize.clamp(0.0, maxSize);
    iconSize = iconSize.clamp(0.0, maxSize * 0.5);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          // Handle the url icon tap e.g., open a web page - Facebook etc
          // You can use the url_launcher library package for this on pub.dev.
          // Example:
          //launchUrl(url as Uri);
          // Convert the url to Uri before launching it
          launchUrl(Uri.parse(url)); // ChatGPT suggest parse
        },
        child: Container(
          // width: 60, // Fixed size only Adjust the size as needed
          // height: 60, // Adjust the size as needed
          width: containerSize, // adjusts to screen sizes
          height: containerSize, // adjusts to screen sizes
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: backgroundColor,
          ),
          child: Center(
            child: Icon(
              icon,
              size: iconSize,
              color: Colors.white, // icon color
            ),
          ),
        ),
      ),
    );
  }
}
//Chat GPT assist in this modified code:
//The CircularSocialMediaIcon widget now accepts a backgroundColor parameter, allowing you to specify the background color for each social media icon.
//In the CircularSocialMediaIcon widget, a Container is used with a circular shape (shape: BoxShape.circle) and the specified backgroundColor.
//The Icon is placed inside the circular container with a white icon color, and you can adjust the size and other properties as needed.
//Now, each social media icon will have its own circular background with the specified color. You can customize the backgroundColor for each social media platform to match the design you desire.

// ChatGPT on launchUrl
//We use await with canLaunch to check if the URL can be launched.
//If it can be launched, we use await with launch to open the URL.
//The uri.toString() method converts the Uri to a string before passing it to canLaunch and launch.
//Please make sure to use the corrected code above to handle URL launching.
// The await keyword should be used in these specific functions to ensure they complete successfully
// before moving on to the next step
