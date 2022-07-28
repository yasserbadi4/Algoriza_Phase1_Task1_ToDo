import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:my_todo_phase1/core/costants/colors.dart';
import 'package:my_todo_phase1/presentation/cubit/todo_cubit.dart';
import 'package:my_todo_phase1/presentation/cubit/todo_states.dart';
import 'package:my_todo_phase1/presentation/shared_widgets/task_schedule_item.dart';

import '../task_tile.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoCubit, ToDoStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ToDoCubit.get(context);
        var tasks = ToDoCubit.get(context).newTasks;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
            title: const Text('Schedule'),
          ),
          body: Container(
            margin: const EdgeInsets.only(top: 10),
            //padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Today', style: Theme.of(context).textTheme.headline5),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: DatePicker(
                    DateTime.now(),
                    height: 100,
                    width: 50,
                    initialSelectedDate: DateTime.now(),
                    selectionColor: defaultColor,
                    selectedTextColor: Colors.white,
                    monthTextStyle: const TextStyle(
                        fontSize: 15.0, fontWeight: FontWeight.bold),
                    dateTextStyle: const TextStyle(
                        fontSize: 15.0, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 10,),
                Expanded(
                    child: ListView.builder(
                        itemCount: cubit.newTasks.length,
                        itemBuilder: (_, index) {
                          return AnimationConfiguration.staggeredList(

                              position: index,
                              child: SlideAnimation(
                                child: FadeInAnimation(
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap:(){
                                          debugPrint('Tapped');
                                        } ,
                                        child: TaskTile(),

                                      ),
                                    ],
                                  ),
                                ),
                              ));
                        })),
              ],
            ),
          ),
        );
      },
    );
  }
}


