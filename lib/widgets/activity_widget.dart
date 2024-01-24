import 'dart:math';

import 'package:demo1/models/activity_model.dart';
import 'package:demo1/notifier/activity_notifier.dart';
import 'package:demo1/provider/activity_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActivityFnc extends ConsumerWidget {
  const ActivityFnc({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Read the activityProvider. This will start the network request
    // if it wasn't already started.
    // By using ref.watch, this widget will rebuild whenever the
    // the activityProvider updates. This can happen when:
    // - The response goes from "loading" to "data/error"
    // - The request was refreshed
    // - The result was modified locally (such as when performing side-effects)
    // ...
    final AsyncValue<ActivityModel> activity = ref.watch(activityProvider);
    final AsyncValue<ActivityModel> activityNotifier =
        ref.watch(activityNotifierProvider);

    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          'Activity',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        activity.when(
          data: (data) => Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff1D1617).withOpacity(0.1),
                    blurRadius: 10,
                  )
                ]),
            child: Text("This Data get form Provider: ${data.activity}"),
          ),
          error: (error, stackTrace) => Text(error.toString()),
          loading: () => const CircularProgressIndicator(),
        ),
        Container(
            margin: const EdgeInsets.only(top: 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xff1D1617).withOpacity(0.1),
                    blurRadius: 10,
                  )
                ]),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: activityNotifier.when(
                    data: (data) => Text(
                      "This Data get form Notifier: ${data.activity}",
                    ),
                    error: (error, stackTrace) => Text(error.toString()),
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                  ),
                ),
                TextButton(
                    onPressed: () {
                      ref
                          .read(activityNotifierProvider.notifier)
                          .changeActivity(ActivityModel(
                              activity:
                                  "Test Notifier ${Random().nextInt(100)}",
                              type: "Test ${Random().nextInt(100)}"));
                    },
                    child: const Text("Change State")),
                TextButton(
                    onPressed: () =>
                        ref.refresh(activityNotifierProvider.notifier),
                    child: const Text("Refresh State"))
              ],
            )),
      ]),
    );
  }
}
