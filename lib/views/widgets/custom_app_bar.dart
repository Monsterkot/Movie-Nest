import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title = '',
    this.leading,
    this.titleWidget,
    this.showActionIcon = false,
    this.actionIcon = const Icon(
      Icons.search,
      color: Colors.white,
    ),
    this.secondActionIcon, // Новый параметр для второй кнопки
    this.onActionTap,
    this.onSecondActionTap, // Обработчик для второй кнопки
    this.onLeadingTap,
  });

  final String title;
  final Widget? leading;
  final Widget? titleWidget;
  final bool showActionIcon;
  final Icon actionIcon;
  final Icon? secondActionIcon; // Иконка для второй кнопки
  final VoidCallback? onActionTap;
  final VoidCallback? onSecondActionTap; // Обработчик для второй кнопки
  final VoidCallback? onLeadingTap;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.blue.shade900, // Цвет статус-бара (синего цвета)
      statusBarIconBrightness: Brightness.light, // Цвет иконок (светлый для синего фона)
    ),
  );
    return SafeArea(
      child: Container(
        color: Colors.blue.shade900,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 25 / 2.5 + 10,
          ),
          child: Stack(
            children: [
              Positioned.fill(
                child: titleWidget == null
                    ? Center(
                        child: Text(
                          title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      )
                    : Center(
                        child: titleWidget,
                      ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Transform.translate(
                    offset: const Offset(-14, 0),
                    child: leading ??
                        IconButton(
                          onPressed: () => onLeadingTap?.call(),
                          icon: const Icon(
                            Icons.menu,
                            color: Colors.white,
                          ),
                        ),
                  ),
                  Row(
                    children: [
                      if (showActionIcon)
                        Transform.translate(
                          offset: const Offset(14, 0),
                          child: InkWell(
                            onTap: () {
                              onActionTap?.call();
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: actionIcon,
                            ),
                          ),
                        ),
                      if (secondActionIcon !=
                          null) // Проверка на наличие второй иконки
                        Transform.translate(
                          offset: const Offset(14, 0),
                          child: InkWell(
                            onTap: () {
                              onSecondActionTap
                                  ?.call(); // Обработка нажатия второй кнопки
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: secondActionIcon,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(
        double.maxFinite,
        80,
      );
}
