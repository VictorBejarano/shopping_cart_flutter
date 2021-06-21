part of 'widgets.dart';

class StadiumButton extends StatelessWidget {
  final void Function() onPressed;
  final bool enabled;
  final String text;
  final Color color;
  final double width;
  const StadiumButton(
      {Key key,
      @required this.text,
      @required this.onPressed,
      @required this.enabled,
      this.width = double.infinity,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          minimumSize: Size(width, 40.0),
          shape: StadiumBorder(),
          primary: (color == null) ? (Colors.red) : color,
          onSurface: Colors.grey.shade900),
      onPressed: (enabled) ? onPressed : null,
      child: Text(text),
    );
  }
}
