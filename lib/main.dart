import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import 'package:blocprovider/screens/notes/homescreen.dart';
import 'package:blocprovider/screens/loginscreen.dart';
import 'package:blocprovider/screens/notes/createupdatenotescreen.dart';
import 'package:blocprovider/screens/verifyemail.dart';
import 'package:blocprovider/service/auth/auth_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/registerscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    AuthService.firebase().initialize();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          primarySwatch: Colors.red,
          accentColor: Colors.orangeAccent,
          fontFamily: 'SansitaSwashed'),
      home: Home(),
      //   home: LoginScreen(),
      //   // RegisterScreen(),
      //   routes: {
      //     HomeScreen.routeName: (context) => HomeScreen(),
      //     RegisterScreen.routeName: (context) => RegisterScreen(),
      //     LoginScreen.routeName: (context) => LoginScreen(),
      //     VerifyEmailScreen.routeName: (context) => VerifyEmailScreen(),
      //     CreateUpdateNoteScreen.routeName: (context) => CreateUpdateNoteScreen(),
      //   },
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final TextEditingController _controller;
  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('text bloc'),
        ),
        body:
            BlocConsumer<CounterBloc, CounterState>(builder: (context, state) {
          final invalidValue =
              (state is CounterStateInValidNumber) ? state.invalidValue : '';
          return Column(
            children: [
              Text('Current value=> ${state.value}'),
              Visibility(
                child: Text('Invalid input: $invalidValue'),
                visible: state is CounterStateInValidNumber,
              ),
              TextField(
                controller: _controller,
                decoration: InputDecoration(hintText: 'Enter a number here'),
                keyboardType: TextInputType.number,
              ),
              Row(
                children: [
                  TextButton(
                      onPressed: () {
                        context
                            .read<CounterBloc>()
                            .add(DecrementEvent(_controller.text));
                      },
                      child: Text('-')),
                  TextButton(
                      onPressed: () {
                        context
                            .read<CounterBloc>()
                            .add(incrementEvent(_controller.text));
                      },
                      child: Text('+')),
                ],
              )
            ],
          );
        }, listener: (context, state) {
          _controller.clear();
        }),
      ),
    );
  }
}

@immutable
abstract class CounterState {
  final int value;

  CounterState(this.value);
}

class CounterStateValid extends CounterState {
  CounterStateValid(int value) : super(value);
}

class CounterStateInValidNumber extends CounterState {
  final String invalidValue;
  CounterStateInValidNumber({
    required this.invalidValue,
    required int previousValue,
  }) : super(previousValue);
}

abstract class CounterEvent {
  final String value;
  const CounterEvent(this.value);
}

class incrementEvent extends CounterEvent {
  incrementEvent(String value) : super(value);
}

class DecrementEvent extends CounterEvent {
  DecrementEvent(String value) : super(value);
}

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  CounterBloc() : super(CounterStateValid(0)) {
    on<incrementEvent>((event, emit) {
      final integer = int.tryParse(event.value);
      if (integer == null) {
        emit(CounterStateInValidNumber(
            invalidValue: event.value, previousValue: state.value));
      } else {
        emit(CounterStateValid(state.value + integer));
      }
    });
    on<DecrementEvent>((event, emit) {
      final integer = int.tryParse(event.value);
      if (integer == null) {
        emit(CounterStateInValidNumber(
            invalidValue: event.value, previousValue: state.value));
      } else {
        emit(CounterStateValid(state.value - integer));
      }
    });
  }
}
