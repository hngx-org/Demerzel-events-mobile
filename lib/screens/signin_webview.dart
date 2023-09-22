import 'dart:developer';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hng_events_app/riverpod/auth_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SigninWebView extends StatefulWidget {
  const SigninWebView({super.key, required this.url});
  final String url;

  @override
  State<SigninWebView> createState() => _SigninWebViewState();
}

class _SigninWebViewState extends State<SigninWebView> {
  late final WebViewController controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // launchUrl(Uri.parse(widget.url));
    controller = WebViewController()
    ..loadRequest(Uri.parse(widget.url))
    ..setNavigationDelegate(
      NavigationDelegate(
        onPageFinished: (response) {
          log(response);
          // ref.read(authProvider.notifier).setUser(response);
        },
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return WebViewWidget(
          controller: controller,
        //   controller: WebViewController()
        // ..loadRequest(Uri.parse(widget.url))
        // ..setNavigationDelegate(
        //   NavigationDelegate(
        //     onNavigationRequest: (request) {
        //       launchUrl(Uri.parse(request.url));
        //       return NavigationDecision.prevent;
        //     },
        //     // onUrlChange: (change) {
        //     //   launchUrl(Uri.parse(change.url!));
        //     // },
            
        //     onPageFinished: (response) {
        //       log('webView response $response ');
        //       ref.read(authProvider.notifier).setUser(response);
        //     },
        //   )
        // )
        // .. setJavaScriptMode(JavaScriptMode.unrestricted)
        
        );

        // return Center();
      }
    );
  }
}

