import 'package:sportRex/core/commonLibs/common_libs.dart';
import 'package:sportRex/shared/app_indicator.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AppWebViewScreen extends StatefulWidget {
  final String? title;
  final String? url;

  const AppWebViewScreen({
    Key? key,
    this.url,
    this.title,
  }) : super(key: key);
  // WebViewScreen MaterialPage Helper
  static MaterialPage page() {
    return const MaterialPage(
        name: "Sportrex", key: ValueKey("Sportrex"), child: AppWebViewScreen());
  }

  @override
  WebViewScreenState createState() => WebViewScreenState();
}

class WebViewScreenState extends State<AppWebViewScreen> {
  bool isLoading = true;
  final _key = UniqueKey();

  @override
  void initState() {
    inititalise();
    super.initState();
    // Enable hybrid composition.
  }

  final WebViewController _myController = WebViewController();
  inititalise() {
    _myController
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setUserAgent(widget.title)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (index) => const AppLoadingIndicator(),
          onPageFinished: (initialUrl) {
            setState(() {
              isLoading = false;
            });
          },
          onPageStarted: (String url) {},
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url!));
  }

  @override
  Widget build(BuildContext context) {
    // static MaterialPage page(){

    return Skeleton(
      isBusy: false,
      backgroundColor: $styles.colors.primary,
      appBar: BaseAppBar(
        backBtnColor: $styles.colors.greyMedium,
        showLeading: true,
        textColor: $styles.colors.white,
        centerTitle: widget.title,
      ),
      body: Stack(
        children: [
          WebViewWidget(
            key: _key,
            controller: _myController,
          ),
          isLoading
              ? const Center(
                  child: AppLoadingIndicator(),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}
