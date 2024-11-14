import 'package:flutter/material.dart';
import 'package:loatodo_app/models/day_content.dart';

class DayTodoWidget extends StatelessWidget {
  final DayContent chaos;
  final int chaosCheck;
  final int chaosGauge;
  final double chaosGold;

  const DayTodoWidget({
    super.key,
    required this.chaos,
    required this.chaosCheck,
    required this.chaosGauge,
    required this.chaosGold,
  });

  Widget _buildCheckboxRow() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black12),
        ),
      ),
      child: Row(
        children: [
          // 체크박스
          Transform.scale(
            scale: 0.8,
            child: Checkbox(
              value: chaosCheck > 0,
              onChanged: null,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4),
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity.compact,
            ),
          ),
          // 텍스트
          Text(
            '쿠르잔 전선',
            style: TextStyle(
              color: Colors.grey.shade600,
              fontSize: 12,
            ),
          ),
          // 골드 정보
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.monetization_on,
                  color: Colors.amber,
                  size: 14,
                ),
                const SizedBox(width: 2),
                Text(
                  '${chaosGold.toStringAsFixed(2)} G',
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(width: 2),
                Icon(
                  Icons.search,
                  size: 14,
                  color: Colors.grey.shade400,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRestGauge() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      child: Column(
        children: [
          // 게이지 바
          SizedBox(
            height: 3,
            child: Row(
              children: List.generate(11, (index) {
                final currentGauge = index * 20;
                final isActive = chaosGauge >= currentGauge;

                return Expanded(
                  child: Container(
                    margin: EdgeInsets.only(right: index < 10 ? 0.5 : 0),
                    decoration: BoxDecoration(
                      color: isActive
                          ? Colors.blue.shade400
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(1.5),
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 4),
          // 게이지 수치
          Text(
            '휴식게이지 $chaosGauge',
            style: TextStyle(
              color: Colors.blue.shade700,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildCheckboxRow(),
        _buildRestGauge(),
      ],
    );
  }
}
