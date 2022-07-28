import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_todo_phase1/presentation/cubit/todo_cubit.dart';
import 'package:my_todo_phase1/presentation/cubit/todo_states.dart';
import 'package:my_todo_phase1/presentation/shared_widgets/my_input_text.dart';
import 'package:my_todo_phase1/presentation/shared_widgets/my_material_button.dart';

class TestAddTask extends StatelessWidget {
  DateTime? dateTime = DateTime.now();
  String startTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  String endTime = DateFormat("hh:mm a").format(DateTime.now()).toString();
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController startTimeController = TextEditingController();
  TextEditingController endTimeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController reminderController = TextEditingController();

  // int selectedReminder = 5;
  // List<int> reminder = [
  //   5,
  //   10,
  //   15,
  //   20,
  // ];

  var formKey = GlobalKey<FormState>();

  TestAddTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ToDoCubit, ToDoStates>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var cubit = ToDoCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
            title: const Text('Add Task'),
          ),
          body: Container(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: formKey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    MyInputText(
                      title: 'Title ',
                      hintText: 'Enter Task Title',
                      controller: titleController,
                      type: TextInputType.text,
                    ),
                    MyInputText(
                      controller: dateController,
                      type: TextInputType.datetime,
                      title: 'Date ',
                      hintText: DateFormat.yMd().format(dateTime!),
                      widget: IconButton(
                          onPressed: () {
                            showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1901),
                                    lastDate: DateTime(2050))
                                .then((value) {
                              dateController.text =
                                  DateFormat.yMMMd().format(value!);
                            }).catchError((error) {
                              dateController.clear();
                            });
                          },
                          icon: const Icon(
                            Icons.calendar_month_rounded,
                            color: Colors.grey,
                          )), //
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: MyInputText(
                          controller: startTimeController,
                          type: TextInputType.datetime,
                          title: 'Start time',
                          hintText: startTime,
                          widget: IconButton(
                            icon: const Icon(
                              Icons.watch_later_outlined,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                  .then((value) {
                                startTimeController.text =
                                    value!.format(context);
                              }).catchError(
                                (error) {
                                  startTimeController.clear();
                                },
                              );
                            },
                          ),
                        )),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                            child: MyInputText(
                          controller: startTimeController,
                          type: TextInputType.datetime,
                          title: 'End time',
                          hintText: endTime,
                          widget: IconButton(
                            icon: const Icon(
                              Icons.watch_later_outlined,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now())
                                  .then((value) {
                                endTimeController.text = value!.format(context);
                              }).catchError(
                                (error) {
                                  endTimeController.clear();
                                },
                              );
                            },
                          ),
                        )),
                      ],
                    ),
                    MyInputText(
                        controller: descriptionController,
                        type: TextInputType.text,
                        title: 'Description ',
                        hintText: 'Enter Task Description'),
                    MyInputText(
                      controller: descriptionController,
                      type: TextInputType.text,
                      title: 'Reminder ',
                      hintText: '${cubit.selectedReminder} minutes Early',
                      widget: DropdownButton(
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                        iconSize: 32,
                        elevation: 4,
                        underline: Container(height: 0,),
                        style: Theme.of(context).textTheme.bodySmall,
                        items:
                            cubit.reminderList.map<DropdownMenuItem<String>>((int value) {
                          return DropdownMenuItem<String>(
                            value: value.toString(),
                            child: Text(value.toString()),
                          );
                        }).toList(),
                        onChanged: (String? newValue)
                        {
                          cubit.selectedReminder = int.parse(newValue!);
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyInputText(
                      controller: descriptionController,
                      type: TextInputType.text,
                      title: 'Repeat ',
                      hintText: cubit.selectedRepeat,
                      widget: DropdownButton(
                        icon: const Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                        iconSize: 32,
                        elevation: 4,
                        underline: Container(height: 0,),
                        style: Theme.of(context).textTheme.bodySmall,
                        items:
                        cubit.repeatList.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value.toString(),
                            child: Text(value.toString()),
                          );
                        }).toList(),

                        onChanged: (String? newValue)
                        {
                        cubit.selectedReminder = int.parse(newValue!);
                        }

                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyMaterialButton(
                      text: 'Create Task',
                      onClick: () {
                        if (formKey.currentState!.validate()) {
                          cubit.insertToDatabase(
                              title: titleController.text,
                              date: dateController.text,
                              startTime: startTimeController.text,
                              endTime: endTimeController.text,
                              description: descriptionController.text);
                          Navigator.pop(context);
                        }
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
