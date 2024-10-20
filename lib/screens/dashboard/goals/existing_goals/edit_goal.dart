import 'package:invest/imports/imports.dart';

class EditPlan extends StatefulWidget {
  final String? initialGoalName;
  final String? initialGoalDescription;
  final int? initialTargetAmount;
  final String? initialCategory;
  final DateTime? initialMaturityDate;
  final bool initialLockPlan;
  final String? initialFrequency;
  final num? planId;
  final List? initialmembersList;
  // EditPlan({Key? key, required String initialGoalName}) : super(key: key);
  const EditPlan({
    super.key,
    this.initialGoalName,
    this.initialGoalDescription,
    this.initialTargetAmount,
    this.initialCategory,
    this.initialMaturityDate,
    this.initialLockPlan = false,
    this.initialFrequency,
    this.planId,
    this.initialmembersList,
  });

  @override
  State<EditPlan> createState() => _EditPlanState();
}

class _EditPlanState extends State<EditPlan> {
  TextEditingController goalName = TextEditingController();
  TextEditingController goalDescription = TextEditingController();
  TextEditingController targetAmount = TextEditingController();
  TextEditingController maturityDate = TextEditingController();
  bool locked = false;
  String planCategory = '';

  List<Contact> selectedContacts = [];
  List? membersList;

  @override
  void initState() {
    super.initState();
    // Set initial values from widget parameters
    goalName.text = widget.initialGoalName ?? '';
    goalDescription.text = widget.initialGoalDescription ?? '';
    targetAmount.text = widget.initialTargetAmount?.toString() ?? '';
    selectedCategory = widget.initialCategory;
    selectedDate = widget.initialMaturityDate;
    lockPlan = widget.initialLockPlan;
    selectedFrequency = widget.initialFrequency;
    membersList = widget.initialmembersList;
  }

  void navigateToContactsPage(BuildContext context) async {
    final result = await Navigator.push<List<Contact>>(
      context,
      MaterialPageRoute(
        builder: (context) => ContactList(selectedContacts: selectedContacts),
      ),
    );

    if (result != null) {
      setState(() {
        selectedContacts = result;
      });
    }
  }

  void removeContact(Contact contact) {
    setState(() {
      selectedContacts.remove(contact);
    });
  }

  String formNum(String s) {
    return NumberFormat.decimalPattern().format(
      int.parse(s),
    );
  }

  String? selectedDay;
  bool lockPlan = false;
  String? selectedFrequency;

  DateTime? selectedDate;

  String goalNameError = '';
  String goalDescriptionError = '';
  String targetAmountError = '';
  String categoryError = '';
  String dateError = '';
  String frequencyError = '';

  String? selectedSavings;
  String? selectedCategory;

