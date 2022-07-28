import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:my_todo_phase1/presentation/cubit/todo_cubit.dart';

Widget buildTaskItem(Map model, context) {
  return Dismissible(
    key: Key(model['id'].toString()),
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              ToDoCubit.get(context)
                  .updateStatusInDatabase(id: model['id'], status: 'Done');
            },
            icon: Icon(
              model['status'] != 'New'
                  ? Icons.check_box
                  : Icons.check_box_outline_blank,
              color: model['status'] != 'New'?Colors.redAccent:Colors.green,
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${model['title']}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${model['description']}',
                  style: const TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${model['date']}',
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 20.0,
          ),
          PopupMenuButton(
              itemBuilder: (BuildContext context) => [
                    PopupMenuItem(
                        child: const Text('Complete'),
                        onTap: () {
                          ToDoCubit.get(context).updateStatusInDatabase(
                              id: model['id'], status: 'Done');
                        }),
                    PopupMenuItem(
                      child: const Text('Archive'),
                      onTap: () {
                        ToDoCubit.get(context).updateStatusInDatabase(
                            id: model['id'], status: 'Favourites');
                      },
                    ),
                PopupMenuItem(
                    child: const Text('UnDone'),
                    onTap: () {
                      ToDoCubit.get(context).updateStatusInDatabase(
                          id: model['id'], status: 'New');
                    }),
                  ]),
        ],
      ),
    ),
    onDismissed: (direction) {
      ToDoCubit.get(context).deleteDataFromDatabase(
        id: model['id'],
      );
    },
  );
}

Widget tasksBuilder({
  required List<Map> tasks,
}) =>
    ConditionalBuilder(
      condition: tasks.isNotEmpty,
      builder: (context) => ListView.separated(
        itemBuilder: (context, index) {
          return buildTaskItem(tasks[index], context);
        },
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsetsDirectional.only(
            start: 20.0,
          ),
          child: Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey[300],
          ),
        ),
        itemCount: tasks.length,
      ),
      fallback: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.menu,
              size: 100.0,
              color: Colors.grey,
            ),
            Text(
              'No Tasks Yet, Please Add Some Tasks',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
