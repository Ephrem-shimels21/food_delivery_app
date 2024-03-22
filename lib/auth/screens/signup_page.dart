import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:food_delivery_app/auth/bloc/signup_page_bloc.dart';
import 'package:food_delivery_app/auth/screens/login_page.dart';
import 'package:food_delivery_app/home/screen/home_page.dart';
import 'package:food_delivery_app/utils/universal_variables.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => RegisterPageBloc(), child: RegisterPageContent());
  }
}

class RegisterPageContent extends StatefulWidget {
  @override
  _RegisterPageContentState createState() => _RegisterPageContentState();
}

class _RegisterPageContentState extends State<RegisterPageContent> {
  late RegisterPageBloc registerPageBloc;

  TextEditingController textNameController = TextEditingController();
  TextEditingController textPasswordController = TextEditingController();
  TextEditingController textPhoneController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: // do we need to keep this here or in didChangeDependencies
    registerPageBloc = Provider.of<RegisterPageBloc>(context);
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
        child: Form(
          key: _formKey,
          child: buildForm(),
        ),
      ),
    ));
  }

  buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
          child: Text(
            "Sign Up",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        const Center(
          child: Text("Create your account",
              style: TextStyle(
                  fontSize: 20, color: UniversalVariables.darkBlueColor)),
        ),
        const SizedBox(height: 15.0),
        Image.asset(
          'assets/logo.jpg', // replace with the path to your image
          width: 200.0,
          height: 150.0,
        ),
        const SizedBox(height: 20.0),
        TextFormField(
          validator: (email) {
            return registerPageBloc.validateEmail(email ?? '');
          },
          controller: textNameController,
          decoration: InputDecoration(
              hintText: "Email",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              fillColor: Colors.blue.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.email,
                  color: UniversalVariables.darkBlueColor)),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          maxLength: 10,
          inputFormatters: <TextInputFormatter>[
            FilteringTextInputFormatter.digitsOnly,
          ],
          keyboardType: TextInputType.number,
          validator: (phone) {
            return registerPageBloc.validatePhone(phone ?? '');
          },
          controller: textPhoneController,
          decoration: InputDecoration(
              hintText: "PhoneNo",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18),
              ),
              fillColor: Colors.blue.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.phone,
                  color: UniversalVariables.darkBlueColor)),
        ),
        const SizedBox(
          height: 10,
        ),
        TextFormField(
          validator: (password) {
            return registerPageBloc.validatePassword(password ?? '');
          },
          controller: textPasswordController,
          decoration: InputDecoration(
              hintText: "Password",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              fillColor: Colors.blue.withOpacity(0.1),
              filled: true,
              prefixIcon: const Icon(Icons.password,
                  color: UniversalVariables.darkBlueColor)),
        ),
        const SizedBox(height: 20.0),
        ElevatedButton(
          // style: ButtonStyle(
          //   backgroundColor:
          //       MaterialStateProperty.all(UniversalVariables.darkBlueColor),
          //   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          //       RoundedRectangleBorder(
          //     borderRadius: BorderRadius.circular(30.0),
          //   )),
          // ),
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: UniversalVariables.darkBlueColor,
          ),
          onPressed: () {
            registerPageBloc
                .validateFormAndRegister(_formKey, textNameController.text,
                    textPasswordController.text, textPhoneController.text)
                .then((_) => gotoHomePage());
          },
          child: const Text("Register",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              )),
        ),
        registerPageBloc.isRegisterPressed
            ? Center(child: CircularProgressIndicator())
            : Container(),
        const SizedBox(height: 15.0),
        TextButton(
          onPressed: () => gotoLoginPage(),
          child: const Text("Already have an account? Login"),
        ),
        const SizedBox(height: 15.0),
      ],
    );
  }

  gotoLoginPage() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }

  gotoHomePage() {
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const BottomNavigation()));
  }
}
