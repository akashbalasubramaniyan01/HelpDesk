class Items {
  final String img;
  final String title;
  final String subTitle;

  ///
  Items({
    required this.img,
    required this.title,
    required this.subTitle,
  });
}

List<Items> listOfItems = [
  Items(
    img: "assets/helpdesk2.png",
    title: 'Helpdesk',
    subTitle:
        "Solve More Tickets in Less Time\nMore Productivity",
  ),
  Items(
    img: "assets/helpdesk1.png",
    title: "Custumer Support",
    subTitle:
        "Best in Class help Desk Software for the Best Customer Experience",
  ),
  Items(
    img: "assets/support.png",
    title: "customer satisfaction",
    subTitle: "help desk and giving feedback to improve\nprocesses, knowledge bases, and solutions.",
  ),
];
