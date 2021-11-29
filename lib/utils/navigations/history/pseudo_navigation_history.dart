import 'package:stack/stack.dart';

class NavigationHistory {

  static Stack<String> previousNavigationStack = Stack.sized(10);
  static Stack<String> nextNavigationStack = Stack.sized(10);


  static void initiate(){
    while (previousNavigationStack.isNotEmpty) {
      previousNavigationStack.pop();
    }
    while (nextNavigationStack.isNotEmpty) {
      nextNavigationStack.pop();
    }

  }

  static void nextMenuNavigation(String currentMenuName) {
    previousNavigationStack.push(currentMenuName);
  }

  static String previousMenuNavigation(String currentMenuName) {
    String previousMenu = ""; //first navigation

    if (previousNavigationStack.isNotEmpty) {   // user previously had navigated
      previousMenu = previousNavigationStack.pop(); //get the navigation
      nextNavigationStack.push(currentMenuName); // save current menu
      nextNavigationStack.push(previousMenu); //save the navigation
    }
    // return string == "" means there are no previous menu
    return previousMenu;
  }

}