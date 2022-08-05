import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/component/widget/widget.dart';
import 'package:new_app/cubit/cubit.dart';
import 'package:new_app/cubit/states.dart';

class SearchScreen extends StatelessWidget {
  var searchControlre = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                    controller: searchControlre,
                    hint: 'Search ',
                    label: 'Search',
                    prifix: Icons.search,
                    type: TextInputType.text,
                    validate: (String value) {
                      if (value.isEmpty) {
                        return 'Search Must Not Bee Empty';
                      }
                      return null;
                    },
                    onChange: (value) {
                      NewsCubit.get(context).getSearch(value);
                    }),
              ),
              Expanded(
                child: articleBuilder(list, context, isSearch: true),
              )
            ],
          ),
        );
      },
    );
  }
}
