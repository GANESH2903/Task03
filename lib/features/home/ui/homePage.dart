import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task3/data/addOrUpdateNotesDetails.dart';
import 'package:task3/features/home/ui/allNotes.dart';
import 'package:task3/features/home/bloc/home_bloc.dart';
import 'package:task3/features/home/ui/navigationDrawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState(){
    homeBloc.add(HomeInitialFetchEvent());
    super.initState();
  }
  final HomeBloc homeBloc = HomeBloc();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      bloc: homeBloc,
      listenWhen: (previous , current) => current is HomeActionState,
      buildWhen: (previous , current) => current is !HomeActionState,
      listener: (context, state) {
        if(state is HomeNavigateToAddNotesDetailsActionState){
          addOrUpdateNotesDetails add = new addOrUpdateNotesDetails();
          add.getNotes(context, "Add");
        }
      },
      builder: (context, state) {
        switch (state.runtimeType){
          case HomeLoadingState:
            return Scaffold(body: Center(child: CircularProgressIndicator(),),);
          case HomeLoadedSuccessState:
            return Scaffold(
              appBar: AppBar(
                backgroundColor: Color.fromARGB(255, 215, 247, 245),
                title: Text("MyNotesApp"),
                actions: [],
              ),
              drawer: navigationDrawer(),
              body: Center(
                child: Container(
                  margin: EdgeInsets.only(left: 35 , right: 35 , top: 40),
                  child: Column(
                      children : [
                        // AllNotes()
                        if(state is HomeLoadedSuccessState) AllNotes(),
                      ]
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(onPressed: (){
                homeBloc.add(HomeNotesAddButtonClickedEvent());
              },child: Icon(Icons.add),),
            );
          case HomeErrorState:
            return Scaffold(body: Center(child: Text("Error Occured"),),);
          default:
            return Scaffold();
        }
      },
    );
  }
}
