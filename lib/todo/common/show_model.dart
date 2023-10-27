import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:practico_postips/todo/constants/app_style.dart';
import 'package:practico_postips/todo/provider/date_time_provider.dart';
import 'package:practico_postips/todo/provider/radio_provider.dart';
import 'package:practico_postips/todo/widget/date_time_widget.dart';
import 'package:practico_postips/todo/widget/radio_widget.dart';
import 'package:practico_postips/todo/widget/textfield_widget.dart';

class AddNewTaskModel extends ConsumerWidget {
    const AddNewTaskModel({
        super.key,
    });

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
                        const TextFieldWidget(
                                maxLine: 1, hintText: 'Escribe el título del Recordatorio'),
                        const Gap(12),
                        const Text(
                            'Descripción del recordatorio',
                            style: AppStyle.headingOne,
                        ),
                        const Gap(6),
                        const TextFieldWidget(
                                maxLine: 5, hintText: 'Escribe la descripción del recordatorio'),
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
                                        onChangedValue: () => ref.read(radioProvider.notifier).update
                                        ((state) =>1),
                                    ),
                                ),
                                Expanded(
                                    child: RadioWidget(
                                        cateColor: Colors.blue.shade700,
                                        titleRadio: 'WORK',
                                        valueInput: 2,
                                        onChangedValue: () => ref.read(radioProvider.notifier).update
                                        ((state) =>2),
                                    ),
                                ),
                                Expanded(
                                    child: RadioWidget(
                                        cateColor: Colors.amberAccent.shade700,
                                        titleRadio: 'GEN',
                                        valueInput: 3,
                                        onChangedValue: () => ref.read(radioProvider.notifier).update
                                        ((state) =>3),
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
                                        if(getValue != null){
                                            final format = DateFormat.yMd();
                                            ref
                                            .read(dateProvider.notifier).update((state) =>
                                            format.format(getValue));
                                        }
                                    },
                                ),
                                Gap(22),
                                DateTimeWidget(
                                    titleText: 'Hora',
                                    valueText: ref.watch(timeProvider),
                                    iconSection: CupertinoIcons.clock,
                                        onTap: () async{
                                            final getTime =
                                            await showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now());

                                            if(getTime != null){
                                                ref.
                                                read(timeProvider.notifier).
                                                update((state) =>getTime.format(context));
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
                                        onPressed: () =>Navigator.pop(context),
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
                                        onPressed: () {},
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






