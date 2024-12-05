import 'package:flutter/material.dart';
import 'package:sportRex/core/commonLibs/routes_libs.dart';
import 'package:sportRex/core/config/constant.dart';
import 'package:sportRex/core/data/wallet_type.dart';
import 'package:sportRex/core/route/routes.dart';
import 'package:sportRex/core/util/appUtil/helper.dart';
import 'package:sportRex/core/util/styleaUtils/themScaffold.dart';
import 'package:sportRex/features/addWallet/view/page/add_wallet.dart';
import 'package:sportRex/features/addWallet/view/page/import_other_wallet.dart';
import 'package:sportRex/features/addWallet/view/page/import_wallet.dart';
import 'package:sportRex/features/backWallet/view/page/backup-phrase.dart';
import 'package:sportRex/features/backWallet/view/page/backup-wallet.dart';
import 'package:sportRex/features/backWallet/view/page/verify-phrase.dart';
import 'package:sportRex/features/card/view/page/add_card.dart';
import 'package:sportRex/features/card/view/page/available_card.dart';
import 'package:sportRex/features/card/view/page/card-detail.dart';
import 'package:sportRex/features/connections/view/connect_wallet_screen.dart';
import 'package:sportRex/features/dashBoard/view/page/dashboard.dart';
import 'package:sportRex/features/dex/view/page/market.dart';
import 'package:sportRex/features/dex/view/page/open_order.dart';
import 'package:sportRex/features/dex/view/page/swap.dart';
import 'package:sportRex/features/explore/view/page/blog_details.dart';
import 'package:sportRex/features/nft/model/data/nft_details_response.dart';
import 'package:sportRex/features/nft/view/nft_collectibles_screen.dart';
import 'package:sportRex/features/nft/view/nft_details_screen.dart';
import 'package:sportRex/features/nft/view/notification_screen.dart';
import 'package:sportRex/features/nft/view/send_nft_screen.dart';
import 'package:sportRex/features/onboardingScreen/view/page/create_wallet_screen.dart';
import 'package:sportRex/features/onboardingScreen/view/page/onboarding_screen.dart';
import 'package:sportRex/features/performTransaction/view/page/performTransaction.dart';
import 'package:sportRex/features/priceAlert/view/price-alert.dart';
import 'package:sportRex/features/profile/view/profile.dart';
import 'package:sportRex/features/pushNotification/view/push-notification.dart';
import 'package:sportRex/features/search/view/page/search.dart';
import 'package:sportRex/features/search/view/page/send_nft.dart';
import 'package:sportRex/features/security/view/page/confirm_password.dart';
import 'package:sportRex/features/security/view/page/enter_old_password.dart';
import 'package:sportRex/features/security/view/page/security.dart';
import 'package:sportRex/features/token/model/data/token_detail_response.dart';
import 'package:sportRex/features/token/view/page/manage_token.dart';
import 'package:sportRex/features/token/view/page/token-detail.dart';
import 'package:sportRex/features/token/view/page/token-transactions.dart';
import 'package:sportRex/features/token/view/page/transaction-detail.dart';
import 'package:sportRex/features/wallet/view/page/wallet.dart';

