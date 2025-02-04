enum FreelanceExperience { newUser, someExperience, expert }
// enum FreelanceGoal { income, moneyOnSide, moneyOnSide, goalInMind}
enum FreelanceGoal {
  income,
  moneyOnSide,
  getExperience,
  goalInMind,
}

class UserProfile {
  FreelanceExperience? experience;
  FreelanceGoal? freelanceGoal;

  UserProfile({this.freelanceGoal});

  // bool? isNewToFreelancing;
  //
  // UserProfile({this.isNewToFreelancing});
}