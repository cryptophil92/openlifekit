import 'package:open_life_kit/features/checklists/domain/checklist.dart';

class BuiltInChecklists {
  const BuiltInChecklists._();

  static List<Checklist> all() {
    return const <Checklist>[
      Checklist(
        id: 'travel',
        title: 'Depart en voyage',
        description: 'Avant un trajet ou des vacances.',
        items: <ChecklistItem>[
          ChecklistItem(
              id: 'travel-documents', title: 'Verifier les documents'),
          ChecklistItem(id: 'travel-keys', title: 'Prevoir cles et acces'),
          ChecklistItem(
              id: 'travel-health', title: 'Preparer sante et traitements'),
        ],
      ),
      Checklist(
        id: 'medical',
        title: 'Urgence medicale',
        description: 'Informations utiles en cas de besoin.',
        items: <ChecklistItem>[
          ChecklistItem(id: 'medical-card', title: 'Fiche urgence accessible'),
          ChecklistItem(
              id: 'medical-contact', title: 'Contact proche disponible'),
          ChecklistItem(id: 'medical-treatment', title: 'Traitements verifies'),
        ],
      ),
      Checklist(
        id: 'move',
        title: 'Demenagement',
        description: 'Administratif et organisation.',
        items: <ChecklistItem>[
          ChecklistItem(id: 'move-address', title: 'Changer adresse'),
          ChecklistItem(id: 'move-insurance', title: 'Verifier assurance'),
          ChecklistItem(id: 'move-school', title: 'Verifier ecole ou creche'),
        ],
      ),
    ];
  }
}
