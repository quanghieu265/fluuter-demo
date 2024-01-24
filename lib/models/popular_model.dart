class PopularModal {
  String name;
  String icon;

  PopularModal({
    required this.name,
    required this.icon,
  });

  static List<PopularModal> getPopularList() {
    List<PopularModal> popular = [];

    popular.add(PopularModal(
      name: "Blueberry Pancake",
      icon: 'assets/icons/blueberry-pancake.svg',
    ));

    popular.add(PopularModal(
      name: "Salmon Nigiri",
      icon: 'assets/icons/salmon-nigiri.svg',
    ));

    return popular;
  }
}
