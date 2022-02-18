import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sethkitchen/router.dart';
import 'package:sethkitchen/wallet/dialogs/insufficient_funds.dart';
import 'package:sethkitchen/wallet/dialogs/make_transaction_manually.dart';
import 'package:sethkitchen/wallet/dialogs/select_account.dart';
import 'package:sethkitchen/wallet/utils/base_account.dart';
import 'package:sethkitchen/wallet/utils/solana_pay.dart';
import 'package:sethkitchen/wallet/utils/states.dart';
import 'package:sethkitchen/wallet/utils/tracker.dart';
import 'package:sethkitchen/wallet/utils/wallet_account.dart';
import 'package:uni_links/uni_links.dart';

class App extends HookConsumerWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TokenTrackers tokensTracer = ref.read(tokensTrackerProvider);
    ref.watch(settingsProvider);
    ThemeType selectedTheme = ref.read(settingsProvider.notifier).getTheme();
    bool isDarkTheme = selectedTheme == ThemeType.dark;

    useEffect(() {
      loadState(tokensTracer, ref);
    }, []);

    return RoutedApp({});
  }
}

class LinkListenerWrapper extends HookConsumerWidget {
  final Widget child;

  const LinkListenerWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    useEffect(
      () {
        /*if (Platform.isWindows || Platform.isMacOS || Platform.isLinux)
          return () => {}; */
        try {
          final listener = uriLinkStream.listen(
            (Uri? uri) {
              if (uri != null) {
                final transaction =
                    TransactionSolanaPay.parseUri(uri.toString());

                WidgetsBinding.instance?.addPostFrameCallback(
                  (_) async {
                    final account = await selectAccount(context);
                    if (account is WalletAccount) {
                      String defaultTokenSymbol = "SOL";

                      if (transaction.splToken != null) {
                        try {
                          Token selectedToken =
                              account.getTokenByMint(transaction.splToken!);
                          defaultTokenSymbol = selectedToken.info.symbol;
                        } catch (_) {
                          insuficientFundsDialog(context);
                          return;
                        }
                      }

                      makePaymentManuallyDialog(
                        context,
                        account,
                        initialDestination: transaction.recipient,
                        initialSendAmount: transaction.amount ?? 0,
                        defaultTokenSymbol: defaultTokenSymbol,
                      );
                    }
                  },
                );
              }
            },
            onError: (err) {},
          );

          return () => listener.cancel();
        } catch (err) {}
      },
    );

    return child;
  }
}
