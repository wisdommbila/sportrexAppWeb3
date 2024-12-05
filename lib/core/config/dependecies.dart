import 'package:dio/dio.dart';
import 'package:ether_dart/ether_dart.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:sportRex/core/config/constant.dart';
import 'package:sportRex/core/data/local_data_source.dart';
import 'package:sportRex/core/route/navigation_service.dart';
import 'package:sportRex/core/service/finger_print_service.dart';
import 'package:sportRex/core/service/locale_service.dart';
import 'package:sportRex/core/service/payment_gate_way.dart';
import 'package:sportRex/core/service/toast_service.dart';
import 'package:sportRex/core/util/appUtil/app_starter.dart';
import 'package:sportRex/core/util/appUtil/logger.dart';
import 'package:sportRex/core/util/styleaUtils/app_style.dart';
import 'package:sportRex/features/addWallet/model/data_source/network/add_wallet_repository.dart';
import 'package:sportRex/features/addWallet/model/data_source/network/add_wallet_service.dart';
import 'package:sportRex/features/backWallet/model/data_source/network/backup_wallet_repository.dart';
import 'package:sportRex/features/backWallet/model/data_source/network/backup_wallet_service.dart';
import 'package:sportRex/features/dex/model/data_source/network/dex_repository.dart';
import 'package:sportRex/features/dex/model/data_source/network/dex_service.dart';
import 'package:sportRex/features/nft/model/datasource/nft_repository.dart';
import 'package:sportRex/features/nft/model/datasource/nft_service.dart';
import 'package:sportRex/features/token/model/dataSource/token_description_repository.dart';
import 'package:sportRex/features/token/model/dataSource/token_prices_history_repository.dart';
import 'package:sportRex/features/token/model/dataSource/token_repository.dart';
import 'package:sportRex/features/token/model/dataSource/token_service.dart';
import 'package:sportRex/features/token/model/dataSource/wallet_transactions_repository.dart';

final GetIt locator = GetIt.instance;

const baseUrl = host;

final logger = getLogger("Locator");

///inject dependencies here to make them available through out the app
void setUpLocator() async {
  //Other Service And Helper
  locator
    ..registerSingleton<AppStater>(AppStater())
    ..registerSingleton<NavigationService>(NavigationService())
    ..registerSingleton<ToastService>(ToastService())
    ..registerSingleton<AppLocale>(AppLocale())
    ..registerSingleton<FingerPrintService>(FingerPrintService())
    ..registerSingleton<PaymentGateWay>(PaymentGateWay())
    ..registerLazySingleton<EtherDart>(() => EtherDart.connect(
        Web3Client("https://ethereum-sepolia.publicnode.com", Client())))
    ..registerSingleton<Dio>(Dio())
    ..registerSingleton<LocalStorageService>(LocalStorageService())
    ..registerLazySingleton<PrettyDioLogger>(() => PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: false,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90))

    //Repository
    ..registerSingleton<BackUpWalletRepository>(
        BackUpWalletRepository(dioConfig()))
    ..registerSingleton<NFTRepository>(NFTRepository(dioConfig()))
    ..registerSingleton<TokenRepository>(TokenRepository(dioConfig()))
    ..registerSingleton<TokenPricesHistoryRepository>(
        TokenPricesHistoryRepository(dioConfig()))
    ..registerSingleton<WalletTransactionsRepository>(
        WalletTransactionsRepository(dioConfig()))
    ..registerSingleton<TokenDescriptionRepository>(
        TokenDescriptionRepository(dioConfig()))
    ..registerSingleton<AddWalletRepository>(AddWalletRepository(dioConfig()))
    ..registerSingleton<DexRepoRepository>(
        DexRepoRepository(dioConfig(), baseUrl: swapApi))

    //Service
    ..registerSingleton<BackUpWalletNetworkService>(
        BackUpWalletNetworkService(locator.get<BackUpWalletRepository>()))
    ..registerSingleton<NFTNetworkService>(
        NFTNetworkService(locator.get<NFTRepository>()))
    ..registerSingleton<TokenNetworkService>(TokenNetworkService(
        locator.get<TokenRepository>(),
        locator.get<TokenDescriptionRepository>(),
        locator.get<WalletTransactionsRepository>(),
        locator.get<TokenPricesHistoryRepository>()))
    ..registerSingleton<ImportWalletSerive>(
        ImportWalletSerive(locator.get<AddWalletRepository>()))
    ..registerSingleton<DexService>(
        DexService(locator.get<DexRepoRepository>()));
}

///This load .env  and other files file to be used through out the app
///make sure you await it to ensure it loads

loadEnvFiles() async {
  await dotenv.load(fileName: ".env");
}

///Add syntax sugar to access service faster
///Don,t make service available to avoid direct access
/// Always inject service
AppStater get appStarter => locator.get<AppStater>();

///Globally Accessible Service
ToastService get $toastService => locator.get<ToastService>();

NavigationService get $navigate => locator.get<NavigationService>();

AppLocalizations get $strings => locator.get<AppLocale>().strings;

AppStyle get $styles => AppStater.style;

Dio dioConfig() {
  Dio dio = locator<Dio>()
    ..interceptors.add(locator<PrettyDioLogger>())
    ..options.baseUrl = baseUrl
    ..options.receiveTimeout = const Duration(seconds: 60)
    ..options.connectTimeout = const Duration(seconds: 60)
    ..options.sendTimeout = const Duration(seconds: 60);

  return dio;
}
