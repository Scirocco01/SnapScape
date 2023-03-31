

import 'package:ehisaab_2/App/injectors.dart';
import 'package:ehisaab_2/Config/text.dart';
import 'package:ehisaab_2/Model/notifications_model.dart';
import 'package:ehisaab_2/ViewModel/Notifications_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NotificationsRoute extends StatefulWidget {
  const NotificationsRoute({Key? key, required this.setupPageRoute}) : super(key: key);
  final String setupPageRoute;

  @override
  State<NotificationsRoute> createState() => _NotificationsRouteState();
}

class _NotificationsRouteState extends State<NotificationsRoute> {
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
      case "dashboard/notifications":
        page = const NotificationsPage();
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


class NotificationsPage extends StatefulWidget {
  const NotificationsPage({Key? key}) : super(key: key);

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {

  NotificationsViewModel viewModel = injector<NotificationsViewModel>();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NotificationsViewModel>(
        create: (context) => viewModel,
        child: Consumer<NotificationsViewModel>(
        builder: (context, model, child) => Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 28.0,right: 10,left: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const PrimaryText(text: 'Notifications',size: 24,fontWeight: FontWeight.w500,),
              Padding(
                padding: const EdgeInsets.only(top: 18.0),
                child: Row(
                  children:  [
                    Container(
                      decoration:BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(36)),
                        border: Border.all(color: Colors.black),
                      ),
                      child: const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: Center(
                          child: Icon(Icons.person_add_outlined,color: Colors.black,),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        PrimaryText(text: 'Follow requests',fontWeight: FontWeight.w500,size: 18,),
                        PrimaryText(text: 'Approve or ignore requests',color: Colors.grey,size: 15,)
                      ],
                    )
                  ],
                ),
              ),
              const PrimaryText(text: 'Today'),
              SizedBox(
                height: 80 * (generateWidgets(model.notificationsList.length, model,DateTime.now().subtract(const Duration(days: 2))).length).roundToDouble(),
                child: Column(
                  children: generateWidgets(model.notificationsList.length, model,DateTime.now().subtract(const Duration(days: 2)))
                )
              ),
              const PrimaryText(text: 'This Week'),
              SizedBox(
                  height: 80 * (generateWidgets(model.notificationsList.length, model,DateTime.now().subtract(Duration(days: 8))).length).roundToDouble(),
                  child: Column(
                      children: generateWidgets(model.notificationsList.length, model,DateTime.now().subtract(Duration(days: 8)))
                  )
              ),



            ],
          ),
        ),
      ),
    )));
  }
}
List<Widget> generateWidgets(int count,NotificationsViewModel model,DateTime time) {

  DateTime now = DateTime.now();
  DateTime yesterday = now.subtract(Duration(days :2));
  DateTime week = now.subtract(Duration(days:7));

  List<Widget> widgets = [];
  for (int i = 0; i < count; i++) {
    if(model.notificationsList[i].timeStamp.isAfter(time)) {
      widgets.add(
        NotificationWidget(notificationsModel: model.notificationsList[i]));
    }
  }
  return widgets;
}


class NotificationWidget extends StatefulWidget {
  const NotificationWidget({Key? key, required this.notificationsModel,}) : super(key: key);
  final NotificationsModel notificationsModel;

  @override
  State<NotificationWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<NotificationWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Row(
        children:  [
          Container(
            decoration:BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(36)),
              border: Border.all(color: Colors.black),
            ),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(widget.notificationsModel.photoUrl),
              backgroundColor: Colors.white,
            ),
          ),
          const SizedBox(width: 10,),
          RichText(
            text: TextSpan(
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
              children: [
                TextSpan(
                  text: '${widget.notificationsModel.name}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const TextSpan(
                  text: 'and others shared \n ',
                  style:  TextStyle(
                    fontSize: 14,

                  ),

                ),

                TextSpan(
                  text: '${widget.notificationsModel.otherPosts} photos. ${widget.notificationsModel.timeStamp}',
                ),
              ],
            ),
            overflow: TextOverflow.ellipsis,
            softWrap: true,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}



