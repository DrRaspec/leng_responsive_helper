import 'package:flutter/material.dart';
import 'package:leng_responsive_helper/responsive_helper.dart';
import 'package:leng_responsive_helper/src/extensions/context_extension_helpers.dart';

/// Form example showing responsive form layout and validation
class FormExample extends StatefulWidget {
  const FormExample({super.key});

  @override
  State<FormExample> createState() => _FormExampleState();
}

class _FormExampleState extends State<FormExample> {
  final _formKey = GlobalKey<FormState>();
  final _firstName = TextEditingController();
  final _lastName = TextEditingController();
  final _email = TextEditingController();

  @override
  void dispose() {
    _firstName.dispose();
    _lastName.dispose();
    _email.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ResponsiveHelper.init(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Form Example')),
      body: Padding(
        padding: context.dynamicPadding.padding,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              if (context.isMobile) ...[
                TextFormField(
                  controller: _firstName,
                  decoration: const InputDecoration(labelText: 'First Name'),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
                12.verticalSpace,
                TextFormField(
                  controller: _lastName,
                  decoration: const InputDecoration(labelText: 'Last Name'),
                  validator: (v) =>
                      (v == null || v.trim().isEmpty) ? 'Required' : null,
                ),
              ] else ...[
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _firstName,
                        decoration:
                            const InputDecoration(labelText: 'First Name'),
                        validator: (v) =>
                            (v == null || v.trim().isEmpty) ? 'Required' : null,
                      ),
                    ),
                    12.horizontalSpace,
                    Expanded(
                      child: TextFormField(
                        controller: _lastName,
                        decoration:
                            const InputDecoration(labelText: 'Last Name'),
                        validator: (v) =>
                            (v == null || v.trim().isEmpty) ? 'Required' : null,
                      ),
                    ),
                  ],
                ),
              ],
              12.verticalSpace,
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v == null || v.trim().isEmpty) return 'Required';
                  final emailRegex = RegExp(r"^[^@\s]+@[^@\s]+\.[^@\s]+$");
                  if (!emailRegex.hasMatch(v)) return 'Invalid email';
                  return null;
                },
              ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      _formKey.currentState?.reset();
                      _firstName.clear();
                      _lastName.clear();
                      _email.clear();
                    },
                    child: const Text('Reset'),
                  ),
                  16.horizontalSpace,
                  ElevatedButton(
                    onPressed: _submit,
                    child: const Text('Submit'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      context.showSuccessSnackBar('Form submitted');
    } else {
      context.showErrorSnackBar('Please fix errors');
    }
  }
}
