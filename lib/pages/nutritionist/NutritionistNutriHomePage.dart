import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:save_children_v01/etc/Colors.dart';
import 'package:save_children_v01/model/MealPlannerModel.dart';
import 'package:save_children_v01/pages/auth/NutriAdminLoginPage.dart';
import 'package:save_children_v01/service/MealPlannerService.dart';
import 'package:save_children_v01/service/RecipeService.dart';

import 'NutritionistDietRegisterPage.dart';

class NutritionistNutriHomePageWidget extends StatefulWidget {
  const NutritionistNutriHomePageWidget({Key? key}) : super(key: key);

  @override
  _NutritionistNutriHomePageWidgetState createState() =>
      _NutritionistNutriHomePageWidgetState();
}

class _NutritionistNutriHomePageWidgetState
    extends State<NutritionistNutriHomePageWidget> {
  List<String> items = [
    "최신 순",
    "가격 순",
  ];
  String selectedItem = "최신 순";

  @override
  Widget build(BuildContext context) {
    return Consumer2<MealPlannerService, RecipeService>(
        builder: (context, mealPlannerService, recipeService, child) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            '추천 식단 목록',
          ),
          actions: [
            // Logout button
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 20.0, 0.0),
              child: IconButton(
                icon: Icon(
                  Icons.login_rounded,
                  size: 24.0,
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => NutriAdminPageWidget()));
                },
              ),
            ),
          ],
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: mealPlannerService.mealPlannerList.length,
                itemBuilder: (context, index) {
                  final mealPlanner = mealPlannerService.mealPlannerList[index];
                  if (index == mealPlannerService.mealPlannerList.length - 1) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
                      child: ProductDetailsWidget(
                          mealPlanner: mealPlanner, idx: index),
                    );
                  }
                  return ProductDetailsWidget(
                      mealPlanner: mealPlanner, idx: index);
                },
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            for (int i = 0; i < recipeService.recipeList.length; i++) {
              recipeService.recipeList[i].selected = false;
            }
            recipeService.selectedRecipeList.clear();
            recipeService.calNutriInfo();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const NutritionistDietRegisterPageWidget()));
          },
          backgroundColor: primary,
          icon: Icon(
            Icons.receipt,
            color: primaryBackground,
          ),
          elevation: 8.0,
          label: Text(
            '추천 식단 짜기',
            style: TextStyle(
              fontFamily: 'SUITE',
              color: primaryBackground,
              fontSize: 20.0,
            ),
          ),
        ),
      );
    });
  }
}

class ProductDetailsWidget extends StatelessWidget {
  const ProductDetailsWidget(
      {super.key, required this.mealPlanner, required this.idx});

  final MealPlanner mealPlanner;
  final int idx;

  @override
  Widget build(BuildContext context) {
    return // Generated code for this UserList9 Widget...
        Padding(
            padding: EdgeInsetsDirectional.fromSTEB(10.0, 8.0, 10.0, 0.0),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: secondaryBackground,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 0.0,
                    color: primaryBackground,
                    offset: Offset(0.0, 1.0),
                  )
                ],
                borderRadius: BorderRadius.circular(0.0),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 0.0, 5.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8.0),
                      child: Image.network(
                        "${mealPlanner.menuImg1}",
                        width: 60.0,
                        height: 60.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 0.0, 0.0, 0.0),
                                child: Text(
                                  '${mealPlanner.mealPlannerName}',
                                  style: TextStyle(
                                      fontFamily: 'SUITE',
                                      color: info,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 2.0, 0.0, 0.0),
                                child: Text(
                                  '${mealPlanner.kcal!.toStringAsFixed(1)}kcal',
                                  style: TextStyle(
                                      fontFamily: 'SUITE',
                                      fontSize: 13.0,
                                      color: secondaryText),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    16.0, 2.0, 0.0, 0.0),
                                child: Text(
                                  '탄수화물 ${mealPlanner.carbohydrate!.toStringAsFixed(1)}g, 단백질 ${mealPlanner.protein!.toStringAsFixed(1)}g, 지방 ${mealPlanner.fat!.toStringAsFixed(1)}g',
                                  style: TextStyle(
                                    fontFamily: 'SUITE',
                                    fontSize: 10.0,
                                    color: secondaryText,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.delete_sharp,
                                  color: secondaryText,
                                  size: 17.0,
                                ),
                                onPressed: () {
                                  context
                                      .read<MealPlannerService>()
                                      .deleteMealPlanner(
                                          mealPlanner.mealPlannerId!);
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.mode_edit_sharp,
                                  color: secondaryText,
                                  size: 17.0,
                                ),
                                onPressed: () {
                                  // 식단 list의 idx.
                                  // selectedList에 넣기.
                                  final menus = [
                                    mealPlanner.menuName1,
                                    mealPlanner.menuName2,
                                    mealPlanner.menuName3,
                                    mealPlanner.menuName4,
                                  ];

                                  context
                                      .read<RecipeService>()
                                      .selectMenus(menus);
                                  context.read<RecipeService>().calNutriInfo();

                                  Navigator.pushNamed(
                                      context, "/NutritionistDietEditPage",
                                      arguments: idx); // TODO : 수정 구현
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}
