import 'package:flutter/material.dart';
import 'package:orderable_example/orderable_widget_demo_base.dart';
import 'package:orderable_stack/orderable_stack.dart';

const chars = const ["A", "B", "C", "D"];
const vOrderableSize = const Size(200.0, 50.0);
const hOrderableSize = const Size(50.0, 80.0);

///
///
class OrderableTextDemo<String> extends OrderableWidgetDemo {
  @override
  _OrderableTextDemoState createState() => _OrderableTextDemoState();
}

class _OrderableTextDemoState extends OrderableWidgetDemoState<String> {
  Direction direction = Direction.Vertical;

  Size get itemSize =>
      direction == Direction.Vertical ? vOrderableSize : hOrderableSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Vertical'),
            Switch(
              value: direction == Direction.Horizontal,
              onChanged: _onDirectionSwitch,
            ),
            Text('Horizontal'),
          ],
        ),
        buildPreview(),
        Center(
          child: OrderableStack<String>(
            key: Key('orderableText'),
            direction: direction,
            items: chars,
            itemSize: itemSize,
            itemBuilder: itemBuilder,
            onChange: onReorder,
          ),
        )
      ],
    );
  }

  Widget itemBuilder({Orderable<String> data, Size itemSize}) {
    final color = data != null && !data.selected
        ? data.dataIndex == data.visibleIndex ? Colors.lime : Colors.cyan
        : Colors.orange;

    return Container(
        key: Key("orderableItem${data.dataIndex}"),
        color: color,
        width: itemSize.width,
        height: itemSize.height,
        child: Center(
          child: Column(
            children: [
              Text(
                "${data.value}",
                style: TextStyle(fontSize: 36.0, color: Colors.white),
              ),
            ],
          ),
        ));
  }

  void onReorder(List<String> items) {
    setState(() => orderedItems = items);
  }

  void _onDirectionSwitch(bool horizontal) => setState(
      () => direction = horizontal ? Direction.Horizontal : Direction.Vertical);
}
