import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:practico_postips/todo/constants/app_style.dart';
import 'package:practico_postips/todo/model/todo_model.dart';
import 'package:practico_postips/todo/provider/date_time_provider.dart';
import 'package:practico_postips/todo/provider/radio_provider.dart';
import 'package:practico_postips/todo/provider/service_provider.dart';
import 'package:practico_postips/todo/widget/date_time_widget.dart';
import 'package:practico_postips/todo/widget/radio_widget.dart';
import 'package:practico_postips/todo/widget/textfield_widget.dart';

class AddNewTaskModel extends ConsumerWidget {
    AddNewTaskModel({
        Key? key,
    }) : super(key: key);

    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    @override
    Widget build(BuildContext context, WidgetRef ref) {
        final dateProv = ref.watch(dateProvider);
        return Container(
            padding: const EdgeInsets.all(30),
            height: MediaQuery.of(context).size.height * 0.70,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.0),
            ),
            child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        const SizedBox(
                            width: double.infinity,
                            child: Text(
                                'Nuevo Recordatorio',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                ),
                            ),
                        ),
                        Divider(
                            thickness: 1.2,
                            color: Colors.grey.shade200,
                        ),
                        const Gap(12),
                        const Text(
                            'Titulo del recordatorio',
                            style: AppStyle.headingOne,
                        ),
                        const Gap(6),
                        TextFieldWidget(
                            maxLine: 1,
                            hintText: 'Escribe el título del Recordatorio',
                            txtController: titleController,
                        ),
                        const Gap(12),
                        const Text(
                            'Descripción del recordatorio',
                            style: AppStyle.headingOne,
                        ),
                        const Gap(6),
                        TextFieldWidget(
                            maxLine: 5,
                            hintText: 'Escribe la descripción del recordatorio',
                            txtController: descriptionController,
                        ),
                        const Gap(12),
                        const Text(
                            'Categría del recordatorio',
                            style: AppStyle.headingOne,
                        ),
                        Row(
                            children: [
                                Expanded(
                                    child: RadioWidget(
                                        cateColor: Colors.green,
                                        titleRadio: 'LRN',
                                        valueInput: 1,
                                        onChangedValue: () => ref.read(radioProvider.notifier).update((state) => 1),
                                    ),
                                ),
                                Expanded(
                                    child: RadioWidget(
                                        cateColor: Colors.blue.shade700,
                                        titleRadio: 'WORK',
                                        valueInput: 2,
                                        onChangedValue: () => ref.read(radioProvider.notifier).update((state) => 2),
                                    ),
                                ),
                                Expanded(
                                    child: RadioWidget(
                                        cateColor: Colors.amberAccent.shade700,
                                        titleRadio: 'GEN',
                                        valueInput: 3,
                                        onChangedValue: () => ref.read(radioProvider.notifier).update((state) => 3),
                                    ),
                                ),
                            ],
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                DateTimeWidget(
                                    titleText: 'Fecha',
                                    valueText: dateProv,
                                    iconSection: CupertinoIcons.calendar,
                                    onTap: () async {
                                        final getValue = await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(2021),
                                                lastDate: DateTime(2025));
                                        if (getValue != null) {
                                            final format = DateFormat.yMd();
                                            ref.read(dateProvider.notifier).update((state) => format.format(getValue));
                                        }
                                    },
                                ),
                                Gap(22),
                                DateTimeWidget(
                                    titleText: 'Hora',
                                    valueText: ref.watch(timeProvider),
                                    iconSection: CupertinoIcons.clock,
                                    onTap: () async {
                                        final getTime = await showTimePicker(context: context, initialTime: TimeOfDay.now());

                                        if (getTime != null) {
                                            ref.read(timeProvider.notifier).update((state) => getTime.format(context));
                                        }
                                    },
                                ),
                            ],
                        ),
                        Gap(12),
                        Row(
                            children: [
                                Expanded(
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            foregroundColor: Colors.white,
                                            elevation: 0.0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8.0),
                                            ),
                                            padding: const EdgeInsets.symmetric(vertical: 14),
                                        ),
                                        onPressed: () => Navigator.pop(context),
                                        child: Text('Cancelar'),
                                    ),
                                ),
                                Gap(20),
                                Expanded(
                                    child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                            foregroundColor: Colors.white,
                                            elevation: 0.0,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(8.0),
                                            ),
                                            padding: const EdgeInsets.symmetric(vertical: 14),
                                        ),
                                        onPressed: () {
                                            final getRAdioValue = ref.watch(radioProvider);
                                            String category = '';
                                            switch (getRAdioValue) {
                                                case 1:
                                                    category = 'Learning';
                                                    break;
                                                case 2:
                                                    category = 'Working';
                                                    break;
                                                case 3:
                                                    category = 'General';
                                                    break;
                                            }

                                            ref.read(serviceProvider).addNewTask(TodoModel(
                                                    titleTask: titleController.text,
                                                    description: descriptionController.text,
                                                    category: category,
                                                    dateTask: ref.read(dateProvider),
                                                    timeTask: ref.read(timeProvider),
                                                    isDone: false,));
                                            print('data guardado');
                                            titleController.clear();
                                            descriptionController.clear();
                                            ref.read(radioProvider.notifier).update((state) => 0);
                                            Navigator.pop(context);
                                        },
                                        child: Text('Crear'),
                                    ),
                                ),
                            ],
                        )
                    ],
                ),
            ),
        );
    }
}




