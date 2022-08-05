import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_app/cubit/states.dart';
import 'package:new_app/modules/busniss/business_screen.dart';
import 'package:new_app/modules/scince/scince_screen.dart';
import 'package:new_app/modules/seting/setting.dart';
import 'package:new_app/modules/sport/sport_screen.dart';
import 'package:new_app/network/cachHelper.dart';
import 'package:new_app/network/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  // Theme Mode ///////////////////////////////
  bool isDark = false;
  void changeAppMode({bool fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
      emit(ChangeModeState());
    } else {
      isDark = !isDark;
      CachHelper.putData(key: 'isDark', value: isDark).then((value) {
        emit(ChangeModeState());
      });
    }
  }

  // BottomNavigationBar /////////////////////////////////////////
  int currentIndex = 0;
  List<BottomNavigationBarItem> bottomItem = [
    BottomNavigationBarItem(
      icon: Icon(Icons.business),
      label: "Business",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.sports),
      label: "Sports",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.science),
      label: "Science",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      label: "Setting",
    ),
  ];

  List<Widget> screen = [
    BusinessScreen(),
    SportScreen(),
    ScinceScreen(),
    SettingScreen(),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    if (index == 1) getSports();
    if (index == 2) getScince();
    emit(NewsBottomNavState());
  }

//End BottomNavigationBar  /////////////////////////////////////////////

// Get Business ////////////////////////////////////
  List<dynamic> business = [];
  void getBusiness() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': '367ca81320f4487492d0777e522ddcf5',
      },
    ).then((value) {
      print(value.data['status']);
      // print(value.data['totalResults']);
      // print(value.data['articles'][0]['title']);
      // print(value.data.toString());

      //print(value.data['totalResults']);
      business = value.data['articles'];
      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

// Get Sports ////////////////////////////////////
  List<dynamic> sports = [];
  void getSports() {
    emit(NewsGetBusinessLoadingState());
    if (sports.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'sports',
          'apiKey': '367ca81320f4487492d0777e522ddcf5'
        },
      ).then((value) {
        //print(value.data['totalResults']);
        sports = value.data['articles'];
        print(sports[0]['title']);
        emit(NewsGetSportsSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

// Get Science ////////////////////////////////////
  List<dynamic> science = [];
  void getScince() {
    emit(NewsGetBusinessLoadingState());

    if (science.length == 0) {
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country': 'eg',
          'category': 'science',
          'apiKey': '367ca81320f4487492d0777e522ddcf5'
        },
      ).then((value) {
        //print(value.data['totalResults']);
        science = value.data['articles'];
        print(science[0]['title']);
        emit(NewsGetScienceSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

// Get Search ///////////////////////////////////////
  List<dynamic> search = [];
  void getSearch(String value) {
    emit(NewsGetSearchLoadingState());

    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': '367ca81320f4487492d0777e522ddcf5',
      },
    ).then((value) {
      //print(value.data['totalResults']);
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
}
