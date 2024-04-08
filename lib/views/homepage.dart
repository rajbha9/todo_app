import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controller/todo_controller.dart';
import 'package:todo_app/databasehelper/todo_helper.dart';
import 'package:todo_app/models/todomodel.dart';

class HomaPage extends StatefulWidget {
  const HomaPage({super.key});

  @override
  State<HomaPage> createState() => _HomaPageState();
}

class _HomaPageState extends State<HomaPage> {
  int id = 0;
  String name = '';
  String date = '';
  String time = '';
  String description = '';

  String updatename = '';
  String updatedescription = '';

  TodoController todoController = Get.put(TodoController());
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController updatednameController = TextEditingController();
  TextEditingController updateddescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return SingleChildScrollView(
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        height: 500,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Name',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextFormField(
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Enter Name...';
                                }
                                return null;
                              },
                              controller: nameController,
                              onChanged: (val) {
                                name = val;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter your Description',
                              ),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            const Text(
                              'Description',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            TextFormField(
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return 'Enter Description...';
                                }
                                return null;
                              },
                              controller: descriptionController,
                              onChanged: (val) {
                                description = val;
                              },
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter your Description',
                              ),
                              maxLines: 4,
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        DateTime? setdate =
                                            await showDatePicker(
                                                context: context,
                                                firstDate: DateTime(2015),
                                                lastDate: DateTime(2030),
                                                initialDate:
                                                    todoController.dateTime);
                                        todoController.selectDate(setdate);
                                      },
                                      icon:
                                          const Icon(Icons.date_range_outlined),
                                    ),
                                    Obx(
                                      () => Text(
                                        todoController.date.value,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                Row(
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        TimeOfDay? timeofday =
                                            await showTimePicker(
                                                context: context,
                                                initialTime:
                                                    todoController.timeOfDay);
                                        todoController.selectTime(timeofday);
                                      },
                                      icon: const Icon(
                                          Icons.access_time_filled_rounded),
                                    ),
                                    Obx(
                                      () => Text(
                                        todoController.time.value,
                                        style: const TextStyle(fontSize: 16),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                OutlinedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Cancel"),
                                ),
                                ElevatedButton(
                                  onPressed: () async {
                                    await DBTodo.dbTodo
                                        .insertTodoData(
                                            name,
                                            description,
                                            todoController.date.value,
                                            todoController.time.value)
                                        .then(
                                      (value) {
                                        nameController.clear();
                                        descriptionController.clear();
                                        Navigator.of(context).pop();
                                      },
                                    );
                                    List<Todo> data =
                                        await DBTodo.dbTodo.fetchTodoData();
                                    todoController.setTodoData(data);
                                    todoController.date.value =
                                        "${todoController.dateTime.day} / ${todoController.dateTime.month} / ${todoController.dateTime.year}";
                                  },
                                  child: const Text("Save"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              icon: const Icon(Icons.add))
        ],
        title: const Text('Todo App'),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        padding: const EdgeInsets.all(12),
        child: GetBuilder<TodoController>(
          builder: (controller) {
            return ListView(
              children: todoController.allTodo
                  .map((e) => Card(
                        elevation: 5,
                        child: ListTile(
                          leading: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Text(
                                "${e.id}",
                                style: const TextStyle(color: Colors.black),
                              )),
                          title: Text(e.name),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(e.description),
                              Row(
                                children: [
                                  Text(e.time),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(e.date)
                                ],
                              )
                            ],
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                onPressed: () async {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) {
                                      return SingleChildScrollView(
                                        child: Container(
                                          padding: const EdgeInsets.all(15),
                                          height: 500,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              const Text(
                                                'Name',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              TextFormField(
                                                validator: (val) {
                                                  if (val!.isEmpty) {
                                                    return 'Enter Name...';
                                                  }
                                                  return null;
                                                },
                                                controller:
                                                    updatednameController,
                                                onChanged: (val) {
                                                  name = val;
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  hintText:
                                                      'Enter your Description',
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 25,
                                              ),
                                              const Text(
                                                'Description',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              TextFormField(
                                                validator: (val) {
                                                  if (val!.isEmpty) {
                                                    return 'Enter Description...';
                                                  }
                                                  return null;
                                                },
                                                controller:
                                                    updateddescriptionController,
                                                onChanged: (val) {
                                                  description = val;
                                                },
                                                decoration:
                                                    const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  hintText:
                                                      'Enter your Description',
                                                ),
                                                maxLines: 4,
                                              ),
                                              const SizedBox(
                                                height: 25,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                        onPressed: () async {
                                                          DateTime? setdate =
                                                              await showDatePicker(
                                                                  context:
                                                                      context,
                                                                  firstDate:
                                                                      DateTime(
                                                                          2015),
                                                                  lastDate:
                                                                      DateTime(
                                                                          2030),
                                                                  initialDate:
                                                                      todoController
                                                                          .dateTime);
                                                          todoController
                                                              .updatedDate(
                                                                  setdate);
                                                        },
                                                        icon: const Icon(Icons
                                                            .date_range_outlined),
                                                      ),
                                                      Obx(
                                                        () => Text(
                                                          todoController
                                                              .date.value,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  const Spacer(),
                                                  Row(
                                                    children: [
                                                      IconButton(
                                                        onPressed: () async {
                                                          TimeOfDay? timeofday =
                                                              await showTimePicker(
                                                                  context:
                                                                      context,
                                                                  initialTime:
                                                                      todoController
                                                                          .timeOfDay);
                                                          todoController
                                                              .updatedTime(
                                                                  timeofday);
                                                        },
                                                        icon: const Icon(Icons
                                                            .access_time_filled_rounded),
                                                      ),
                                                      Obx(
                                                        () => Text(
                                                          todoController
                                                              .time.value,
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 16),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 25,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  OutlinedButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text("Cancel"),
                                                  ),
                                                  ElevatedButton(
                                                    onPressed: () async {
                                                      await DBTodo.dbTodo
                                                          .updateTodoData(
                                                              name,
                                                              description,
                                                              todoController
                                                                  .date.value,
                                                              todoController
                                                                  .time.value,
                                                              e.id as int)
                                                          .then(
                                                        (value) async{
                                                              await DBTodo.dbTodo.fetchSingleTodoData(id);
                                                          Get.back();
                                                        },
                                                      );
                                                    },
                                                    child: const Text("Save"),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                  todoController.onInit();
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  color: Colors.blue,
                                ),
                              ),
                              IconButton(
                                onPressed: () async {
                                  await DBTodo.dbTodo.deleteTodoData(e.id);
                                  todoController.onInit();
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              )
                            ],
                          ),
                        ),
                      ))
                  .toList(),
            );
          },
        ),
      ),
    );
  }
}
