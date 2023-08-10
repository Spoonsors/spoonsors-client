class MealPlanner {
  int mealPlanner_id;
  String menu_name1;
  String menu_img1;

  String menu_name2;
  String menu_img2;

  String menu_name3;
  String menu_img3;

  String menu_name4;
  String menu_img4;

  String mealPlanner_name;

  int kcal;
  int carbohydrate;
  int protein;
  int fat;

  String level;
  String timeRequired;

  MealPlanner(
      {required this.mealPlanner_id,
      required this.menu_name1,
      required this.menu_img1,
      required this.menu_name2,
      required this.menu_img2,
      required this.menu_name3,
      required this.menu_img3,
      required this.menu_name4,
      required this.menu_img4,
      required this.mealPlanner_name,
      required this.kcal,
      required this.carbohydrate,
      required this.protein,
      required this.fat,
      required this.level,
      required this.timeRequired});

  factory MealPlanner.fromJson(Map<String, dynamic> json) => MealPlanner(
        mealPlanner_id: json["mealPlanner_id"],
        menu_name1: json["menu_name1"],
        menu_img1: json["menu_img1"],
        menu_name2: json["menu_name2"],
        menu_img2: json["menu_img2"],
        menu_name3: json["menu_name3"],
        menu_img3: json["menu_img3"],
        menu_name4: json["menu_name4"],
        menu_img4: json["menu_img4"],
        mealPlanner_name: json["mealPlanner_name"],
        kcal: json["kcal"],
        carbohydrate: json["carbohydrate"],
        protein: json["protein"],
        fat: json["fat"],
        level: json["level"],
        timeRequired: json["timeRequired"],
      );

  Map<String, dynamic> toJson() => {
        "mealPlanner_id": mealPlanner_id,
        "menu_name1": menu_name1,
        "menu_img1": menu_img1,
        "menu_name2": menu_name2,
        "menu_img2": menu_img2,
        "menu_name3": menu_name3,
        "menu_img3": menu_img3,
        "menu_name4": menu_name4,
        "menu_img4": menu_img4,
        "mealPlanner_name": mealPlanner_name,
        "kcal": kcal,
        "carbohydrate": carbohydrate,
        "protein": protein,
        "fat": fat,
        "level": level,
        "timeRequired": timeRequired,
      };
}