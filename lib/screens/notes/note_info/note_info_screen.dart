import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mindmemo_app/models/note_model.dart';
import 'package:mindmemo_app/router/router.dart';
import 'package:mindmemo_app/screens/notes/notes_bloc/notes_bloc.dart';
import 'package:mindmemo_app/theme/colors.dart';
import 'package:mindmemo_app/widgets/app_container.dart';

@RoutePage()
class NoteInfoScreen extends StatefulWidget {
  final NoteModel note;

  const NoteInfoScreen({super.key, required this.note});

  @override
  State<NoteInfoScreen> createState() => _NoteInfoScreenState();
}

class _NoteInfoScreenState extends State<NoteInfoScreen> {
  final noteController = TextEditingController();

  @override
  void initState() {
    noteController.text = widget.note.note;
    super.initState();
  }

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
          'Note',
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
                  if (noteController.text != widget.note.note) {
                    context.read<NotesBloc>().add(
                          EditNoteEvent(
                            note: widget.note,
                            editedNote: NoteModel(
                                note: noteController.text,
                                priority: widget.note.priority,
                                category: widget.note.category),
                          ),
                        );
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: AppColors.yellow,
                        content: Text(
                          'Successfully edited!',
                          style: TextStyle(color: AppColors.white),
                        ),
                      ),
                    );
                  }
                  context.router.push(MainRoute());
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: AppColors.red,
                      content: Text(
                        'You leave empty note! Also delete note',
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
                Row(
                  children: [
                    AppContainer(
                        child: Text(
                      widget.note.priority,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: widget.note.priority == 'High priority'
                            ? AppColors.red
                            : widget.note.priority == 'Medium priority'
                                ? AppColors.yellow
                                : AppColors.green,
                      ),
                    )),
                    SizedBox(width: 10),
                    AppContainer(
                        child: Text(
                      widget.note.category,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppColors.black,
                      ),
                    )),
                  ],
                ),
                SizedBox(height: 16),
                TextField(
                  maxLines: 10,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.black),
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
                SizedBox(height: 16),
                GestureDetector(
                  onTap: () {
                    context
                        .read<NotesBloc>()
                        .add(DeleteNoteEvent(note: widget.note));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: AppColors.yellow,
                        content: Text(
                          'Successfully deleted!',
                          style: TextStyle(color: AppColors.white),
                        ),
                      ),
                    );
                    context.router.push(MainRoute());
                  },
                  child: AppContainer(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          'assets/images/notes/delete.svg',
                          color: AppColors.red,
                        ),
                        SizedBox(width: 3),
                        Text(
                          'Delete',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: AppColors.red,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
