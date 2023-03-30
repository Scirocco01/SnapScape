import 'package:flutter/material.dart';

import '../../../Config/text.dart';

class MessagingPage extends StatefulWidget {
  const MessagingPage({Key? key, required this.pageController})
      : super(key: key);
  final PageController pageController;

  @override
  State<MessagingPage> createState() => _MessagingPageState();
}

class _MessagingPageState extends State<MessagingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            IconButton(
                onPressed: () {
                  if (1 == 1) {
                    widget.pageController.animateToPage(0,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.decelerate);
                    print('should animate to home page');
                  }
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                )),
            const PrimaryText(
              text: 'Sanan_sk',
            )
          ],
        ),
      ),
    );
  }
}