  bool validateFields() {
    bool isValid = true;

    if (goalName.text.isEmpty) {
      setState(() {
        goalNameError = 'Please enter a goal name';
      });
      isValid = false;
    } else {
      setState(() {
        goalNameError = '';
      });
    }

    if (goalDescription.text.isEmpty) {
      setState(() {
        goalDescriptionError = 'Please enter a goal description';
      });
      isValid = false;
    } else {
      setState(() {
        goalDescriptionError = '';
      });
    }

    if (targetAmount.text.isEmpty) {
      setState(() {
        targetAmountError = 'Please enter a target amount';
      });
      isValid = false;
    } else {
      setState(() {
        targetAmountError = '';
      });
    }

    if (selectedCategory == null) {
      setState(() {
        categoryError = 'Please select a category';
      });
      isValid = false;
    } else {
      setState(() {
        categoryError = '';
      });
    }

    if (selectedDate == null) {
      setState(() {
        dateError = 'Please select a date';
      });
      isValid = false;
    } else {
      setState(() {
        dateError = '';
      });
    }
    if (selectedFrequency == null) {
      setState(() {
        frequencyError = 'Please select preferred frequency';
      });
      isValid = false;
    } else {
      setState(() {
        frequencyError = '';
      });
    }

    return isValid;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime currentDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? currentDate,
      firstDate: DateTime(currentDate.year),
      lastDate: DateTime(2100),
      selectableDayPredicate: (DateTime date) {
        // Disable selecting dates before the current date
        return date.isAfter(currentDate.subtract(const Duration(days: 1)));
      },
    );
    if (picked != null) {
      setState(() {
        selectedDate = DateTime(picked.year, picked.month, picked.day);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget listView = ListView.builder(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      itemCount: selectedContacts.length,
      itemBuilder: (context, index) {
        final contact = selectedContacts[index];
        Uint8List? image = contact.photo;
        String displayName = contact.displayName;
        String initials = displayName.isNotEmpty
            ? displayName
                .trim()
                .split(' ')
                .map((name) {
                  if (name.isNotEmpty) {
                    return name[0];
                  }
                  return '';
                })
                .join('')
                .toUpperCase()
            : '';

        bool hasAvatar = image != null;

        return Container(
          margin: const EdgeInsets.only(right: 10, top: 5),
          child: Column(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    backgroundColor:
                        const Color.fromARGB(255, 36, 77, 97).withOpacity(0.1),
                    backgroundImage: hasAvatar
                        ? MemoryImage(image)
                        : const AssetImage('assets/avatar_placeholder.png')
                            as ImageProvider,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () => removeContact(contact),
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300],
                        ),
                        padding: const EdgeInsets.all(4),
                        child: const Icon(
                          Icons.close,
                          color: Colors.black,
                          size: 8,
                        ),
                      ),
                    ),
                  ),
                  if (!hasAvatar)
                    Positioned.fill(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          initials,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                displayName.isNotEmpty
                    ? '${displayName.split(' ')[0]} ${(displayName.split(' ').length > 1) ? '${displayName.split(' ')[1].substring(0, 2)}...' : ''}'
                    : '',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(
                20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset(
                      'assets/icons/back.png',
                      width: 30,
                    ),
                  ),
                  Text(
                    'Confirm Changes',
                    style: displayNormalBiggerSlightlyBoldBlack,
                  ),
                  GestureDetector(
                    onTap: () {
                      _showBottomSheet();
                    },
                    child: Image.asset(
                      'assets/icons/delete.png',
                      width: 30,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name',
                        style: displayNormalBolderDarkBlue,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 48,
                        child: TextFormField(
                          controller: goalName,
                          onChanged: (value) {
                            setState(() {
                              goalNameError = '';
                            });
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Name of Savings Plan',
                            labelStyle: displayNormalGrey1,
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: goalNameError.isNotEmpty,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            goalNameError,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Description',
                        style: displayNormalBolderDarkBlue,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 48,
                        child: TextFormField(
                          controller: goalDescription,
                          onChanged: (value) {
                            setState(() {
                              goalDescriptionError = '';
                            });
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            labelText: 'Description of your Savings Plan',
                            labelStyle: displayNormalGrey1,
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: goalDescriptionError.isNotEmpty,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            goalDescriptionError,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Target Amount',
                        style: displayNormalBolderDarkBlue,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 48,
                        child: TextFormField(
                          controller: targetAmount,
                          onChanged: (value) {
                            value = formNum(
                              value.replaceAll(',', ''),
                            );
                            targetAmount.value = TextEditingValue(
                              text: value,
                              selection: TextSelection.collapsed(
                                offset: value.length,
                              ),
                            );
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            // prefixIcon: Icon(Icons.mone),
                            filled: true,
                            fillColor: Colors.white,

                            labelText: 'KES',
                            labelStyle: displayNormalGrey1,
                            border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                        ),
                      ),
                      Visibility(
                        visible: targetAmountError.isNotEmpty,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            targetAmountError,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Categories',
                        style: displayNormalBolderDarkBlue,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        height: 60,
                        child: DropdownButtonFormField<String>(
                          items: const [
                            DropdownMenuItem<String>(
                              value: 'General Savings',
                              child: Text('General Savings'),
                            ),
                            DropdownMenuItem<String>(
                              value: 'Entertainment',
                              child: Text('Entertainment'),
                            ),
                            DropdownMenuItem<String>(
                              value: 'Health and Fitness',
                              child: Text('Health and Fitness'),
                            ),
                            DropdownMenuItem<String>(
                              value: 'Education',
                              child: Text('Education'),
                            ),
                            DropdownMenuItem<String>(
                              value: 'Travel/Vacation',
                              child: Text('Travel/Vacation'),
                            ),
                            DropdownMenuItem<String>(
                              value: 'Retirement',
                              child: Text('Retirement'),
                            ),
                            DropdownMenuItem<String>(
                              value: 'Vehicle Fund',
                              child: Text('Vehicle Fund'),
                            ),
                            DropdownMenuItem<String>(
                              value: 'Personal Development',
                              child: Text('Personal Development'),
                            ),
                            DropdownMenuItem<String>(
                              value: 'Family Fund',
                              child: Text('Family fund'),
                            ),
                            DropdownMenuItem<String>(
                              value: 'Business Fund',
                              child: Text('Business Fund'),
                            ),
                            DropdownMenuItem<String>(
                              value: 'Home Renovation',
                              child: Text('Home Renovation'),
                            ),
                          ],
                          decoration: InputDecoration(
                            labelText: 'Select Category',
                            labelStyle: displayNormalGrey1,
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.category),
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              selectedCategory = newValue;
                              categoryError = '';
                            });
                          },
                          value: selectedCategory,
                          isExpanded: true,
                        ),
                      ),
                      Visibility(
                        visible: categoryError.isNotEmpty,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            categoryError,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'End Date',
                        style: displayNormalBolderDarkBlue,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        onTap: () {
                          _selectDate(context);
                        },
                        decoration: InputDecoration(
                          labelText: 'Select a date',
                          labelStyle: displayNormalGrey1,
                          border: const OutlineInputBorder(),
                          prefixIcon: const Icon(Icons.calendar_today),
                        ),
                        controller: TextEditingController(
                          text: selectedDate != null
                              ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                              : '',
                        ),
                        readOnly: true,
                        onChanged: (value) {
                          setState(() {
                            dateError = '';
                          });
                        },
                      ),
                      Visibility(
                        visible: dateError.isNotEmpty,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            dateError,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Choose your saving frequency',
                        style: displayNormalBolderDarkBlue,
                      ),
                      Text(
                        'Get notifications after:',
                        style: displayNormalBlack,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SizedBox(
                        height: 60,
                        child: DropdownButtonFormField<String>(
                          items: const [
                            DropdownMenuItem<String>(
                              value: 'Daily',
                              child: Text('Daily'),
                            ),
                            DropdownMenuItem<String>(
                              value: 'Weekly',
                              child: Text('Weekly'),
                            ),
                            DropdownMenuItem<String>(
                              value: 'Monthly',
                              child: Text('Monthly'),
                            ),
                            DropdownMenuItem<String>(
                              value: 'Annually',
                              child: Text('Annually'),
                            ),
                          ],
                          decoration: InputDecoration(
                            labelText: 'Select Frequency',
                            labelStyle: displayNormalGrey1,
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.timeline),
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              selectedFrequency = newValue;
                              frequencyError = '';
                            });
                          },
                          value: selectedFrequency,
                          isExpanded: true,
                        ),
                      ),
                      Visibility(
                        visible: frequencyError.isNotEmpty,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            frequencyError,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Text(
                        'Add members to your plan',
                        style: displayNormalBolderDarkBlue,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment
                                  .center, // Align the "Add" button vertically
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    navigateToContactsPage(context);
                                  },
                                  child: CircleAvatar(
                                    backgroundColor:
                                        const Color.fromARGB(255, 36, 77, 97)
                                            .withOpacity(0.1),
                                    child: const Icon(
                                      Icons.add,
                                      color: Color.fromARGB(255, 36, 77, 97),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text('Add'),
                              ],
                            ),
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: SizedBox(
                                height: 70,
                                child: listView,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      CheckboxListTile(
                        contentPadding: EdgeInsets.zero,
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(
                          'Lock Savings Plan till it is completed',
                          style: displayNormalBlack,
                        ),
                        value: lockPlan,
                        onChanged: (bool? newValue) {
                          setState(() {
                            lockPlan = !lockPlan;
                          });
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomButton(
                        url: '/plan/edit',
                        method: 'POST',
                        text: 'Edit Plan',
                        body: {
                          "goalId": widget.planId,
                          "goal_name": goalName.text,
                          "type": "individual",
                          "description": goalDescription.text,
                          "target_amount": int.tryParse(targetAmount.text
                                  .replaceAll(RegExp(r'[^0-9]'), '')) ??
                              0,

                          //targetAmount.text,
                          "category": selectedCategory,
                          // "maturity_date": selectedDate.toString(),
                          "maturity_date": selectedDate != null
                              ? DateFormat('yyyy-MM-dd').format(selectedDate!)
                              : '',
                          "frequency": selectedFrequency,
                          "locked": lockPlan,
                          "members": getMembersList(),
                          //goal_id, goal_name, description, target_amount, category
                        },
                        onCompleted: (res) {
                          setState(() {
                            validateFields();
                          });
                          if (res['isSuccessful'] == true && validateFields()) {
                            //logger.i('Target Amount: ${targetAmount.text}');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Success(
                                  goalName: goalName.text,
                                  description: goalDescription.text,
                                  //targetAmount: int.parse(targetAmount.text),
                                  targetAmount: int.parse(
                                      targetAmount.text.replaceAll(',', '')),
                                  category: selectedCategory,
                                  maturityDate: selectedDate.toString(),
                                  locked: lockPlan,
                                  screen:
                                      'Congratulations! Your plan has been successfully editted.',
                                  membersList: getMembersList(),
                                ),
                              ),
                            );
                          } else {
                            // showToast(
                            //   context,
                            //   'Error!',
                            //   res['error'],
                            //   Colors.red,
                            // );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Set this property to true
      builder: (BuildContext context) {
        return FractionallySizedBox(
          heightFactor: 0.25, // Set the height factor to occupy half the screen
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Add content for the delete confirmation modal
                Text(
                  'Are you sure you want to delete',
                  style: displayNormalBlack,
                ),

                Text(
                  '${widget.initialGoalName},',
                  style: displayNormalBolderBlack,
                ),

                Text(
                  'of Amount, ${CurrencyConverter().convert(widget.initialTargetAmount.toString())} ',
                  style: displayNormalBlack,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 48,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: primaryDarkColor.withOpacity(0.3),
                          ),
                          child: Text('Cancel', style: displayNormalWhiteBold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      flex: 1,
                      child: SizedBox(
                        height: 48,
                        child: CustomButton(
                          url: '/plan/delete',
                          method: 'POST',
                          text: 'Delete',
                          body: {
                            "goalId": widget.planId,
                          },
                          onCompleted: (res) {
                            setState(() {
                              validateFields();
                            });
                            if (res['isSuccessful']) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Success(
                                    goalName: goalName.text,
                                    description: goalDescription.text,
                                    //targetAmount: int.parse(targetAmount.text),
                                    targetAmount: int.parse(
                                        targetAmount.text.replaceAll(',', '')),
                                    category: selectedCategory,
                                    maturityDate: selectedDate.toString(),
                                    locked: lockPlan,
                                    screen:
                                        'Your plan has been successfully deleted.',
                                    membersList: membersList ?? [],
                                  ),
                                ),
                              );
                            } else {
                              // showToast(
                              //   context,
                              //   'Error!',
                              //   res['error'],
                              //   Colors.red,
                              // );
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

// Function to get the members list
  List<Map<String, dynamic>> getMembersList() {
    List<Map<String, dynamic>> membersList = [];
    for (Contact contact in selectedContacts) {
      Map<String, dynamic> memberMap = {
        'name': contact.displayName,
        'phone_number': contact.phones.isNotEmpty
            //phoneNumbers.isNotEmpty
            ? contact.phones.first
            //contact.phones.first.value
            : '',
      };
      membersList.add(memberMap);
    }
    logger.i('these are the members i have selected');
    logger.i(membersList);
    return membersList;
  }
}
