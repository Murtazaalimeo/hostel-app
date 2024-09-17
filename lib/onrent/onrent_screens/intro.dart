import 'package:flutter/material.dart';
import '../authentication onrent/login_signup/login_onrent.dart';
import 'Constants.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController(initialPage: 0);
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff2E5A88),
                  Color(0xffcf6cc9),
                  //Color(0xffee609c),
                  //Color(0xffee609c),
                ],
              ),
            ),
          ),
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                currentIndex = page;
              });
            },
            children: [
              createPage(
                image: 'assets/images/1.jpg',
                title: Constants.titleOne,
                description: Constants.descriptionOne,
                color: Colors.yellow, // Change to your preferred color
              ),
              createPage(
                image: 'assets/images/2.jpg',
                title: Constants.titleTwo,
                description: Constants.descriptionTwo,
                color: Colors.pink, // Change to your preferred color
              ),
              createPage(
                image: 'assets/images/3.jpg',
                title: Constants.titleThree,
                description: Constants.descriptionThree,
                color: Colors.yellow, // Change to your preferred color
              ),
            ],
          ),


          Positioned(
            bottom: 40,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.purple, // Change to your preferred color
                padding: EdgeInsets.symmetric(
                  horizontal: 200.0, // Increased button width
                  vertical: 12.0,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0), // Removed border radius
                ),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreenOnrent()),
                );
              },
              child: Text(
                'Sign In',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 90, // Adjust the height as needed
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildIndicator(),
            ),
          ),
        ],
      ),
    );
  }
  Widget _indicator(bool isActive) {
    return Container(
      height: 11.0,
      width: isActive ? 24.0 : 8.0,
      margin: const EdgeInsets.only(right: 8.0),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.grey,
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }

  List<Widget> _buildIndicator() {
    List<Widget> indicators = [];

    for (int i = 0; i < 3; i++) {
      indicators.add(_indicator(currentIndex == i));
    }

    return indicators;
  }
}


Widget createPage({
    required String title,
    required String description,
    required String image,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 200, // Decreased image size
            height: 200, // Decreased image size
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.black,
                  offset: Offset(0.0, 2.0),
                  blurRadius: 6.0,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 28, // Increased text size
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15),
          Text(
            description,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18, // Increased text size
            ),
          ),
        ],
      ),
    );
  }

