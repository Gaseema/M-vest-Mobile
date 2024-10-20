import 'package:invest/imports/imports.dart';

class Transactions extends StatefulWidget {
  const Transactions({Key? key}) : super(key: key);

  @override
  TransactionsState createState() => TransactionsState();
}

class TransactionsState extends State<Transactions> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userTransactionsProvider =
        Provider.of<UserTransactionsProvider>(context);
    final userTransactions = userTransactionsProvider.userTransactions;
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(),
                    Text(
                      'Transactions',
                      style: displayNormalBiggerSlightlyBoldBlack,
                    ),
                    Container(),
                  ],
                ),
              ),
              Expanded(
                child: userTransactions.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: userTransactions.length,
                        itemBuilder: (BuildContext context, int index) {
                          return TransactionCard(
                            type: userTransactions[index]['transaction_type'],
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
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
