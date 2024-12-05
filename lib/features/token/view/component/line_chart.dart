import 'package:fl_chart/fl_chart.dart';
import 'package:sportRex/core/commonLibs/common_libs.dart';

import '../../../../core/util/chartUtil/chart-utils.dart';

class LineChartWidget extends StatelessWidget {
  final List<double> data;
  final Color color;
  final bool loading;
  final bool error;

  const LineChartWidget(
      {Key? key,
      this.data = const [],
      this.color = const Color(0xff09CE35),
      this.loading = false,
      this.error = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.center, children: [
      Opacity(
        opacity: data.isNotEmpty && !loading & !error ? 0.5 : 1,
        child: SizedBox(
          width: double.infinity,
          child: LineChart(
            mainData(
                data.isNotEmpty && !loading & !error ? data : demoGraphData),
            swapAnimationDuration: const Duration(seconds: 0),
          ),
        ),
      ),
      if (loading)
        const Center(
          child: CircularProgressIndicator(),
        )
      else if (error || data.isEmpty)
        Center(
          child: Text("", style: Theme.of(context).textTheme.displaySmall),
        )
    ]);
  }

  LineChartData mainData(List<double> data) {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        drawHorizontalLine: false,
        horizontalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: $styles.colors.green,
            strokeWidth: 0.5,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: $styles.colors.green,
            strokeWidth: 0.5,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: false,
      ),
      borderData: FlBorderData(
        show: false,
      ),
      minX: 0,
      maxX: data.length.toDouble() - 3,
      minY: data.reduce(min).toDouble(),
      maxY: data.reduce(max).toDouble(),
      lineBarsData: [
        LineChartBarData(
          spots: listData(data),
          colors: [color],
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradientFrom: const Offset(0, .9),
            gradientTo: const Offset(0, 0.5),
            colors: [color.withOpacity(.20), color.withOpacity(.9)],
          ),
        ),
      ],
    );
  }

  List<FlSpot> listData(List<double> data) {
    return data
        .mapIndexed((e, i) => FlSpot(i.toDouble(), e.toDouble()))
        .toList();
  }
}

extension IndexedIterable<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}
