import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mindmemo_app/router/router.dart';
import 'package:mindmemo_app/theme/colors.dart';

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/onboarding/onboarding-bg.png"),
              fit: BoxFit.cover,
            ),
          ),
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(flex: 4),
                  Text(
                    'Ideas Always at Your Fingertips',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 32,
                      color: AppColors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Organization with a Personal Assistant for\nNotes and Inspiration!',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: AppColors.black,
                    ),
                  ),
                  Spacer(flex: 1),
                  GestureDetector(
                    onTap: () {
                      context.router.push(MainRoute());
                    },
                    child: Container(
                      height: 50,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColors.black,
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      child: Center(
                        child: Text(
                          'Get started',
                          style: TextStyle(
                            color: AppColors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Spacer(flex: 1),

                ],
              ),
            ),
          )),
    );
  }
}
