import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';

import 'components/atoms/ds_button.dart';
import 'components/atoms/ds_text_field.dart';
import 'components/atoms/ds_badge.dart';
import 'components/atoms/ds_chip.dart';
import 'components/molecules/accordion.dart';
import 'components/molecules/header.dart';
import 'components/molecules/card.dart';

void main() {
  runApp(
    Widgetbook.material(
      directories: [
        WidgetbookCategory(
          name: 'Atoms',
          children: [
            WidgetbookComponent(
              name: 'DSButton',
              useCases: [
                WidgetbookUseCase(
                  name: 'Primary',
                  builder: (context) => DSButton.primary(
                    onPressed: () {},
                    child: const Text('Primary Button'),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'Secondary',
                  builder: (context) => DSButton.secondary(
                    onPressed: () {},
                    child: const Text('Secondary Button'),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'Ghost',
                  builder: (context) => DSButton.ghost(
                    onPressed: () {},
                    child: const Text('Ghost Button'),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'Disabled',
                  builder: (context) => DSButton.primary(
                    onPressed: null,
                    child: const Text('Disabled Button'),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'DSTextField',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) => DSTextField(
                    controller: TextEditingController(),
                    label: 'Label',
                  ),
                ),
                WidgetbookUseCase(
                  name: 'With Hint',
                  builder: (context) => DSTextField(
                    controller: TextEditingController(),
                    label: 'Label',
                    hintText: 'Enter text',
                  ),
                ),
                WidgetbookUseCase(
                  name: 'With Error',
                  builder: (context) => DSTextField(
                    controller: TextEditingController(),
                    label: 'Label',
                    errorText: 'Error message',
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'DSBadge',
              useCases: [
                WidgetbookUseCase(
                  name: 'Success',
                  builder: (context) => DSBadge.success(label: 'Success'),
                ),
                WidgetbookUseCase(
                  name: 'Warning',
                  builder: (context) => DSBadge.warning(label: 'Warning'),
                ),
                WidgetbookUseCase(
                  name: 'Error',
                  builder: (context) => DSBadge.error(label: 'Error'),
                ),
                WidgetbookUseCase(
                  name: 'Info',
                  builder: (context) => DSBadge.info(label: 'Info'),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'DSChip',
              useCases: [
                WidgetbookUseCase(
                  name: 'Unselected',
                  builder: (context) =>
                      DSChip(label: 'Chip', onSelected: (_) {}),
                ),
                WidgetbookUseCase(
                  name: 'Selected',
                  builder: (context) =>
                      DSChip(label: 'Chip', selected: true, onSelected: (_) {}),
                ),
              ],
            ),
          ],
        ),
        WidgetbookCategory(
          name: 'Molecules',
          children: [
            WidgetbookComponent(
              name: 'Accordion',
              useCases: [
                WidgetbookUseCase(
                  name: 'Collapsed',
                  builder: (context) => Accordion(
                    title: const Text('Accordion Title'),
                    content: const Text('Accordion Content'),
                    expanded: false,
                    onExpandedChanged: (_) {},
                  ),
                ),
                WidgetbookUseCase(
                  name: 'Expanded',
                  builder: (context) => Accordion(
                    title: const Text('Accordion Title'),
                    content: const Text('Accordion Content'),
                    expanded: true,
                    onExpandedChanged: (_) {},
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Header',
              useCases: [
                WidgetbookUseCase(
                  name: 'Title Only',
                  builder: (context) =>
                      Header.titleOnly(title: const Text('Page Title')),
                ),
                WidgetbookUseCase(
                  name: 'Title with CTA',
                  builder: (context) => Header.titleWithCTA(
                    title: const Text('Page Title'),
                    cta: const Text('Action'),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'Title with Icon',
                  builder: (context) => Header.titleWithIcon(
                    title: const Text('Page Title'),
                    icon: const Icon(Icons.menu),
                  ),
                ),
              ],
            ),
            WidgetbookComponent(
              name: 'Card',
              useCases: [
                WidgetbookUseCase(
                  name: 'Default',
                  builder: (context) =>
                      DSCard(child: const Text('Card Content')),
                ),
                WidgetbookUseCase(
                  name: 'With Title',
                  builder: (context) => DSCard(
                    title: const Text('Card Title'),
                    child: const Text('Card Content'),
                  ),
                ),
                WidgetbookUseCase(
                  name: 'With Elevation',
                  builder: (context) =>
                      DSCard(elevation: 4, child: const Text('Card Content')),
                ),
              ],
            ),
          ],
        ),
      ],
      addons: [
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(name: 'Light', data: ThemeData.light()),
            WidgetbookTheme(name: 'Dark', data: ThemeData.dark()),
          ],
        ),
      ],
    ),
  );
}
