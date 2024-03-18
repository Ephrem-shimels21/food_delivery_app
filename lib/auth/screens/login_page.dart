import 'package:flutter/material.dart';
import 'package:food_delivery_app/auth/screens/signup_page.dart';
import 'package:food_delivery_app/home/screen/home_page.dart';
import 'package:food_delivery_app/utils/universal_variables.dart';
import 'package:provider/provider.dart';
import 'package:food_delivery_app/auth/bloc/login_page_bloc.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => LoginPageBloc(), child: LoginPageContent());
  }
}

class LoginPageContent extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPageContent> {
  TextEditingController textEmailController = TextEditingController();
  TextEditingController textPhoneController = TextEditingController();
  TextEditingController textPasswordController = TextEditingController();

  final _formkey = GlobalKey<FormState>();
  late LoginPageBloc loginPageBloc;

  @override
  Widget build(BuildContext context) {
    print("LoginPage: build");
    loginPageBloc = Provider.of<LoginPageBloc>(context);
    return Scaffold(
        body: Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
      child: Form(
        key: _formkey,
        child: buildForm(),
      ),
    ));
  }

  buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        const Center(
          child: Text(
            "Welcome Back",
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
        const Center(
          child: Text("Enter your credentials to login"),
        ),
        const SizedBox(height: 10.0),
        Hero(
          tag: 'hero',
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 70.0,
            child: Image.asset('assets/logo.jpg'),
          ),
        ),
        const SizedBox(height: 15.0),
        TextFormField(
            validator: (email) {
              return loginPageBloc.validateEmail(email ?? "");
            },
            controller: textEmailController,
            decoration: InputDecoration(
              hintText: 'Email',
              prefixIcon: Icon(Icons.email),
              contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
              fillColor: Colors.blue.withOpacity(0.1),
              filled: true,
            )),
        const SizedBox(height: 10.0),
        TextFormField(
            validator: (email) {
              return loginPageBloc.validateEmail(email ?? "");
            },
            controller: textPhoneController,
            decoration: InputDecoration(
              hintText: 'Phone Number',
              prefixIcon: Icon(Icons.phone),
              contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
              fillColor: Colors.blue.withOpacity(0.1),
              filled: true,
            )),
        const SizedBox(height: 8.0),
        TextFormField(
          validator: (password) {
            return loginPageBloc.validatePassword(password ?? "");
          },
          controller: textPasswordController,
          decoration: InputDecoration(
            hintText: 'password',
            prefixIcon: const Icon(Icons.password),
            contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
            fillColor: Colors.blue.withOpacity(0.1),
            filled: true,
          ),
        ),
        const SizedBox(height: 25.0),
        ElevatedButton(
          onPressed: () => loginPageBloc
              .validateFormAndLogin(_formkey, textEmailController.text,
                  textPasswordController.text)
              .then((_) => gotoHomePage()),
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: UniversalVariables.darkBlueColor,
          ),
          child: const Text(
            "Login",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        // SizedBox(
        //   width: double.infinity,
        //   child: TextButton(
        //     style: ButtonStyle(
        //       backgroundColor:
        //           MaterialStateProperty.all(UniversalVariables.darkBlueColor),
        //       shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        //           RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(30.0),
        //       )),
        //     ),
        //     onPressed: () => loginPageBloc
        //         .validateFormAndLogin(_formkey, textEmailController.text,
        //             textPasswordController.text)
        //         .then((_) => gotoHomePage()),
        //     child: const Text("Login",
        //         style: TextStyle(color: Colors.white, fontSize: 24)),
        //   ),
        // ),
        loginPageBloc.isLoginPressed
            ? const Center(child: CircularProgressIndicator())
            : Container(),
        TextButton.icon(
          onPressed: () => gotoRegisterPage(),
          icon: const Icon(Icons.person_add,
              color: UniversalVariables.darkBlueColor),
          label: const Text("New User? Click Here to Register",
              style: TextStyle(
                  color: Colors.black45, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  gotoHomePage() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }

  gotoRegisterPage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => RegisterPage()));
  }
}
