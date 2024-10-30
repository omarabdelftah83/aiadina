import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportSection extends StatefulWidget {
  final String supportNumber;

  const SupportSection({
    Key? key,
    this.supportNumber = '+20 1021441861',
  }) : super(key: key);

  @override
  _SupportSectionState createState() => _SupportSectionState();
}

class _SupportSectionState extends State<SupportSection> with SingleTickerProviderStateMixin {
  bool _isTapped = false;
  bool _isVisible = false;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _slideAnimation = Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0))
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _isVisible = true;
      });
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> whatsapp({required String contact, String text = ''}) async {
  final String formattedContact = contact.startsWith('+') ? contact : '+2$contact';
  final String androidUrl = "whatsapp://send?phone=$formattedContact&text=${Uri.encodeComponent(text)}";
  final String iosUrl = "https://wa.me/$formattedContact?text=${Uri.encodeComponent(text)}";
  final String webUrl = "https://api.whatsapp.com/send/?phone=$formattedContact&text=${Uri.encodeComponent(text)}";

  try {
    String url;
    if (Platform.isIOS) {
      url = iosUrl;
    } else if (Platform.isAndroid) {
      url = androidUrl;
    } else {
      url = webUrl;
    }

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      await launch(webUrl);
    }
  } catch (e) {
    print('Error launching WhatsApp URL: $e');
    await launch(webUrl);
  }
}


  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: AnimatedOpacity(
        opacity: _isVisible ? 1.0 : 0.0,
        duration: Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: Duration(milliseconds: 1200),
              curve: Curves.easeInOut,
              child: Text(
                'الدعم الفني',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.green[700],
                ),
              ),
            ),
            8.heightBox,
            GestureDetector(
              onTapDown: (_) => setState(() => _isTapped = true),
              onTapUp: (_) => setState(() => _isTapped = false),
              onTap: () {
                whatsapp(contact: widget.supportNumber, text: 'مرحباً، أحتاج إلى دعم فني.');
              },
              child: AnimatedScale(
                scale: _isTapped ? 0.9 : 1.0,
                duration: Duration(milliseconds: 150),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 10.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: _isTapped ? Colors.blue.shade50 : Colors.grey.shade100,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.shade300,
                        blurRadius: 10,
                        offset: Offset(2, 5),
                      ),
                    ],
                  ),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                      children: [
                        AnimatedSwitcher(
                          duration: Duration(milliseconds: 300),
                          child: Icon(
                            Icons.support_agent,
                            key: ValueKey(_isTapped),
                            color: _isTapped ? Colors.blue : Colors.green,
                            size: 30,
                          ),
                        ),
                        30.widthBox,
                        Text(
                          widget.supportNumber,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.blue.shade700,
                            fontWeight: FontWeight.w500,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            15.heightBox,
            AnimatedOpacity(
              opacity: _isVisible ? 1.0 : 0.0,
              duration: Duration(milliseconds: 1500),
              curve: Curves.easeInOut,
              child: Text(
                'تواصل معنا عبر الواتساب لأي استفسارات أو دعم.',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey.shade700,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
