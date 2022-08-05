import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:new_app/component/bloc_observer/bloc_observer.dart';
import 'package:new_app/cubit/cubit.dart';
import 'package:new_app/cubit/states.dart';
import 'package:new_app/network/cachHelper.dart';
import 'package:new_app/network/dio_helper.dart';
import 'package:new_app/news_layout.dart';

main() async {
  //بيتاكد ان كل حاجه هنا فى الميثود خلصت وبعدين يفتح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CachHelper.init();
  bool isDark = CachHelper.getData(key: 'isDark');
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;

  MyApp(this.isDark);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => NewsCubit()
            ..getBusiness()
            ..getSports()
            ..getScince()
            ..changeAppMode(fromShared: isDark),
        ),
      ],
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,

            // ###### Light Theme ####### //
            theme: ThemeData(
              primarySwatch: Colors.red,
              scaffoldBackgroundColor: Colors.white,
              //  ############## FloatingActionButtonTheme
              floatingActionButtonTheme:
                  FloatingActionButtonThemeData(backgroundColor: Colors.red),
              //  ############## bottomNavigationBar
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                elevation: 20.0,
                backgroundColor: Colors.white,
              ),
              //  ############## AppBar
              appBarTheme: AppBarTheme(
                titleSpacing: 20,
                backgroundColor: Colors.white,
                elevation: 0,
                //Text Style
                titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
                //End Text Style
                //Status Bar Colors
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                  //End Status Bar
                ),
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
              ),
              //  ############## Text Theme
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),

            // ###### Dark Theme ######### //
            darkTheme: ThemeData(
              primarySwatch: Colors.red,
              scaffoldBackgroundColor: HexColor('333739'),
              // ################# FloatingActionButtonTheme
              floatingActionButtonTheme:
                  FloatingActionButtonThemeData(backgroundColor: Colors.red),
              // ################# AppBarTheme
              appBarTheme: AppBarTheme(
                titleSpacing: 20,
                backgroundColor: HexColor('333739'),
                elevation: 0,
                //Text Style
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),

                //Status Bar Colors
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor('333739'),
                  statusBarIconBrightness: Brightness.light,
                  //End Status Bar
                ),
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
              ),
              // ################# BottomNavigationBar
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType.fixed,
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                elevation: 20.0,
                backgroundColor: HexColor('333739'),
              ),
              // ################# Text Theme
              textTheme: TextTheme(
                bodyText1: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),

            themeMode: NewsCubit.get(context).isDark
                ? ThemeMode.dark
                : ThemeMode.light,
            home: NewsLayout(),
          );
        },
      ),
    );
  }
}
// NewsCubit.get(context).isDark ? ThemeMode.dark: ThemeMode.light,
