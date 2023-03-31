import 'package:ehisaab_2/ViewModel/home_view_model.dart';
import 'package:flutter/material.dart';

import '../../../Config/text.dart';

class MessagingPage extends StatefulWidget {
  const MessagingPage({
    Key? key,
    required this.pageController,
    required this.model,
  }) : super(key: key);

  final PageController pageController;
  final HomeViewModel model;

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
                  if (widget.pageController.hasClients) {
                    widget.pageController.animateToPage(0,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.decelerate);
                    print('should animate to home page');
                    print(
                        'this should be the num value ${widget.model.checkvar}');
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
