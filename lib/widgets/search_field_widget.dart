import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SearchFieldsFnc extends StatelessWidget {
  const SearchFieldsFnc({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: const Color(0xff1D1617).withOpacity(0.1),
          blurRadius: 10,
        )
      ]),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search Input",
          hintStyle: const TextStyle(color: Colors.black12, fontSize: 14),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: SvgPicture.asset('assets/icons/Search.svg'),
          ),
          suffixIcon: Container(
            decoration: const BoxDecoration(
                border: Border(left: BorderSide(color: Colors.black12))),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: SvgPicture.asset('assets/icons/Filter.svg'),
            ),
          ),
          fillColor: Colors.white,
          filled: true,
          contentPadding: const EdgeInsets.all(8),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none),
        ),
      ),
    );
  }
}
