import 'package:flutter/material.dart';

class IndicatorCard extends StatefulWidget {
  String title;
  double value;
  double change;
  IndicatorCard(
      {Key? key,
      required this.title,
      required this.value,
      required this.change})
      : super(key: key);

  @override
  State<IndicatorCard> createState() => _IndicatorCardState();
}

class _IndicatorCardState extends State<IndicatorCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return SizedBox(
      width: width / 2.35,
      height: 160,
      child: Card(
        color: widget.change < 0
            ? const Color.fromRGBO(60, 255, 178, 1)
            : widget.change == 0
                ? Colors.grey[300]
                : Colors.red[100],
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            Align(
                alignment: Alignment.topLeft,
                child: Text(widget.title,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(30, 31, 31, 1)))),
            const Spacer(),
            Align(
              alignment: Alignment.centerLeft,
              child: Text('${widget.value.toStringAsFixed(2)}%',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                      color: Color.fromRGBO(30, 31, 31, 1))),
            ),
            const Spacer(),
            Align(
                alignment: Alignment.bottomLeft,
                child: Container(
                  width: 100,
                  decoration: BoxDecoration(
                      color: const Color.fromRGBO(30, 31, 31, 1),
                      borderRadius: BorderRadius.circular(20)),
                  padding:
                      const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  child: Row(children: [
                    Icon(
                      widget.change < 0
                          ? Icons.arrow_drop_down_sharp
                          : widget.change == 0
                              ? Icons.noise_control_off_outlined
                              : Icons.arrow_drop_up,
                      color: Colors.white,
                    ),
                    const Spacer(),
                    Text('${widget.change.toStringAsFixed(2)}%',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white))
                  ]),
                )),
          ]),
        ),
      ),
    );
  }
}
