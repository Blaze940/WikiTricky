String? validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your email';
  }

  String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return 'Please enter a valid email';
  }

  return null;
}

String? validateUsername(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your username';
  }

  if (value.length < 3) {
    return 'Username must be at least 3 characters';
  }

  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your password';
  }

  if (value.length < 8) {
    return 'Password must be at least 8 characters';
  }

  return null;
}


String? validatePostContent(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter your post content';
  }

  if (value.length > 300) {
    return 'Post content must be maximum 300 characters';
  }

  return null;
}