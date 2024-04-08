import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/databasehelper/todo_helper.dart';
import 'package:todo_app/models/todomodel.dart';

class TodoController extends GetxController {
  List<Todo> allTodo = [];
  DateTime dateTime = DateTime.now();
  TimeOfDay timeOfDay = TimeOfDay.now();
  RxString date = "".obs;
  RxString time = "".obs;
  RxString updateddate = "".obs;
  RxString updatedtime = "".obs;

  @override
  void onInit() async {
    super.onInit();
    date.value = "${dateTime.day}/${dateTime.month}/${dateTime.year}";
    time.value = '${timeOfDay.hour} : ${timeOfDay.minute}';
    updateddate.value = "${dateTime.day}/${dateTime.month}/${dateTime.year}";
    updatedtime.value = '${timeOfDay.hour} : ${timeOfDay.minute}';
    List<Todo> data = await DBTodo.dbTodo.fetchTodoData();
    setTodoData(data);
  }

  void selectDate(DateTime? selectDate) {
    date.value = "${selectDate!.day}/${selectDate.month}/${selectDate.year}";
    update();
  }

  void selectTime(TimeOfDay? selectTime) {
    time.value =
        "${selectTime!.hour}:${selectTime.minute} ${selectTime.period.name}";
    update();
  }

  void updatedDate(DateTime? selectDate) {
    updateddate.value = "${selectDate!.day}/${selectDate.month}/${selectDate.year}";
    update();
  }

  void updatedTime(TimeOfDay? selectTime) {
    updatedtime.value =
        "${selectTime!.hour}:${selectTime.minute} ${selectTime.period.name}";
    update();
  }

  void setTodoData(List<Todo> todo) {
    allTodo = todo;
    update();
  }
}
