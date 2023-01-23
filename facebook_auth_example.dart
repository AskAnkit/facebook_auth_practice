Future<void> _facebookLogin() async {
    final res = await FacebookAuth.instance.login(
      permissions: ['email', 'public_profile', 'user_birthday', 'user_gender', 'user_link'],
      //loginBehavior: LoginBehavior.dialogOnly,
    );
    //final LoginResult res = await FacebookAuth.instance.login();
    switch (res.status) {
      case LoginStatus.success:
        final  accessToken = res.accessToken;
        print('Access token: ${accessToken?.token}');
        Map<String, dynamic> userData = await FacebookAuth.instance.getUserData(fields: "email,"
            "birthday,gender,link,name,picture.width(200)",);
        prettyPrint(userData);
        final imageUrl = userData["picture"];
        final name = userData["name"];
        final userId = userData["id"];
        final email = await userData["email"];
        if (email != null) print('And your email is $email');
        print('Your profile image: $imageUrl');
        print('Your profile Name: $name');
        print('Your profile userId: $userId');
        String? fullName = name ??"";
        var names = fullName!.split(' ');
        var firstName = names[0];
        var lastName = names[1];
        var image= imageUrl;
        var userEmail = email;
        var id = userId;
        Get.toNamed(Routes.signUp, arguments: model);

        //_controller.initSocialLogin(firstName,lastName,image,userEmail,id);
        break;

      case LoginStatus.cancelled:
        break;
      case LoginStatus.failed:
        print('Error while log in: ${res.message}');
        break;
      case LoginStatus.operationInProgress:
      // TODO: Handle this case.
        break;
    }
  }
