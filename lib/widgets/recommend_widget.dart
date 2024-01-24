import 'package:demo1/models/recommend_model.dart';
import 'package:demo1/provider/counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RecommendFnc extends ConsumerWidget {
  const RecommendFnc({
    super.key,
    required this.recommends,
  });

  final List<RecommendModel> recommends;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(routerProvider);

    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          'Recommendation for diet $counter',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Container(
          margin: const EdgeInsets.only(top: 8),
          height: 200,
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(width: 16),
            scrollDirection: Axis.horizontal,
            itemCount: recommends.length,
            itemBuilder: (context, index) {
              return Container(
                width: 150,
                decoration: BoxDecoration(
                  color: recommends[index].color.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: SvgPicture.asset(recommends[index].icon),
                      ),
                      Text(
                        recommends[index].describe,
                        style:
                            const TextStyle(fontSize: 10, color: Colors.black),
                      ),
                      Text(recommends[index].name),
                      TextButton(
                        style: const ButtonStyle(
                            padding:
                                MaterialStatePropertyAll(EdgeInsets.all(0))),
                        onPressed: () {
                          ref.read(routerProvider.notifier).state++;
                        },
                        child: const Text("Buy"),
                      )
                    ]),
              );
            },
          ),
        )
      ]),
    );
  }
}
