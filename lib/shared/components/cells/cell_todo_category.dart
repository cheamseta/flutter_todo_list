import 'package:flutter/material.dart';
import 'package:flutter_todo_list/constant/const.dart';
import 'package:flutter_todo_list/models/model_todo_category.dart';
import 'package:flutter_todo_list/shared/components/widgets/widget_text.dart';
import 'package:flutter_todo_list/shared/helpers/helper_services.dart';

class TDCellTodoCategory extends StatelessWidget {
  final ModelTodoCategory todoCategory;

  final Function(ModelTodoCategory) onTap;
  const TDCellTodoCategory(
      {super.key, required this.todoCategory, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onTap.call(todoCategory),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: HelperServices.serviceColorFromHex(todoCategory.color),
              borderRadius: BorderRadius.circular(ConstValue.roundedRadius)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TDText(
                      text: todoCategory.emoji,
                      textStyle:
                          const TextStyle(fontSize: 20, color: Colors.black)),
                  const SizedBox(height: 5),
                  TDText.subtitle(todoCategory.title,
                      maxLine: 2, isBold: true, color: Colors.black),
                ],
              ),
              Column(
                children: [
                  Align(
                      alignment: Alignment.centerRight,
                      child: TDText.subtitle(
                          todoCategory.progressCalculation.percentage == 1
                              ? '🥳🎉 ${todoCategory.progressCalculation.displayString}'
                              : todoCategory.progressCalculation.displayString,
                          isBold: true,
                          align: TextAlign.right,
                          color:
                              todoCategory.progressCalculation.percentage == 1
                                  ? const Color.fromARGB(255, 62, 154, 65)
                                  : Colors.black)),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(2)),
                        child: LinearProgressIndicator(
                          value: todoCategory.progressCalculation.percentage,
                          color:
                              todoCategory.progressCalculation.percentage == 1
                                  ? const Color.fromARGB(255, 62, 154, 65)
                                  : Colors.black,
                          backgroundColor: Colors.grey.shade200,
                        )),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  static Widget addTodoCategoryCell({required VoidCallback onTap}) {
    return InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(ConstValue.roundedRadius)),
          child: const Icon(Icons.add, size: 50, color: Colors.white),
        ));
  }
}
