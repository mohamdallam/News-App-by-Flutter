import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/component/widget/widget.dart';
import 'package:new_app/cubit/cubit.dart';
import 'package:new_app/cubit/states.dart';
import 'package:new_app/modules/search/search.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = NewsCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text("News App"),
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    navigateTo(context, SearchScreen());
                  },
                ),
                IconButton(
                  icon: Icon(Icons.brightness_4_outlined),
                  onPressed: () {
                    cubit.changeAppMode();
                  },
                )
              ],
            ),
            body: cubit.screen[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              elevation: 25,
              currentIndex: cubit.currentIndex,
              items: cubit.bottomItem,
              onTap: (index) {
                cubit.changeBottomNavBar(index);
              },
            ),
          );
        },
      );

  }
}
