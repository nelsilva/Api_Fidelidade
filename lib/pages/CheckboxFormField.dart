import 'package:flutter/material.dart';

// Exemplo:
//CheckboxFormField(
//   initialValue: checkboxValue,
//   title: Text('Declaro que li e concordo com os Termos de Uso.'),
//   subtitle: !checkboxValue
//       ? Text(
//           'Obrigatório !',
//           style: TextStyle(color: Colors.yellow),
//         )
//       : null,
//   onSaved: (bool value) {
//     setState(() => checkboxValue = value);
//   },
//   validator: (bool value) {
//     if (value) {
//       return null;
//     } else {
//       return 'False!';
//     }
//   },
// ),

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField(
      {Widget title,
      FormFieldSetter<bool> onSaved,
      FormFieldValidator<bool> validator,
      bool initialValue = false,
      bool autovalidate = false})
      : super(
            onSaved: onSaved,
            validator: validator,
            initialValue: initialValue,
            builder: (FormFieldState<bool> state) {
              return CheckboxListTile(
                dense: state.hasError,
                title: title,
                value: state.value,
                onChanged: state.didChange,
                subtitle: state.hasError
                    ? Builder(
                        builder: (BuildContext context) => Text(
                          state.errorText,
                          style: TextStyle(color: Theme.of(context).errorColor),
                        ),
                      )
                    : null,
                controlAffinity: ListTileControlAffinity.leading,
              );
            });
}
