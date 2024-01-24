import 'package:demo1/models/popular_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PopularFnc extends StatefulWidget {
  const PopularFnc({
    super.key,
    required this.popular,
  });

  final List<PopularModal> popular;

  @override
  State<PopularFnc> createState() => _PopularFncState();
}

class _PopularFncState extends State<PopularFnc> {
  // variable
  int selectedIndex = 0;

  void setSelectedIndex(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text(
          "Popular",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                    color: selectedIndex == index
                        ? Colors.white
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: selectedIndex == index
                        ? [
                            BoxShadow(
                              color: const Color(0xff1D1617).withOpacity(0.1),
                              blurRadius: 10,
                            )
                          ]
                        : []),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(widget.popular[index].icon),
                    Text(
                      widget.popular[index].name,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    IconButton(
                        onPressed: () {
                          setSelectedIndex(index);
                        },
                        icon: SvgPicture.asset('assets/icons/button.svg'))
                  ],
                ),
              );
            },
            separatorBuilder: (context, index) => const SizedBox(
                  height: 16,
                ),
            itemCount: widget.popular.length)
      ]),
    );
  }
}
