import 'package:sportRex/core/commonLibs/common_libs.dart';

const host = 'http://ec2-16-171-236-22.eu-north-1.compute.amazonaws.com';

const swapApi = 'https://api.1inch.dev/swap/v5.2';

String convertToDollar(
    {required double amount, required int decimal, required double usdValue}) {
  double calc = amount / pow(10, decimal);
  return (calc * usdValue).toStringAsFixed(2);
}

convertToCoin({
  required double amount,
  required int decimal,
}) {
  return amount / pow(10, decimal);
}

class DummnyNFTDetails {
  final String name;

  final String title;
  final String description;
  final String priceInUsd;
  final String priceInChain;

  final String contactAddress;
  final String tokenID;
  final String blockChain;
  final String image;

  DummnyNFTDetails(
      this.title,
      this.description,
      this.priceInUsd,
      this.priceInChain,
      this.contactAddress,
      this.tokenID,
      this.blockChain,
      this.name,
      this.image);
}

class DummnyNFTCollections {
  final String name;
  final String title1;
  final String subtitle1;
  final String title2;
  final String subtitle2;
  final String description;
  final String priceInChain;
  final List<DummnyNFTDetails> dummyNftDetails;

  DummnyNFTCollections(
      this.name,
      this.title1,
      this.subtitle1,
      this.title2,
      this.subtitle2,
      this.description,
      this.priceInChain,
      this.dummyNftDetails);
}

DummnyNFTDetails homeNFT = DummnyNFTDetails(
    "Bridge Grafiiti #455678",
    "Lorem ipsum dolor sit amet, consectetur adi pis cing elit, sed do eiusmod tempoLorem ipsum dolor sit amet, consectetur adi pis cing elit, sed do eiusmod tempo Lorem ipsum dolor sit amet, consectetur adi pis cing elit, ",
    "USD 30,456.00",
    "1.353 ETH",
    "FfmbHfnpaZjKFvyi1okTjJJusN455paPHJusN455paPH",
    "FfmbHfnpaZjKFvyi1okTjJJusN455paPHJusN455paPH",
    "Ethereum",
    "Pointer",
    AppAssets.nftImage);

DummnyNFTCollections homeNFTCollections = DummnyNFTCollections(
    "Painter",
    "DC comics",
    "24 Items",
    "Total value",
    "22.467 ETH",
    "Lorem ipsum dolor sit amet, consectetur adi pis cing elit, sed do eiusmod tempoLorem ipsum dolor sit amet, consectetur adi pis cing elit, sed do eiusmod tempo Lorem ipsum dolor sit amet, consectetur adi pis cing elit, ",
    "2 Collectibles",
    List.generate(
        12,
        (index) => DummnyNFTDetails(
              "Pointer",
              "Lorem ipsum dolor sit amet, consectetur adi pis cing elit, sed do eiusmod tempoLorem ipsum dolor sit amet, consectetur adi pis cing elit, sed do eiusmod tempo Lorem ipsum dolor sit amet, consectetur adi pis cing elit, ",
              "USD 30,456.00",
              "1.353 ETH",
              "FfmbHfnpaZjKFvyi1okTjJJusN455paPHJusN455paPH",
              "FfmbHfnpaZjKFvyi1okTjJJusN455paPHJusN455paPH",
              "Ethereum",
              "Bridge Grafiiti #455678",
              AppAssets.nftImage,
            )));

const dummyText =
    "Lorem ipsum dolor sit amet, consectetur adi pis cing elit, sed do eiusmod tempoLorem ipsum dolor sit amet, consectetur adi pis cing elit, sed do eiusmod tempo Lorem ipsum dolor sit amet, consectetur adi pis cing elit, ";

class DummyTransactionHistory {
  final String title;
  final String? subtitle;
  final String amount;
  final String quantity;
  const DummyTransactionHistory({
    required this.title,
    this.subtitle,
    required this.amount,
    required this.quantity,
  });
}

List<DummyTransactionHistory> dummyTransactionHistory = List.generate(
    6,
    (index) => const DummyTransactionHistory(
          title: "The Pink Cat",
          amount: "\$100,00",
          subtitle: "6 Collectibles",
          quantity: "0.00046532",
        ));
