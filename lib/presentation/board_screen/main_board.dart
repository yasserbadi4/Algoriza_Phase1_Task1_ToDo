import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo_phase1/presentation/add_task_screen/add_task.dart';
import 'package:my_todo_phase1/presentation/all_tasks/all_tasks.dart';
import 'package:my_todo_phase1/presentation/completed_tasks/completed_tasks.dart';
import 'package:my_todo_phase1/presentation/cubit/todo_cubit.dart';
import 'package:my_todo_phase1/presentation/cubit/todo_states.dart';
import 'package:my_todo_phase1/presentation/favorite_tasks/favorite_tasks.dart';
import 'package:my_todo_phase1/presentation/new_tasks/new_tasks.dart';
import 'package:my_todo_phase1/presentation/schedule_screen/schedule.dart';
import 'package:my_todo_phase1/presentation/shared_widgets/my_material_button.dart';

class MainBoardScreen extends StatelessWidget {
  const MainBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoCubit, ToDoStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ToDoCubit.get(context);
        return DefaultTabController(
          length: 4,
          child: Center(
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                title: const Text(
                  'Board',
                  style: TextStyle(color: Colors.black),
                ),
                actions: [
                  const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  const Icon(
                    Icons.notification_important_rounded,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    icon: Icon(Icons.menu),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ScheduleScreen()));
                    },
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                ],
                bottom: const TabBar(
                  isScrollable: true,
                  labelColor: Colors.black,
                  labelStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  indicator: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 2),
                    ),
                  ),
                  tabs: [
                    Tab(
                      text: 'All',
                    ),
                    Tab(
                      text: 'New',
                    ),
                    Tab(
                      text: 'Completed',
                    ),
                    Tab(
                      text: 'Favourites',
                    ),
                  ],
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const Expanded(
                      child: TabBarView(
                        children: [
                          AllTasks(),
                          NewTasks(),
                          CompletedTasks(),
                          FavouriteTasks(),
                        ],
                      ),
                    ),
                    MyMaterialButton(
                      text: 'Add a task',
                      onClick: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TestAddTask()));
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
