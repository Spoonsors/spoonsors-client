import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:save_children_v01/service/RecipeService.dart';

import '../etc/Colors.dart';
import '../etc/TextStyles.dart';

class NutritionistDietAddFoodBottomSheetWidget extends StatefulWidget {
  const NutritionistDietAddFoodBottomSheetWidget({super.key});

  @override
  State<NutritionistDietAddFoodBottomSheetWidget> createState() =>
      _NutritionistDietAddFoodBottomSheetWidgetState();
}

class _NutritionistDietAddFoodBottomSheetWidgetState
    extends State<NutritionistDietAddFoodBottomSheetWidget> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RecipeService>(builder: (context, recipeService, child) {
      return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.sizeOf(context).height * 0.9,
            ),
            decoration: BoxDecoration(
              color: secondaryBackground,
              borderRadius: BorderRadius.circular(16.0),
              border: Border.all(
                color: alternate,
              ),
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(24.0, 24.0, 24.0, 24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 12.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 4.0),
                                child: Text(
                                  '메뉴 추가/변경',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 24,
                                    color: primaryText,
                                    fontFamily: 'SUITE',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    0.0, 0.0, 0.0, 8.0),
                                child: Text(
                                  '메뉴를 추가/변경 해주세요.',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: secondaryText,
                                    fontFamily: 'SUITE',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.close_rounded,
                            color: secondaryText,
                            size: 30.0,
                          ),
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding:
                            EdgeInsetsDirectional.fromSTEB(8.0, 0.0, 8.0, 30.0),
                        child: Container(
                          width: double.infinity,
                          child: TextFormField(
                            onChanged: (value) {
                              recipeService.searchText = value;
                              recipeService.searchRecipeByText();
                            },
                            obscureText: false,
                            decoration: InputDecoration(
                              hintText: '메뉴명',
                              hintStyle: TextStyle(
                                fontFamily: 'SUITE',
                                color: secondaryText,
                                fontSize: 20.0,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: alternate,
                                  width: 2.0,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: primary,
                                  width: 2.0,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: error,
                                  width: 2.0,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              focusedErrorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: error,
                                  width: 2.0,
                                ),
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(4.0),
                                  topRight: Radius.circular(4.0),
                                ),
                              ),
                              suffixIcon: Icon(
                                Icons.search,
                              ),
                            ),
                            style: TextStyle(
                              fontFamily: 'SUITE',
                              fontSize: 22.0,
                              color: primaryText,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: recipeService.searchedRecipeList.isEmpty
                        ? ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: recipeService.recipeList.length,
                            itemBuilder: (context, index) {
                              final recipe = recipeService.recipeList[index];
                              return GestureDetector(
                                  onTap: () {
                                    bool isToast = recipeService
                                        .selectRecipe(recipe.recipe.rcp_SEQ);
                                    if (isToast) {
                                      _showToast();
                                    }
                                  },
                                  child: detailMenuInfoWidget(recipe: recipe));
                            })
                        : ListView.builder(
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: recipeService.searchedRecipeList.length,
                            itemBuilder: (context, index) {
                              final recipe =
                                  recipeService.searchedRecipeList[index];
                              return GestureDetector(
                                  onTap: () {
                                    bool isToast = recipeService
                                        .selectRecipe(recipe.recipe.rcp_SEQ);
                                    if (isToast) {
                                      _showToast();
                                    }
                                  },
                                  child: detailMenuInfoWidget(recipe: recipe));
                            }),
                  ),
                  Flexible(
                    child: Padding(
                      padding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 16.0, 0.0, 0.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 4.0, 0.0),
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                '완료',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                  fontFamily: 'SUITE',
                                  color: Colors.white,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                fixedSize: Size.fromHeight(50.0),
                                padding: EdgeInsetsDirectional.fromSTEB(
                                    32.0, 0.0, 32.0, 0.0),
                                backgroundColor: primary,
                                elevation: 2.0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}

class detailMenuInfoWidget extends StatefulWidget {
  const detailMenuInfoWidget({super.key, required this.recipe});

  final SelectedRecipe recipe;

  @override
  State<detailMenuInfoWidget> createState() => _detailMenuInfoWidgetState();
}

class _detailMenuInfoWidgetState extends State<detailMenuInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(5.0, 5.0, 5.0, 5.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  alignment: AlignmentDirectional(0.0, 0.0),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(2.0, 2.0, 2.0, 2.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6.0),
                      child: Image.network(
                        '${widget.recipe.recipe.att_FILE_NO_MAIN}',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(12.0, 0.0, 0.0, 0.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.recipe.recipe.rcp_NM}', // TODO : 중량 추가
                          style: TextStyle(
                            fontFamily: 'SUITE',
                            fontSize: 13.0,
                            fontWeight: FontWeight.w500,
                            color: primaryText,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 8.0, 0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 1.0, 0.0, 1.0),
                                  child: Text(
                                    '탄수화물 ${widget.recipe.recipe.info_CAR}g, ${widget.recipe.recipe.info_PRO}g, 지방 ${widget.recipe.recipe.info_FAT}g',
                                    style: labelMedium,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 4.0, 0.0, 0.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Text(
                                  '${widget.recipe.recipe.info_ENG}kcal',
                                  style: labelMedium,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            thickness: 0.5,
            color: alternate,
          ),
        ],
      ),
      widget.recipe.selected
          ? Container(
              width: double.infinity,
              height: 80.0,
              decoration: BoxDecoration(
                color: Color(0x74FFFFFF),
              ),
              child: Icon(
                Icons.check_rounded,
                color: success,
                size: 60.0,
              ),
            )
          : Container(),
    ]);
  }
}

void _showToast() {
  Fluttertoast.showToast(
    msg: "최대 4개까지 선택가능합니다.",
    toastLength: Toast.LENGTH_SHORT,
  );
}
