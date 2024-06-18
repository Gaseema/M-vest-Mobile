import 'package:invest/imports/imports.dart';

class UserTransactions extends StatefulWidget {
  const UserTransactions({super.key});

  @override
  State<UserTransactions> createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  // Transaction variables
  bool fetchingUserTransactions = true;

  @override
  void initState() {
    super.initState();
    fetchTransactions(context).then((res) {
      setState(() {
        final userTransactionsProvider = Provider.of<UserTransactionsProvider>(
          context,
          listen: false,
        );
        userTransactionsProvider.updateUserTransactions(res['data']);
        fetchingUserTransactions = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Transaction Provider
    final userTransactionsProvider =
        Provider.of<UserTransactionsProvider>(context);
    final userTransactions = userTransactionsProvider.userTransactions;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Text(
            'Recent Transactions',
            style: displayNormalSlightlyBoldBlack,
          ),
        ),
        userTransactions.isNotEmpty
            ? ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: userTransactions.length,
                itemBuilder: (BuildContext context, int index) {
                  return TransactionCard(
                    type: 'deposit',
                    plan: userTransactions[index]['wallet']['plan']
                        ['goal_name'],
                    amount: userTransactions[index]['amount'],
                    time: userTransactions[index]['createdAt'],
                  );
                },
              )
            : Center(
                child: Column(
                  children: [
                    SvgPicture.asset(
                      'assets/svg/transact.svg',
                      width: 200,
                    ),
                    Text(
                      'No transactions',
                      style: displayNormalBlack,
                    ),
                  ],
                ),
              ),
        const SizedBox(height: 50),
      ],
    );
  }
}
