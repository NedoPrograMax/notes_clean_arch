import "package:flutter/material.dart";

class DismissibleBackground extends StatelessWidget {
  const DismissibleBackground({
    Key? key,
    required bool isDeleting,
  })  : _isDeleting = isDeleting,
        super(key: key);

  final bool _isDeleting;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: _isDeleting ? Colors.red : Colors.green,
      child: Row(
        mainAxisAlignment:
            _isDeleting ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!_isDeleting)
            Flexible(
              flex: 1,
              child: Container(),
            ),
          Flexible(
            flex: 10,
            child: Icon(
              _isDeleting ? Icons.delete : Icons.edit,
              color: Colors.white,
              size: 40,
            ),
          ),
          if (_isDeleting)
            Flexible(
              flex: 1,
              child: Container(),
            ),
        ],
      ),
    );
  }
}
