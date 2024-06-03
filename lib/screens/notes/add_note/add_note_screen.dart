import 'package:auto_route/auto_route.dart';
import 'package:chip_list/chip_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindmemo_app/models/note_model.dart';
import 'package:mindmemo_app/router/router.dart';
import 'package:mindmemo_app/screens/main/main_screen.dart';
import 'package:mindmemo_app/screens/notes/notes_bloc/notes_bloc.dart';
import 'package:mindmemo_app/theme/colors.dart';

@RoutePage()
class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final noteController = TextEditingController();

  List<String> priorityList = [
    'High priority',
    'Medium priority',
    'Low priority'
  ];
  String priority = 'High priority';
  int _priorityIndex = 0;

  List<String> categoryList = [
    'Personal',
    'Work',
    'Travel',
    'Shopping',
    'Fitness',
    'Ideas',
    'Education',
    'Planning',
    'Finances'
  ];
  String category = 'Personal';
  int _categoryIndex = 0;

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgGrey,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: AppColors.black10,
            height: 1.0,
          ),
        ),
        title: Text(
          'New Note',
          style: TextStyle(
            color: AppColors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {
                if (noteController.text.isNotEmpty) {
                  context.read<NotesBloc>().add(
                        AddNoteEvent(
                          note: NoteModel(
                              note: noteController.text,
                              priority: priority,
                              category: category),
                        ),
                      );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: AppColors.green,
                      content: Text(
                        'New note created!',
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                  );
                  context.router.push(MainRoute());
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: AppColors.red,
                      content: Text(
                        'Firstly, enter information',
                        style: TextStyle(color: AppColors.white),
                      ),
                    ),
                  );
                }
              },
              child: Text(
                'Done',
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  maxLines: 10,
                  style: TextStyle(color: AppColors.black),
                  controller: noteController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: AppColors.white,
                    hintText: 'Note text..',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.black10),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: AppColors.black10),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Priority',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 5),
                ChipList(
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  spacing: 1,
                  runSpacing: 1,
                  listOfChipNames: priorityList,
                  activeBorderColorList: [AppColors.black10],
                  inactiveBorderColorList: [AppColors.black10],
                  activeBgColorList: [AppColors.white],
                  inactiveBgColorList: [AppColors.white],
                  activeTextColorList: [
                    AppColors.red,
                    AppColors.yellow,
                    AppColors.green
                  ],
                  inactiveTextColorList: [AppColors.black40],
                  listOfChipIndicesCurrentlySeclected: [_priorityIndex],
                  shouldWrap: true,
                  checkmarkColor: AppColors.black40,
                  extraOnToggle: (val) {
                    _priorityIndex = val;
                    setState(() {
                      priority = priorityList[_priorityIndex];
                    });
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'Categories',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: 5),
                ChipList(
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  spacing: 1,
                  runSpacing: 1,
                  listOfChipNames: categoryList,
                  activeBorderColorList: [AppColors.black10],
                  inactiveBorderColorList: [AppColors.black10],
                  activeBgColorList: [AppColors.white],
                  inactiveBgColorList: [AppColors.white],
                  activeTextColorList: [AppColors.black],
                  inactiveTextColorList: [AppColors.black40],
                  listOfChipIndicesCurrentlySeclected: [_categoryIndex],
                  shouldWrap: true,
                  checkmarkColor: AppColors.black40,
                  extraOnToggle: (val) {
                    _categoryIndex = val;
                    setState(() {
                      category = categoryList[_categoryIndex];
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
