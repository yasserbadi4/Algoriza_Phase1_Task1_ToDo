import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_todo_phase1/presentation/cubit/todo_states.dart';
import '../cubit/todo_cubit.dart';
import '../shared_widgets/task_item.dart';

class AllTasks extends StatelessWidget {
  const AllTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoCubit, ToDoStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var tasks = ToDoCubit.get(context).allTasks;
        return tasksBuilder(tasks: tasks);
      },
    );
  }
}