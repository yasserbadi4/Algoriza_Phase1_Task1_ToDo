import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:my_todo_phase1/core/util/mythemes.dart';
import 'package:my_todo_phase1/presentation/cubit/todo_cubit.dart';
import 'package:my_todo_phase1/presentation/board_screen/main_board.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();


void main() async{
  WidgetsFlutterBinding.ensureInitialized();


  var initialiationSettingsAndroid= AndroidInitializationSettings('tasks');
  var initialiationSettingsIOS= IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
    onDidReceiveLocalNotification: (int id , String? title, String? body , String? payLoad)async {});
  var initializationSettings = InitializationSettings(
      android: initialiationSettingsAndroid, iOS: initialiationSettingsIOS);
await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: (String? payLoad)async{
  if (payLoad !=null){
    debugPrint('notification payload'+ payLoad);
  }
});

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ToDoCubit()..createDatabase()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ToDo Task App Algoriza Phase 1',
        theme: lightTheme,
        home:   MainBoardScreen(),
      ),
    );
  }
}
