import 'package:project_c/colors.dart';
import 'package:project_c/component/main_calendar.dart';
import 'package:flutter/material.dart';
import 'package:project_c/component/schedule_bottom_sheet.dart';
import 'package:project_c/component/schedule_card.dart';
import 'package:project_c/component/today_banner.dart';
import 'package:get_it/get_it.dart';
import 'package:project_c/database/drift_database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.utc(
    DateTime.now().year,
    DateTime.now().month,
    DateTime.now().day,
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          MainCalendar(
            selectedDate: selectedDate,
            onDaySelected: onDaySelected,
          ),
          TodayBanner(selectedDate: selectedDate, count: 0),
          const SizedBox(
            height: 8.0,
          ),
          Expanded(
              child: StreamBuilder<List<Schedule>>(
            stream: GetIt.I<LocalDatabase>().watchSchedules(selectedDate),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container();
              }
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final schedule = snapshot.data![index];
                    return Padding(
                      padding: const EdgeInsets.only(
                          bottom: 8.0, left: 8.0, right: 8.0),
                      child: ScheduleCard(
                        startTime: schedule.startTime,
                        endTime: schedule.endTime,
                        content: schedule.content,
                      ),
                    );
                  });
            },
          ))
        ],
      )),
      floatingActionButton: FloatingActionButton(
          backgroundColor: PRIMARY_COLOR,
          onPressed: () {
            showModalBottomSheet(
                context: context,
                isDismissible: true,
                builder: (_) => ScheduleBottomSheet(
                      selectedDate: selectedDate,
                    ),
                isScrollControlled: true);
          },
          child: const Icon(Icons.add)),
    );
  }

  void onDaySelected(DateTime selectedDate, DateTime focusedDate) {
    setState(() {
      this.selectedDate = selectedDate;
    });
  }
}
