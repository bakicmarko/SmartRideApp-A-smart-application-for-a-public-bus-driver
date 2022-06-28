import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_ride_app/models/login_info.dart';

import 'package:smart_ride_app/providers/listeners/provider_listener.dart';
import 'package:smart_ride_app/providers/login_provider.dart';
import 'package:smart_ride_app/screens/home_screen.dart';
import 'package:smart_ride_app/screens/transition_animation_screen.dart';

import 'package:smart_ride_app/theme/theme.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LogInProvider(context.read()),
      child: const _LogInScreenView(),
    );
  }
}

class _LogInScreenView extends StatelessWidget {
  const _LogInScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderListener<LogInProvider>(
      listener: ((context, provider) => {
            provider.state.maybeMap(
                orElse: () => Container(),
                failure: (exception) => showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                        title: Text(
                          'Failed to login, $checkIntConnectionErrorM',
                          maxLines: 15,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                success: (_) {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => const TransitionScreen(nextScreen: HomeScreen())));
                })
          }),
      child: const ScreenContent(),
    );
  }
}

class ScreenContent extends StatefulWidget {
  const ScreenContent({Key? key}) : super(key: key);

  @override
  State<ScreenContent> createState() => _ScreenContentState();
}

class _ScreenContentState extends State<ScreenContent> {
  final emailController = TextEditingController(text: '1');
  final passwordController = TextEditingController(text: '4dl76LRwiFJdyq4');

  bool passwordVisibility = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LogInProvider>();
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
                width: double.infinity,
                color: redColor,
                height: 300,
                child: Image.asset(
                  'assets/images/login_art.png',
                  fit: BoxFit.fill,
                )),
            Padding(
              padding: mediumAllOutsidePadding,
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Login Here",
                      textAlign: TextAlign.start,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  defaultHeightDivideBox,
                  // two text inputs with icons
                  TextFormField(
                    controller: emailController,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: titleDefaultFontSize),
                    decoration: InputDecoration(
                      hintText: "Enter email",
                      hintStyle: Theme.of(context).textTheme.bodyMedium,
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(bottom: 6),
                        child: Icon(Icons.alternate_email),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: passwordController,
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: titleDefaultFontSize),
                    decoration: InputDecoration(
                      hintText: "Enter password",
                      hintStyle: Theme.of(context).textTheme.bodyMedium,
                      prefixIcon: const Padding(
                        padding: EdgeInsets.only(bottom: 6),
                        child: Icon(Icons.lock),
                      ),
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            passwordVisibility = !passwordVisibility;
                          });
                        },
                        icon: passwordVisibility
                            ? const Icon(Icons.visibility_outlined)
                            : const Icon(Icons.visibility_off_outlined),
                      ),
                    ),
                    obscureText: passwordVisibility ? false : true,
                  ),
                  mediumHeightDivideBox,

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("If you're new", style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 20)),
                        const SizedBox(width: 10),
                        ElevatedButton(onPressed: () => {}, child: const Text("Create new")),
                      ],
                    ),
                  ),

                  /// defaultHeightDivideBox,
                  /// defaultHeightDivideBox,
                  /// defaultHeightDivideBox,
                  /// Align(
                  ///   alignment: Alignment.bottomCenter,
                  ///   child: ElevatedButton(
                  ///     onPressed: () => {
                  ///       if (passwordController.text.isNotEmpty && emailController.text.isNotEmpty)
                  ///         provider.signInUser(LogInInfo(emailController.text, passwordController.text))
                  ///     },
                  ///     style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                  ///           minimumSize: MaterialStateProperty.all(const Size(double.infinity, defaultButtonHeight)),
                  ///         ),
                  ///     child: const Text("Submit"),
                  ///   ),
                  /// ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: defaultAllOutsidePadding,
        child: ElevatedButton(
          onPressed: () => {
            if (passwordController.text.isNotEmpty && emailController.text.isNotEmpty)
              provider.signInUser(LogInInfo(emailController.text, passwordController.text))
          },
          style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                minimumSize: MaterialStateProperty.all(const Size(double.infinity, defaultButtonHeight)),
              ),
          child: const Text("Submit"),
        ),
      ),
    );
  }
}
