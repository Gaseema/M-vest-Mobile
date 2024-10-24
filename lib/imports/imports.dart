/////////////////////////////////////////////////////////////////
/// PACKAGES
/////////////////////////////////////////////////////////////////
library;

export 'package:flutter/material.dart';
export 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
export 'package:intl_phone_number_input/intl_phone_number_input.dart';
export 'package:flutter/cupertino.dart' hide RefreshCallback;
export 'package:flutter_contacts/flutter_contacts.dart';
export 'package:overlay_support/overlay_support.dart';
export 'package:flutter_spinkit/flutter_spinkit.dart';
export 'package:google_sign_in/google_sign_in.dart';
export 'package:intl/intl.dart' hide TextDirection;
export 'package:toggle_switch/toggle_switch.dart';
export 'package:google_fonts/google_fonts.dart';
export 'package:flutter_svg/flutter_svg.dart';
export 'package:local_auth/local_auth.dart';
export 'package:go_router/go_router.dart';
export 'package:provider/provider.dart';
export 'package:flutter/gestures.dart';
export 'package:flutter/services.dart';
export 'package:dio/dio.dart';
export 'dart:async';
export 'dart:io';

/////////////////////////////////////////////////////////////////
/// SCREENS & WIDGETS
/////////////////////////////////////////////////////////////////
// Providers
export 'package:invest/providers/transaction_provider.dart';
export 'package:invest/providers/plan_provider.dart';
export 'package:invest/providers/user_provider.dart';
export 'package:invest/providers/app_providers.dart';

// Authentication
export 'package:invest/screens/authentication/existing_user/forgot_password.dart';
export 'package:invest/screens/authentication/existing_user/pin_code.dart';
export 'package:invest/screens/authentication/new_user/verify_email.dart';
export 'package:invest/screens/authentication/new_user/register.dart';
export 'package:invest/screens/authentication/new_user/create_pin.dart';
export 'package:invest/screens/authentication/reset_success.dart';
export 'package:invest/screens/authentication/email.dart';

//Dashboard
export 'package:invest/screens/dashboard/dashboard.dart';

// Plans
export 'package:invest/screens/dashboard/plans.dart';

// Profile
export 'package:invest/screens/dashboard/profile.dart';

// Onboarding
export 'package:invest/screens/onboarding/welcome.dart';

// Dashboard - Goals
export 'package:invest/screens/dashboard/goals/existing_goals/goal_details/widgets/performance_summary.dart';
export 'package:invest/screens/dashboard/goals/existing_goals/goal_details/goal_details_screen.dart';
export 'package:invest/screens/dashboard/goals/existing_goals/goal_details/widgets/progress.dart';
export 'package:invest/screens/dashboard/goals/new_goal/widgets/goal_type_card.dart';
export 'package:invest/screens/dashboard/goals/new_goal/savings/timeline_plan.dart';
export 'package:invest/screens/dashboard/goals/new_goal/savings/savings_type.dart';
export 'package:invest/screens/dashboard/goals/new_goal/savings/payment_plan.dart';
export 'package:invest/screens/dashboard/goals/existing_goals/edit_goal.dart';
export 'package:invest/screens/dashboard/goals/new_goal/savings/summary.dart';
export 'package:invest/screens/dashboard/goals/new_goal/new_goal.dart';
export 'package:invest/screens/dashboard/goals/contacts_list.dart';
export 'package:invest/screens/dashboard/goals/plan_details.dart';
export 'package:invest/screens/dashboard/goals/success.dart';

// Dashboard - Home
export 'package:invest/screens/dashboard/home/widgets/user_transactions.dart';
export 'package:invest/screens/dashboard/home/widgets/balance_card.dart';
export 'package:invest/screens/dashboard/home/widgets/user_goals.dart';
export 'package:invest/screens/dashboard/home/home.dart';

// Transactions
export 'package:invest/screens/dashboard/transactions/transact.dart';
export 'package:invest/screens/dashboard/transactions.dart';

// Utilities
export 'package:invest/utils/validation.dart';
export 'package:invest/utils/functions.dart';
export 'package:invest/utils/constants.dart';
export 'package:invest/utils/widgets.dart';
export 'package:invest/utils/helpers.dart';
export 'package:invest/utils/theme.dart';
export 'package:invest/utils/api.dart';

// Router
export 'package:invest/router/app_router.dart';

// Global Widgets
export 'package:invest/widgets/currency_converter.dart';
export 'package:invest/widgets/choose_frequency.dart';
export 'package:invest/widgets/choose_timeline.dart';
export 'package:invest/widgets/payment_method.dart';
export 'package:invest/widgets/pin_code_field.dart';
export 'package:invest/widgets/choose_amount.dart';
export 'package:invest/widgets/splash_screen.dart';
export 'package:invest/widgets/buttons.dart';
export 'package:invest/widgets/appbar.dart';
export 'package:invest/widgets/keypad.dart';
export 'package:invest/widgets/dialog.dart';
export 'package:invest/widgets/input.dart';
