// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:taskitly/UI/widgets/apptexts.dart';
// import 'package:taskitly/utils/widget_extensions.dart';

// import '../../../../constants/reuseables.dart';

// class ComingSoonScreen extends StatelessWidget {
//   const ComingSoonScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: 16.0.padA,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             50.0.sbH,
//             Container(
//               height: 350.0,
//                 decoration: const BoxDecoration(
//                     image: DecorationImage(
//                         image: AssetImage(AppImages.cominSoonImage),
//                         fit: BoxFit.contain))),
//             30.0.sbH,
//             const AppText(
//               AppStrings.comingSoon,
//               color: Color(0xff969696),
//               weight: FontWeight.w400,
//               size: 15.0,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:taskitly/UI/widgets/apptexts.dart';
import 'package:taskitly/utils/widget_extensions.dart';

import '../../../../constants/reuseables.dart';

class ComingSoonScreen extends StatelessWidget {
  const ComingSoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea( 
        child: LayoutBuilder( 
          builder: (context, constraints) {
            final double screenWidth = constraints.maxWidth;
            final double imageHeight = screenWidth * 0.7; 

            return Padding(
              padding: EdgeInsets.symmetric(  
                horizontal: screenWidth * 0.05, 
                vertical: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   50.0.sbH, // Use SizedBox for consistent spacing
                  Container(
                    height: imageHeight,  // Dynamic image height
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(AppImages.cominSoonImage),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  30.0.sbH, // Use SizedBox for consistent spacing
                  const AppText(
                    AppStrings.comingSoon,
                    color: Color(0xff969696),
                    weight: FontWeight.w400,
                    size: 15.0,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
