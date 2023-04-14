import 'dart:io';

import 'package:ehisaab_2/Config/text.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../App/injectors.dart';
import '../../../ViewModel/add_post_view_model.dart';

class AddPostRoute extends StatefulWidget {
  const AddPostRoute({
    Key? key,
    required this.setupPageRoute,
  }) : super(key: key);

  final String setupPageRoute;

  @override
  State<AddPostRoute> createState() => _AddPostRouteState();
}

class _AddPostRouteState extends State<AddPostRoute> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Navigator(
        key: _navigatorKey,
        initialRoute: widget.setupPageRoute,
        onGenerateRoute: _onGenerateRoute,
      ),
    );
  }

  Route _onGenerateRoute(RouteSettings settings) {
    late Widget page;
    switch (settings.name) {
      case "dashboard/addPost":
        page = const AddPostScreen();
        break;
    }

    return MaterialPageRoute<dynamic>(
      builder: (context) {
        return page;
      },
      settings: settings,
    );
  }
}

class AddPostScreen extends StatefulWidget {
  const AddPostScreen({Key? key}) : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  @override
  int _isLoading = 0;
  bool _isDialogShowing = false;

  File? _image;
  final picker = ImagePicker();
  late TextEditingController _captionController;

  final AddPostViewModel viewModel = injector<AddPostViewModel>();

  @override
  void initState() {
    super.initState();
    _captionController = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _pickImage(ImageSource.gallery); // Or ImageSource.camera if you prefer
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await picker.getImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddPostViewModel>(
        create: (context) => viewModel,
        child: Consumer<AddPostViewModel>(
            builder: (context, model, child) => Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  title: const Text('Add Post'),
                  actions: [
                    TextButton(
                      onPressed: () async {
                        if (_image != null && _captionController.text != '') {
                          setState(() {
                            print('should be _isLoading  = 1');
                            _isLoading = 1;
                          });
                          await model
                              .savePost(_image!, _captionController.text)
                              .then((value) async {
                            setState(() {
                              _isLoading = 2;
                            });
                            _image = null;
                            _captionController.clear();

                            // Add 'await' before the Future.delayed
                            await Future.delayed(Duration(seconds: 2));

                            // Set _isLoading back to 0
                            setState(() {
                              _isLoading = 0;
                            });
                          });

                          setState(() {
                            _isLoading = 0;
                          });
                        }
                      },
                      child: const Text(
                        'Share',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                body: _isLoading > 0
                    ? Center(
                        child: AlertDialog(
                        backgroundColor: Colors.transparent,
                        elevation: 0.0,
                        contentPadding: EdgeInsets.zero,
                        content: StatefulBuilder(builder: (context, setState) {
                          return Container(
                            width: 80.0,
                            height: 80.0,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: _isLoading == 2
                                ? const Center(
                                    child: PrimaryText(
                                    text: 'Post Added',
                                  ))
                                : const Center(
                                    child: CircularProgressIndicator(),
                                  ),
                          );
                        }),
                      ))
                    : SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (_image != null)
                                Container(
                                  width: double.infinity,
                                  height:
                                      MediaQuery.of(context).size.height * 0.4,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: FileImage(_image!),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                )
                              else
                                GestureDetector(
                                  onTap: () async {
                                    await _pickImage(ImageSource.gallery);
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    height: MediaQuery.of(context).size.height *
                                        0.4,
                                    color: Colors.grey[300],
                                    child: const Center(
                                      child: Text('No image selected'),
                                    ),
                                  ),
                                ),
                              const SizedBox(height: 8.0),
                              TextField(
                                controller: _captionController,
                                maxLines: null,
                                decoration: const InputDecoration(
                                  hintText: 'Write a caption...',
                                  border: OutlineInputBorder(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ))));
  }

  _showDialog() async {
    setState(() {
      _isDialogShowing = true;
    });

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            contentPadding: EdgeInsets.zero,
            content: StatefulBuilder(builder: (context, setState) {
              return Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      SizedBox(height: 16.0),
                      TickIcon(),
                    ],
                  ),
                ),
              );
            }),
          ),
        );
      },
    );

    await Future.delayed(Duration(seconds: 2)); // Change the duration as needed

    setState(() {
      _isDialogShowing = false;
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      print('should pop out of dialog');
    });
    // This line will close the dialog
  }
}

class TickIcon extends StatelessWidget {
  const TickIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _TickIconPainter(),
      size: const Size(24.0, 24.0),
    );
  }
}

class _TickIconPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.green
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(size.width * 0.15, size.height * 0.5)
      ..lineTo(size.width * 0.4, size.height * 0.75)
      ..lineTo(size.width * 0.85, size.height * 0.25);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
