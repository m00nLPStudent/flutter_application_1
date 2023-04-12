import 'package:flutter/material.dart';

class CardMenuWidget extends StatelessWidget {
  const CardMenuWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Container(
        color: Colors.black.withOpacity(0.5),
        child: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            if (constraints.maxWidth > 600) {
              // code for wide screen
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  PrivacyWidget(),
                  ConditionsWidget(),
                  ContactWidget(),
                  ImpressumWidget(),
                ],
              );
            } else {
              // code for small screen
              return Row(
                children: [
                  Expanded(
                    child: PopupMenuButton<String>(
                      itemBuilder: (BuildContext context) {
                        return {
                          'Datenschutzerklärung',
                          'Nutzungsbedingungen',
                          'Kontakt',
                          'Impressum'
                        }.map((String choice) => _selectEntry(choice)).toList();
                      },
                      onSelected: (String choice) {
                        // navigate to the selected page
                      },
                      icon: const Icon(
                        Icons.menu,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  PopupMenuItem<String> _selectEntry(String choice) {
    return PopupMenuItem<String>(
      value: choice,
      child: Text(
        choice,
        style: const TextStyle(color: Colors.black),
      ),
    );
  }
}

class PrivacyWidget extends StatelessWidget {
  const PrivacyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // navigate to Datenschutzerklärung
      },
      child: const Text(
        'Datenschutzerklärung',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class ConditionsWidget extends StatelessWidget {
  const ConditionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // navigate to Nutzungsbedingungen
      },
      child: const Text(
        'Nutzungsbedingungen',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class ContactWidget extends StatelessWidget {
  const ContactWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // navigate to Kontakt
      },
      child: const Text(
        'Kontakt',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}

class ImpressumWidget extends StatelessWidget {
  const ImpressumWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // navigate to Impressum
      },
      child: const Text(
        'Impressum',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
