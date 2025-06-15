import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'screens/task_list_screen.dart';
import './locale_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final controller = LocaleController();
  await controller.loadLocale();
  runApp(MyApp(controller));
}

class MyApp extends StatelessWidget {
  final LocaleController controller;

  const MyApp(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder:
          (context, _) => MaterialApp(
            title: AppLocalizations.of(context)?.appTitle ?? 'Everyday',
            locale: controller.locale,
            supportedLocales: const [Locale('en'), Locale('pt', 'BR')],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            theme: ThemeData(
              primarySwatch: Colors.deepPurple,
              scaffoldBackgroundColor: const Color(0xFFF6F2FF),
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              checkboxTheme: CheckboxThemeData(
                fillColor: MaterialStatePropertyAll(Colors.deepPurple),
                checkColor: MaterialStatePropertyAll(Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                backgroundColor: Colors.deepPurple,
                foregroundColor: Colors.white,
              ),
              textTheme: const TextTheme(
                headlineLarge: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.deepPurple,
                ),
                bodySmall: TextStyle(fontSize: 16),
              ),
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.deepPurple,
              ).copyWith(secondary: Colors.amber),
            ),
            home: TaskListScreen(localeController: controller),
          ),
    );
  }
}
