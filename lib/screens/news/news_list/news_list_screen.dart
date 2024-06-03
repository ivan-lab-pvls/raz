import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mindmemo_app/models/news_model.dart';
import 'package:mindmemo_app/repository/news_repository.dart';
import 'package:mindmemo_app/router/router.dart';
import 'package:mindmemo_app/theme/colors.dart';
import 'package:mindmemo_app/widgets/app_container.dart';

@RoutePage()
class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgGrey,
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(
            color: AppColors.black10,
            height: 1.0,
          ),
        ),
        leadingWidth: 150,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            'News',
            style: TextStyle(
              color: AppColors.black,
              fontSize: 28,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Container(
              child: ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 16),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: newsRepository.length,
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(height: 15),
                itemBuilder: (BuildContext context, int index) {
                  final NewsModel _news = newsRepository[index];
                  return GestureDetector(
                    onTap: () {
                      context.router.push(NewsInfoRoute(news: _news));
                    },
                    child: AppContainer(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            child: Image.asset(
                              _news.image,
                              fit: BoxFit.cover,
                              height: 145,
                              width: double.infinity,
                            ),
                          ),
                          SizedBox(height: 15),
                          Text(
                            _news.title,
                            style: TextStyle(
                              color: AppColors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            _news.subtitle,
                            style: TextStyle(
                              color: AppColors.black40,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
