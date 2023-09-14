import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:list_of_transactions/common/widgets/indicator.dart';
import 'package:list_of_transactions/features/transactions/data/models/transaction.dart';

class DonutChart extends StatefulWidget {
  const DonutChart(this.transactions, {super.key});
  final List<Transaction> transactions;

  @override
  State<DonutChart> createState() => _DonutChartState();
}

class _DonutChartState extends State<DonutChart> {
  int touchedIndex = -1;
  static Color transferColor = Colors.blue;
  static Color depositColor = Colors.green;
  static Color withdrawalColor = Colors.red;

  late final transferPercent = _calculateTransactionPercent(
      widget.transactions, TransactionType.transfer);
  late final depositPercent = _calculateTransactionPercent(
      widget.transactions, TransactionType.deposit);
  late final withdrawalPercent = _calculateTransactionPercent(
      widget.transactions, TransactionType.withdrawal);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const SizedBox(
          height: 18,
        ),
        Expanded(
          child: AspectRatio(
            aspectRatio: 1,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    setState(() {
                      if (!event.isInterestedForInteractions ||
                          pieTouchResponse == null ||
                          pieTouchResponse.touchedSection == null) {
                        touchedIndex = -1;
                        return;
                      }
                      touchedIndex =
                          pieTouchResponse.touchedSection!.touchedSectionIndex;
                    });
                  },
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                sectionsSpace: 0,
                centerSpaceRadius: 40,
                sections: showingSections(),
              ),
            ),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Indicator(
              color: transferColor,
              text: 'Transfers',
              isSquare: true,
            ),
            const SizedBox(
              height: 4,
            ),
            Indicator(
              color: depositColor,
              text: 'Deposits',
              isSquare: true,
            ),
            const SizedBox(
              height: 4,
            ),
            Indicator(
              color: withdrawalColor,
              text: 'Withdrawals',
              isSquare: true,
            ),
            const SizedBox(
              height: 4,
            ),
            const SizedBox(
              height: 18,
            ),
          ],
        ),
        const SizedBox(
          width: 28,
        ),
      ],
    );
  }

  List<PieChartSectionData> showingSections() {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: transferColor,
            value: transferPercent,
            title: '${transferPercent * 100}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              shadows: shadows,
            ),
          );
        case 1:
          return PieChartSectionData(
            color: depositColor,
            value: depositPercent,
            title: '${depositPercent * 100}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              shadows: shadows,
            ),
          );
        case 2:
          return PieChartSectionData(
            color: withdrawalColor,
            value: withdrawalPercent,
            title: '${withdrawalPercent * 100}%',
            radius: radius,
            titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              shadows: shadows,
            ),
          );
        default:
          throw Error();
      }
    });
  }

  double _calculateTransactionPercent(
      List<Transaction> transactions, TransactionType type) {
    return transactions.where((e) => e.type == type).length /
        widget.transactions.length;
  }
}
