import 'package:invest/imports/imports.dart';

class GoalDetails extends StatefulWidget {
  final int? id;
  final String? type;
  final String? category;
  final String? planDescription;
  final String? plan;
  final double? progress;
  final num? planBalance;
  final num? target;
  final String? createdAt;
  final String? maturityDate;
  final String? frequency;
  final int? walletId;
  final bool? locked;
  final List? membersList;

  const GoalDetails({
    super.key,
    this.category,
    this.id,
    this.locked,
    this.createdAt,
    this.planDescription,
    this.maturityDate,
    this.plan,
    this.progress,
    this.planBalance,
    this.target,
    this.type,
    this.walletId,
    this.frequency,
    this.membersList,
  });

  @override
  GoalDetailsState createState() => GoalDetailsState();
}

class GoalDetailsState extends State<GoalDetails> {
  List transactionList = [];
  bool loadingTransactions = false;

  _fetchTransactionsById(BuildContext context) async {
    // setState(() {
    //   loadingTransactions = true;
    // });
    // // Retrieve user information from provider
    // final userProvider = Provider.of<UserProvider>(context, listen: false);

    // final token = userProvider.user?.token;

    // final postData = {'wallet_id': widget.walletId};
    // final apiClient = ApiClient();
    // final headers = {
    //   'Authorization': 'Bearer $token',
    //   'Content-Type': 'application/json',
    // };
    // await apiClient
    //     .post('/transaction/fetch/plan_transactions', postData,
    //         headers: headers)
    //     .then((response) {
    //   setState(() {
    //     transactionList = response['transactions'];
    //     // logger.i('The response.....................................');
    //     // logger.i(response);
    //   });
    // }).catchError((error) {});
    // setState(() {
    //   loadingTransactions = false;
    // });
  }

  @override
  void initState() {
    super.initState();
    _fetchTransactionsById(context);
  }

  @override
  Widget build(BuildContext context) {
    // Transaction Provider

    Widget balCard = Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Goal: ${widget.plan}',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(fontSize: 12),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                child: widget.locked!
                    ? Image.asset(
                        'assets/icons/lock.png',
                        width: 20,
                      )
                    : Image.asset(
                        'assets/icons/unlock.png',
                        width: 20,
                      ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            'Goal Balance',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.white,
                  fontSize: 12,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            'KES. 20,000',
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Created on ${formatDate(widget.createdAt!, false)}',
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 10,
                    ),
              ),
              const SizedBox(height: 5),
            ],
          ),
        ],
      ),
    );
    Widget transactButtons = Container(
      margin: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          GestureDetector(
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: MakeTransaction(
                  transactionType: 'deposit',
                  walletID: widget.id,
                  category: widget.category,
                ),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/icons/deposit.png',
                    width: 20,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Deposit',
                  style: displayNormalBlack,
                )
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              PersistentNavBarNavigator.pushNewScreen(
                context,
                screen: MakeTransaction(
                  transactionType: 'withdraw',
                  walletID: widget.id,
                  category: widget.category,
                  planBalance: widget.planBalance,
                ),
                withNavBar: false,
                pageTransitionAnimation: PageTransitionAnimation.cupertino,
              );
            },
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: const BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/icons/arrowUp.png',
                    width: 20,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Withdraw',
                  style: displayNormalBlack,
                )
              ],
            ),
          ),
        ],
      ),
    );

    Widget membersListWidget = Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Text(
              'Members',
              style: displayNormalSlightlyBoldBlack,
            ),
          ),
          widget.membersList != []
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.membersList?.length,
                  itemBuilder: (BuildContext context, int index) {
                    final oneMember = widget.membersList?[index];
                    return Text('${oneMember['name']}');
                  },
                )
              : const Center(
                  child: Text('no members'),
                )
        ],
      ),
    );
    Widget transactions = Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Text(
              'Recent Transactions',
              style: displayNormalSlightlyBoldBlack,
            ),
          ),
          transactionList.isNotEmpty
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: transactionList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return TransactionCard(
                      type: 'deposit',
                      plan: transactionList[index]['wallet']['plan']
                          ['goal_name'],
                      amount: transactionList[index]['amount'],
                      time: transactionList[index]['createdAt'],
                    );
                  },
                )
              : Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/illustrations/tansaction.png',
                        width: SizeConfig.blockSizeHorizontal * 50,
                      ),
                      Text(
                        'No transactions',
                        style: displayNormalBlack,
                      ),
                    ],
                  ),
                )
        ],
      ),
    );
    return Scaffold(
      backgroundColor: const Color.fromRGBO(244, 244, 244, 1),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  bottom: 20,
                  top: 20,
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
                      '${widget.plan}',
                      style: displayNormalBiggerSlightlyBoldBlack,
                    ),
                    //Container(width: 30),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditPlan(
                              initialGoalName: widget.plan,
                              initialGoalDescription: widget.planDescription,
                              initialTargetAmount: widget.target?.toInt(),
                              initialCategory: widget.category,
                              initialMaturityDate:
                                  DateTime.now().add(const Duration(days: 30)),
                              initialLockPlan: widget.locked!,
                              initialFrequency: widget.frequency,
                              planId: widget.id,
                              initialmembersList: widget.membersList,
                            ),
                          ),
                        );
                      },
                      child: Image.asset(
                        'assets/icons/edit.png',
                        width: 25,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: const DecorationImage(
                              image: AssetImage('assets/blob/blob1.png'),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                begin: Alignment.bottomLeft,
                                end: Alignment.topRight,
                                colors: [
                                  const Color.fromARGB(255, 2, 7, 93)
                                      .withOpacity(0.8),
                                  const Color.fromARGB(255, 22, 6, 112)
                                      .withOpacity(0.1),
                                ],
                              ),
                            ),
                            child: balCard,
                          ),
                        ),
                      ],
                    ),
                    Progress(
                      progress: widget.progress!,
                      planBalance: widget.planBalance!,
                      target: widget.target,
                    ),
                    transactButtons,
                    const SizedBox(height: 20),
                    GoalPerformance(
                      planDescription: widget.planDescription!,
                      createdAt: widget.createdAt!,
                      target: widget.target!,
                      maturityDate: widget.maturityDate!,
                    ),
                    widget.membersList!.isEmpty
                        ? Container()
                        : membersListWidget,
                    transactions,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
