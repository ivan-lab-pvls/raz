import 'package:auto_route/auto_route.dart';
import 'package:chip_list/chip_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mindmemo_app/models/note_model.dart';
import 'package:mindmemo_app/router/router.dart';
import 'package:mindmemo_app/screens/notes/notes_bloc/notes_bloc.dart';
import 'package:mindmemo_app/screens/notes/notes_list/widgets/black_chip.dart';
import 'package:mindmemo_app/theme/colors.dart';
import 'package:mindmemo_app/widgets/app_container.dart';
import 'package:mindmemo_app/widgets/custom_icon_button.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

@RoutePage()
class NotesListScreen extends StatefulWidget {
  const NotesListScreen({super.key});

  @override
  State<NotesListScreen> createState() => _NotesListScreenState();
}

class _NotesListScreenState extends State<NotesListScreen> {
  final searchController = TextEditingController();

  final panelController = PanelController();

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

  bool hasFilters = false;

  List<NoteModel> allNotes = [];
  List<NoteModel> notes = [];

  List<String> filters = [];

  bool hasNotes = false;

  @override
  void initState() {
    getNotes();
    super.initState();
  }

  void getNotes() async {
    final noteBox = Hive.box('notes');

    if (noteBox.isNotEmpty) {
      for (int i = 0; i < noteBox.length; i++) {
        allNotes.add(noteBox.getAt(i));
      }
      allNotes = allNotes.reversed.toList();
      notes = allNotes;
      hasNotes = true;
    }
  }

  void filterNotes() {
    List<NoteModel> _findNotes = [];

    for (NoteModel note in allNotes) {
      if (note.priority == priority && note.category == category) {
        _findNotes.add(note);
      }
    }
    hasFilters = true;
    setState(() => notes = _findNotes);
  }

  void searchNote(String query) {
    hasFilters = false;
    final suggestions = allNotes.where((note) {
      final noteText = note.note.toLowerCase();
      final input = query.toLowerCase();

      return noteText.contains(input);
    }).toList();

    setState(() => notes = suggestions);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgGrey,
      body: SafeArea(
        child: hasNotes
            ? Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 280,
                                child: TextField(
                                  style: TextStyle(color: AppColors.black),
                                  controller: searchController,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.search),
                                    filled: true,
                                    fillColor: AppColors.white,
                                    hintText: 'Search',
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16.0, vertical: 12),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.black10),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12))),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors.black10),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12))),
                                  ),
                                  onChanged: searchNote,
                                ),
                              ),
                              CustomIconButton(
                                iconPath: 'assets/images/notes/filter.svg',
                                onTap: () {
                                  panelController.open();
                                },
                              )
                            ],
                          ),
                          hasFilters ? Column(
                            children: [
                              SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      BlackChip(text: priority),
                                      SizedBox(width: 5),
                                      BlackChip(text: category),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        hasFilters = false;
                                        priority = 'High priority';
                                        category = 'Personal';
                                        _priorityIndex = 0;
                                        _categoryIndex = 0;
                                        notes = allNotes;
                                      });
                                    },
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(
                                        color: AppColors.red,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ) : Container(),
                          SizedBox(height: 20),
                          GridView.builder(
                            itemCount: notes.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 20,
                                    mainAxisSpacing: 20),
                            itemBuilder: (BuildContext context, int index) {
                              final NoteModel _note = notes[index];
                              return GestureDetector(
                                onTap: () {
                                  context.router.push(NoteInfoRoute(note: _note));
                                },
                                child: Container(
                                  width: 170,
                                  height: 180,
                                  child: AppContainer(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AppContainer(
                                            child: Text(
                                          _note.priority,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color:
                                                _note.priority == 'High priority'
                                                    ? AppColors.red
                                                    : _note.priority ==
                                                            'Medium priority'
                                                        ? AppColors.yellow
                                                        : AppColors.green,
                                          ),
                                        )),
                                        SizedBox(height: 5),
                                        AppContainer(
                                            child: Text(
                                          _note.category,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 14,
                                            color: AppColors.black,
                                          ),
                                        )),
                                        SizedBox(height: 5),
                                        Text(
                                          _note.note,
                                          maxLines: 5,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                            color: AppColors.black40,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.bottomCenter,
                    child: SlidingUpPanel(
                      panel: Padding(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    panelController.close();
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: AppColors.red,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                Text(
                                  'Filter',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    filterNotes();
                                    panelController.close();
                                  },
                                  child: Text(
                                    'Save',
                                    style: TextStyle(
                                      color: AppColors.green,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 25),
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
                              activeBorderColorList: [AppColors.black],
                              inactiveBorderColorList: [AppColors.black10],
                              activeBgColorList: [AppColors.black],
                              inactiveBgColorList: [AppColors.white],
                              activeTextColorList: [AppColors.white],
                              inactiveTextColorList: [AppColors.black40],
                              listOfChipIndicesCurrentlySeclected: [
                                _priorityIndex
                              ],
                              shouldWrap: true,
                              checkmarkColor: AppColors.white,
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
                              activeBorderColorList: [AppColors.black],
                              inactiveBorderColorList: [AppColors.black10],
                              activeBgColorList: [AppColors.black],
                              inactiveBgColorList: [AppColors.white],
                              activeTextColorList: [AppColors.white],
                              inactiveTextColorList: [AppColors.black40],
                              listOfChipIndicesCurrentlySeclected: [
                                _categoryIndex
                              ],
                              shouldWrap: true,
                              checkmarkColor: AppColors.white,
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
                      controller: panelController,
                      maxHeight: MediaQuery.of(context).size.height * 0.6,
                      defaultPanelState: PanelState.CLOSED,
                      minHeight: 0,
                      borderRadius:
                          const BorderRadius.vertical(top: Radius.circular(20)),
                      backdropEnabled: true,
                    ),
                  ),
                ],
              )
            : Container(
                padding: const EdgeInsets.all(16.0),
                height: MediaQuery.of(context).size.height * 0.85,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.bottomLeft,
                        child: SizedBox(
                          width: 170,
                          child: Text(
                            'Add notes if you have ideas, plans, tasks, etc.',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: AppColors.black40,
                            ),
                          ),
                        )),
                  ],
                ),
              ),
      ),
      floatingActionButton: CustomIconButton(
        iconPath: 'assets/images/notes/add-note.svg',
        onTap: () {
          context.router.push(AddNoteRoute());
        },
      ),
    );
  }
}
