// We now use AsyncNotifierProvider instead of FutureProvider
import 'dart:convert';

import 'package:demo1/models/activity_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

final activityNotifierProvider =
    AsyncNotifierProvider.autoDispose<ActivityState, ActivityModel>(
  ActivityState.new,
);

// We use an AsyncNotifier because our logic is asynchronous.
// More specifically, we'll need AutoDisposeAsyncNotifier because
// of the "autoDispose" modifier.
class ActivityState extends AutoDisposeAsyncNotifier<ActivityModel> {
  // Hàm khởi tạo global state.
  @override
  Future<ActivityModel> build() async {
    // The logic we previously had in our FutureProvider is now in the build method.
    // Using package:http, we fetch a random activity from the Bored API.
    final response = await get(Uri.https('boredapi.com', '/api/activity'));
    // Using dart:convert, we then decode the JSON payload into a Map data structure.
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    // Finally, we convert the Map into an Activity instance.
    return ActivityModel.fromJson(json);
  }

  // Hàm để thao tác với global state

  // Ví dụ TH: POST xong  lưu response  vào global state
  Future<void> addActivity(ActivityModel activity) async {
    final response = await post(
      Uri.https('your_api.com', '/todos'),
      // We serialize our Todo object and POST it to the server.
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(activity),
    );

    // Muốn lấy ra giá trị của state hiện tại , ta dùng:
    // final previousState = await future;

    // Using dart:convert, we then decode the JSON payload into a Map data structure.
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    // Finally, we convert the Map into an Activity instance.
    // We update the local cache to match the new state.
    // This will notify all listeners.
    state = AsyncData(ActivityModel.fromJson(json));
  }

// Ví dụ TH: POST xong resfresh lại global state
  Future<void> refreshActivity(ActivityModel activity) async {
    // We don't care about the API response
    await post(
      Uri.https('your_api.com', '/todos'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(activity),
    );

    // Để refresh lại global state
    ref.invalidateSelf();

    // (Optional) We can then wait for the new state to be computed.
    // This ensures "addTodo" does not complete until the new state is available.
    await future;
  }

  // Ví dụ TH: Thay đổi dữ liệu global state = local, không gọi api
  Future<void> changeActivity(ActivityModel activity) async {
    state = const AsyncLoading();
    await Future.delayed(const Duration(seconds: 1));
    state = AsyncData(activity);
  }
}
