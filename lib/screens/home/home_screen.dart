import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:rive_animation/models/course.dart';
import 'package:rive_animation/screens/home/components/course_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  'Courses',
                  style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                      color: Colors.black, fontWeight: FontWeight.w700),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...courses
                        .map((course) => Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: CourseCard(course: course),
                            ))
                        .toList()
                    // toList를 해주는 이유?
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text('Recent',
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontWeight: FontWeight.w600)),
              ),
              ...recentCourses.map((course) => Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: SecondaryCourseCard(course: course),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class SecondaryCourseCard extends StatelessWidget {
  final Course course;
  const SecondaryCourseCard({
    required this.course,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: BoxDecoration(
          color: course.bgColor,
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  course.title,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const Text(
                  'Watch video - 15 minutes',
                  style: TextStyle(color: Colors.white60, fontSize: 14),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 7),
            child: SizedBox(
              height: 40,
              child: VerticalDivider(
                color: Colors.white70,
              ),
            ),
          ),
          SvgPicture.asset(course.iconSrc),
        ],
      ),
    );
  }
}
