import 'dart:convert';
import 'package:demo1/models/activity_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';

// Provider chỉ có duy nhất 1 hàm khởi tạo global state.
final activityProvider = FutureProvider.autoDispose((ref) async {
  // Using package:http, we fetch a random activity from the Bored API.
  final response = await get(Uri.https('boredapi.com', '/api/activity'));
  // Using dart:convert, we then decode the JSON payload into a Map data structure.
  final json = jsonDecode(response.body) as Map<String, dynamic>;
  // Finally, we convert the Map into an Activity instance.
  return ActivityModel.fromJson(json);
});

// Tạo Provider với params truyền vào, sử dụng .family.
// We define a record representing the parameters we want to pass to the provider.
// Making a typedef is optional but can make the code more readable.
typedef ActivityParameters = ({String type, int maxPrice});

final activityProviderWithParams = FutureProvider.autoDispose
    // We now use the newly defined record as the argument type.
    .family<ActivityModel, ActivityParameters>((ref, arguments) async {
  final response = await get(
    Uri(
      scheme: 'https',
      host: 'boredapi.com',
      path: '/api/activity',
      queryParameters: {
        // Lastly, we can use the arguments to update our query parameters.
        'type': arguments.type,
        'price': arguments.maxPrice,
      },
    ),
  );
  final json = jsonDecode(response.body) as Map<String, dynamic>;
  return ActivityModel.fromJson(json);
});

// Ở Consumer ta truyền param cho Provider = ref.watch
// ref.watch(
//   // Using a Record, we can pass our parameters.
//   // It is fine to create the record directly
//   // in the watch call as records override ==.
//   activityProvider((type: 'recreational', maxPrice: 40)),
// );
