import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Determine the screen size
    final screenSize = MediaQuery.of(context).size;

    // Define different image sizes based on screen size
    double imageSize;
    if (screenSize.width >= 1200) {
      // For web (wide screen)
      imageSize = 300.0;
    } else if (screenSize.width >= 600) {
      // For tablet (medium screen)
      imageSize = 260.0;
    } else {
      // For mobile (small screen)
      imageSize = 260.0;
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color.fromARGB(136, 224, 221, 221),
        appBar: AppBar(
          title: const Center(child: Text('Profile')),
          backgroundColor: Colors.blueGrey,
        ),
        body: Column(
          children: [
            const SizedBox(height: 10),
            ProfilePicture(imageSize: imageSize),
            const SizedBox(height: 10),
            const Name(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          elevation: 55.0,
          backgroundColor: Colors.blueGrey,
          onPressed: () {
            // _launchGitHub();
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WebViewWidget(
                      controller: WebViewController()
                        ..setJavaScriptMode(JavaScriptMode.unrestricted)
                        ..setBackgroundColor(const Color(0x00000000))
                        ..setNavigationDelegate(
                          NavigationDelegate(
                            onProgress: (int progress) {
                              // Update loading bar.
                            },
                            onPageStarted: (String url) {},
                            onPageFinished: (String url) {},
                            onWebResourceError: (WebResourceError error) {},
                            onNavigationRequest: (NavigationRequest request) {
                              if (request.url
                                  .startsWith('https://github.com/vics')) {
                                return NavigationDecision.navigate;
                              }
                              return NavigationDecision.navigate;
                            },
                          ),
                        )
                        ..loadRequest(Uri.parse('https://github.com/vicsam'))),
                ));
          },
          child: SvgPicture.asset(
            'assets/github.svg',
            height: 24,
          ),
          tooltip: 'Githb Link',
        ),
      ),
    );
  }
}

class Name extends StatelessWidget {
  const Name({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      'VICTOR OYEDE',
      style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
    );
  }
}

class ProfilePicture extends StatelessWidget {
  final double imageSize;

  const ProfilePicture({Key? key, required this.imageSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          width: imageSize,
          child: Image.asset('assets/dp.jpg'),
        ),
      ),
    );
  }
}
