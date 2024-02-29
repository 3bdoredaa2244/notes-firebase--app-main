import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_training/core/utils/api_service.dart';
import 'package:firebase_training/core/utils/message_service.dart';
import 'package:firebase_training/features/auth/presentation/manager/login%20google%20cubit/login_google_cubit.dart';
import 'package:firebase_training/features/auth/presentation/manager/register%20cubit/register_cubit.dart';
import 'package:firebase_training/features/auth/presentation/views/login_view.dart';
import 'package:firebase_training/features/filter/presentation/manager/pick_image_cubit/pick_image_cubit.dart';
import 'package:firebase_training/features/filter/presentation/manager/test%20cubit/test_cubit.dart';
import 'package:firebase_training/features/filter/presentation/manager/upload_image_cubit/upload_image_cubit.dart';
import 'package:firebase_training/features/home/data/repos/home_repo_imp.dart';
import 'package:firebase_training/features/home/presentation/manager/add%20category%20cubit/add_category_cubit.dart';
import 'package:firebase_training/features/home/presentation/manager/delete%20category%20cubit/delete_category_cubit.dart';
import 'package:firebase_training/features/home/presentation/manager/message%20cubit/message_cubit.dart';
import 'package:firebase_training/features/home/presentation/manager/sign%20out%20cubit/sign_out_cubit.dart';
import 'package:firebase_training/features/home/presentation/manager/update%20category%20cubit/update_category_cubit.dart';
import 'package:firebase_training/features/home/presentation/views/add_folder_view.dart';
import 'package:firebase_training/features/home/presentation/views/home_view.dart';
import 'package:firebase_training/features/home/presentation/views/update_category_view.dart';
import 'package:firebase_training/features/note/presentation/views/note_view.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/constants.dart';
import 'features/auth/presentation/manager/login cubit/login_cubit.dart';
import 'features/auth/presentation/manager/reset password cubit/reset_password_cubit.dart';
import 'features/auth/presentation/views/register_view.dart';
import 'features/home/presentation/manager/get category cubit/get_category_cubit.dart';
import 'features/note/presentation/manager/add note cubit/add_note_cubit.dart';
import 'features/note/presentation/manager/delete note/delete_note_cubit.dart';
import 'features/note/presentation/manager/get note cubit/get_note_cubit.dart';
import 'features/note/presentation/manager/update note cubit/update_note_cubit.dart';
import 'features/note/presentation/views/add_note_view.dart';
import 'features/note/presentation/views/update_note_view.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  if (message.notification != null) {
    debugPrint(
        '////////////////////////////////////////${message.notification!.title}//////////////////////////////////////////');
    debugPrint(
        '////////////////////////////////////////${message.data}//////////////////////////////////////////');
  }
  debugPrint("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
              apiKey: "AIzaSyBd8pXo0SZ0SO-ox_wNz471E7WAujq0p9w",
              appId: "1:335388615801:android:837c8215672db42ad620a8",
              messagingSenderId: "335388615801",
              projectId: "fir-training-828f4",
              storageBucket: "fir-training-828f4.appspot.com"))
      : await Firebase.initializeApp();
  await MessagingService().initNotifications();
  deviceToken = await FirebaseMessaging.instance.getToken() ?? "";
  runApp(const FirebaseTraining());
}

class FirebaseTraining extends StatefulWidget {
  const FirebaseTraining({super.key});
  @override
  State<FirebaseTraining> createState() => _FirebaseTrainingState();
}

class _FirebaseTrainingState extends State<FirebaseTraining> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        debugPrint('User is currently signed out!');
      } else {
        debugPrint('User is signed in!');
      }
    });
    debugPrint(
        "/////////////////////device token////////////////////////$deviceToken");
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return ResetPasswordCubit();
        }),
        BlocProvider(create: (context) => AddCategoryCubit()),
        BlocProvider(create: (context) => GetCategoryCubit()),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => DeleteCategoryCubit()),
        BlocProvider(create: (context) => RegisterCubit()),
        BlocProvider(create: (context) => SignOutCubit()),
        BlocProvider(create: (context) => LoginGoogleCubit()),
        BlocProvider(create: (context) => UpdateCategoryCubit()),
        BlocProvider(create: (context) => AddNoteCubit()),
        BlocProvider(create: (context) => GetNoteCubit()),
        BlocProvider(create: (context) => DeleteNoteCubit()),
        BlocProvider(create: (context) => UpdateNoteCubit()),
        BlocProvider(create: (context) => TestCubit()),
        BlocProvider(create: (context) => PickImageCubit()),
        BlocProvider(create: (context) => UploudImageCubit()),
        BlocProvider(
            create: (context) =>
                MessageCubit(HomeRepoImp(apiService: ApiService()))),
      ],
      child: MaterialApp(
        theme: ThemeData(
            primaryColor: Colors.orange,
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.orange,
            ),
            appBarTheme: AppBarTheme(
                backgroundColor: Colors.grey[50],
                titleTextStyle: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange),
                iconTheme: const IconThemeData(color: Colors.orange))),
        home: FirebaseAuth.instance.currentUser != null &&
                FirebaseAuth.instance.currentUser!.emailVerified
            ? const HomeView()
            : const LoginView(),
        debugShowCheckedModeBanner: false,
        routes: {
          "signup": (context) => const RegisterView(),
          "login": (context) => const LoginView(),
          "homepage": (context) => const HomeView(),
          "addfolder": (context) => const AddFolderView(),
          "updateCategory": (context) => const UpdateCategoryView(),
          "note": (context) => const NoteView(),
          "addNote": (context) => const AddNoteView(),
          "updateNote": (context) => const UpdateNoteView()
        },
      ),
    );
  }
}