import '../../features/connections/view/connections_wallet_screen.dart';
import '../../features/nft/view/nft_collection_details_screen.dart';
import '../../features/nft/view/nft_collections_screen.dart';
import '../../features/nft/view/nft_transactions_screen.dart';
import '../../features/performTransaction/model/data/transactionType.dart';
import '../../features/secure/view/page/login_screen.dart';
import '../../features/secure/view/page/secure_wallet_pin_screen.dart';
import '../../features/security/view/page/enter_new_password.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    var args = settings.arguments;

    if (isEmpty(settings.name!)) {
      return CustomMaterialPageRoute(builder: (_) => const ErrorScreen());
    }

    switch (settings.name) {
      case SplashScreen.route:
        const page = SplashScreen();
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case OnboardingScreen.route:
        const page = OnboardingScreen();
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case CreateWalletScreen.route:
        const page = CreateWalletScreen();
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      // case SecureWalletScreen.route:
      //   const page = SecureWalletScreen();
      //   return CustomMaterialPageRoute(
      //       builder: (_) => ThemeScaffold(child: page));

      case SecureWalletPinScreen.route:
        const page = SecureWalletPinScreen();
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case AddWallet.route:
        const page = AddWallet();
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case ImportWallet.route:
        final page = ImportWallet(
          walletType: args as ImportWalletType,
        );
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case ImportOtherWallet.route:
        final page = ImportOtherWallet(
          walletType: args as ImportWalletType,
        );
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case DashBoard.route:
        const page = DashBoard();
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case ItemSwapPage.route:
        const page = ItemSwapPage();
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case AppRoutes.backupYourWallet:
        const page = BackupYourWallet();
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case AppRoutes.blogDetail:
        const page = BlogDetail();
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case LoginScreen.route:
        const page = LoginScreen();
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case ConnectWalletScreen.routeName:
        const page = ConnectWalletScreen();
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case AppRoutes.backupPhrase:
        const page = BackupPhrase();
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case AppRoutes.verifyPhrase:
        const page = VerifyPhrase();
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case AppRoutes.tokenDetail:
        final page = TokenDetailsScreen(
          token: settings.arguments as TokenItem,
        );
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case AppRoutes.tokenTransaction:
        final page = TokenTransactions(
          token: settings.arguments as TokenTransacData,
        );
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case AppRoutes.transactionDetail:
        const page = TransactionDetail();
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case NftDetailsScreen.route:
        final page = NftDetailsScreen(
          nft: settings.arguments as Result,
        );
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case ConnectionsWalletScreen.routeName:
        const page = ConnectionsWalletScreen();

        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case NftCollectionDetailsScreen.route:
        final page = NftCollectionDetailsScreen(
          dummnyNFTDetails: settings.arguments as List<DummnyNFTDetails>,
        );
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case NftCollectiblesScreen.route:
        final page = NftCollectiblesScreen(
          dummnyNftCollectibles: settings.arguments as List<DummnyNFTDetails>,
        );
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case NFTTransactionScreen.route:
        const page = NFTTransactionScreen();
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case AvailableCard.route:
        const page = AvailableCard();
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case NftCollectionScreen.route:
        final page = NftCollectionScreen(
          dummnyNFTCollections: settings.arguments as DummnyNFTCollections,
        );
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case MarketsPage.route:
        const page = MarketsPage();
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case SendNftScreen.route:
        const page = SendNftScreen();
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case NotificationScreen.route:
        const page = NotificationScreen();
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case OpenOrder.route:
        const page = OpenOrder();
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case AppRoutes.profile:
        final page = Profile(
          showBackBtn: settings.arguments as bool?,
        );
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));
      case AppRoutes.wallet:
        const page = Wallet();
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case AppRoutes.priceAlert:
        const page = PriceAlert();
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case AppRoutes.pushNotification:
        const page = PushNotification();
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case AppRoutes.security:
        const page = Security();
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case EnterOldPassword.route:
        const page = EnterOldPassword();
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case EnterNewPassword.route:
        const page = EnterNewPassword();
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case ConfirmPassword.route:
        const page = ConfirmPassword();
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case Search.route:
        const page = Search();
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case ManageTokens.route:
        const page = ManageTokens();
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case PerformTransaction.route:
        final page = PerformTransaction(
          transactionType: args as PerformTransactionType,
        );
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case AddCard.route:
        final page = AddCard();
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case AppRoutes.cardDetail:
        const page = CardDetails();
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      case SendNftPage.route:
        const page = SendNftPage();
        return CustomMaterialPageRoute(
            builder: (_) => ThemeScaffold(child: page));

      default:
        return CustomMaterialPageRoute(builder: (_) => const ErrorScreen());
    }
  }
}

class CustomMaterialPageRoute extends MaterialPageRoute {
  @protected
  @override
  bool get hasScopedWillPopCallback {
    return false;
  }

  CustomMaterialPageRoute({
    required WidgetBuilder builder,
    RouteSettings? settings,
    bool maintainState = true,
    bool fullscreenDialog = false,
  }) : super(
          builder: builder,
          settings: settings,
          maintainState: maintainState,
          fullscreenDialog: fullscreenDialog,
        );
}

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Route does not exist',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

class TokenTransacData {
  final String chain;
  final String symbol;
  final String balance;
  final int decimal;
  final double usdValue;
  final String tokenAddress;
  TokenTransacData({
    required this.chain,
    required this.symbol,
    required this.balance,
    required this.decimal,
    required this.usdValue,
    required this.tokenAddress,
  });
}
