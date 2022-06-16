// Multi BlocProvider
// BlocBuilder<CounterCubit, int>(builder: ) => to get Data
// BlocProvider.of<CounterCubit>(context).increment(); => to call function

import 'dart:developer';

import 'package:counter_cubit/cubit/counter_cubit.dart';
import 'package:counter_cubit/cubit/network_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Home();
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider( 
      providers: [
        BlocProvider(create: (context) => CounterCubit(),),
        BlocProvider(create: (context) => NetworkCubit(),),
      ],
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Flutter Counter Cupit'),
          ),
          body: BlocBuilder<CounterCubit, int>(
            builder: (context, state) {
              return Column(
                children: [
                  Center(
                      child: Text(
                    'The value is $state',
                    style: TextStyle(fontSize: 20),
                  )),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      OutlinedButton.icon(
                          onPressed: () {
                            BlocProvider.of<CounterCubit>(context).increment();
                          },
                          icon: Icon(Icons.add),
                          label: Text('Add')),
                      SizedBox(
                        width: 10,
                      ),
                      OutlinedButton.icon(
                          onPressed: () {
                            BlocProvider.of<CounterCubit>(context).decrement();
                          },
                          icon: Icon(Icons.remove),
                          label: Text('Minus')),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(onPressed: () {
                        BlocProvider.of<NetworkCubit>(context).loading();
                      }, child: Text("Loading")),
                      ElevatedButton(onPressed: () {
                        BlocProvider.of<NetworkCubit>(context).success();
                      }, child: Text("Success")),
                      ElevatedButton(onPressed: () {
                        BlocProvider.of<NetworkCubit>(context).failure();
                      }, child: Text("Failure")),
                    ],
                  ),
                  BlocBuilder<NetworkCubit, NetworkState>(
                    builder: (context, state){
                      if(state is NetworkSuccess){
                        return Text(state.data);
                      }
                      else if(state is NetworkFailure){
                        return Text(state.error);
                      }
                      else{
                        return Center(child: CircularProgressIndicator(),);
                      }
                    }
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
