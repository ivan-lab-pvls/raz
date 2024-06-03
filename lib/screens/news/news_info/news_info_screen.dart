import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mindmemo_app/models/news_model.dart';
import 'package:mindmemo_app/theme/colors.dart';
import 'package:mindmemo_app/widgets/app_container.dart';

@RoutePage()
class NewsInfoScreen extends StatefulWidget {
  final NewsModel news;

  const NewsInfoScreen({super.key, required this.news});

  @override
  State<NewsInfoScreen> createState() => _NewsInfoScreenState();
}

class _NewsInfoScreenState extends State<NewsInfoScreen> {
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
          'News',
          style: TextStyle(
            color: AppColors.black,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  child: Image.asset(
                    widget.news.image,
                    fit: BoxFit.cover,
                    height: 180,
                    width: double.infinity,
                  ),
                ),
                SizedBox(height: 15),
                AppContainer(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.news.title,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        widget.news.subtitle,
                        style: TextStyle(
                          color: AppColors.black40,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 15),
                      Divider(
                        height: 2,
                        color: AppColors.black10,
                      ),
                      SizedBox(height: 15),
                      Text(
                        widget.news.article,
                        style: TextStyle(
                          color: AppColors.black40,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
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
