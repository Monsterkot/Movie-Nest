import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../../../generated/l10n.dart';
import '../../../router/router.gr.dart';
import '../../../services/session_service.dart';
import '../../../theme/app_text_style.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  DrawerScreenState createState() => DrawerScreenState();
}

class DrawerScreenState extends State<DrawerScreen> {
  void _openUserAccount() {
    AutoRouter.of(context).push(const AccountRoute());
  }

  Future<void> _logoutUser(BuildContext context) async {
    await GetIt.I<SessionService>().clearSessionId();

    // Используем addPostFrameCallback для навигации после завершения асинхронной работы
    WidgetsBinding.instance.addPostFrameCallback((_) {
      AutoRouter.of(context).replaceAll([const AuthRoute()]);
    });
  }

  void _showModalDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.black.withValues(alpha: 0.5),
          content:  Text(S.of(context).areYouSureYouWantToLogOut),
          contentTextStyle: AppTextStyle.small16WhiteTextStyle,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          actions: [
            TextButton(
              onPressed: () {
                _logoutUser(context);
              },
              child: Text(S.of(context).yes),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(S.of(context).no),
            ),
          ],
          actionsAlignment: MainAxisAlignment.spaceAround,
        );
      },
    );
  }

  void _openFavorites() {
    AutoRouter.of(context).push(const FavoritesRoute());
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.indigo.shade900,
      child: Padding(
        padding: const EdgeInsets.only(top: 70, left: 40, bottom: 70),
        child: Column(
          spacing: 20,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: const Image(
                      fit: BoxFit.cover,
                      image: AssetImage('lib/images/splash_logo.png'),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'MovieNest',
                  style: AppTextStyle.bigWhiteTextStyle,
                ),
              ],
            ),
            Column(
              spacing: 20,
              children: <Widget>[
                NewRow(
                  text: S.of(context).profile,
                  icon: Icons.person_outline,
                  onTap: _openUserAccount,
                ),
                NewRow(
                  text: S.of(context).favorites,
                  icon: Icons.favorite_border,
                  onTap: _openFavorites,
                ),
                NewRow(
                  text: S.of(context).settings,
                  icon: Icons.settings,
                ),
              ],
            ),
            GestureDetector(
              onTap: () => _showModalDialog(context),
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.logout,
                    color: Colors.red.withValues(alpha: 0.5),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    S.of(context).logOut,
                    style: TextStyle(color: Colors.red.withValues(alpha: 0.5)),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class NewRow extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback? onTap; // Добавляем параметр onTap

  const NewRow({
    super.key,
    required this.icon,
    required this.text,
    this.onTap, // Добавляем onTap в конструктор
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Оборачиваем в GestureDetector
      onTap: onTap, // Устанавливаем обработчик нажатия
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.white,
          ),
          const SizedBox(
            width: 20,
          ),
          Text(
            text,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
