import 'package:flutter/material.dart';
import 'package:ourhands/views/home/widget/custom_cared_search_result.dart';
import 'package:ourhands/widgets/app_text/AppText.dart';
import 'package:ourhands/widgets/appar/custom_app_padding.dart';

class SearchResultPage extends StatelessWidget {
  const SearchResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaddingApp(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Center(
                  child: CustomText(
                text: 'نتائج البحث',
                fontSize: 26,
                fontWeight: FontWeight.w400,
                textColor: Colors.green,
              )),
              SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    5,
                    (index) => const Padding(
                      padding: EdgeInsets.only(bottom: 9),
                      child: SizedBox(
                        child: CustomCaredSearchResult(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
