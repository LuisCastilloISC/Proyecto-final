import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ResponsiveHelper {
  final double fontsize;
  final double paddingvertical;
  final double paddingHorizontal;
  final double heighBox;
  final double carouselHeight;
  final double carouselWidth;
  final double paddingContainer;
  final double containerHeigtWidth;
  final double generalWidth;
  final double generalHeight;
  
  ResponsiveHelper(BuildContext context)
      : generalWidth = MediaQuery.of(context).size.width,
        generalHeight = MediaQuery.of(context).size.height,
        fontsize = MediaQuery.of(context).size.width > 600 ? 90 : 70,
        paddingvertical = MediaQuery.of(context).size.width > 600 ? 150 : 100,
        paddingHorizontal = MediaQuery.of(context).size.width > 600 ? 50 : 30,
        heighBox = MediaQuery.of(context).size.height > 1920 ? 40 : 80,
        carouselHeight = MediaQuery.of(context).size.height > 1920 ? 300 : 250,
        carouselWidth = MediaQuery.of(context).size.width > 500 ? 500 : 480,
        paddingContainer = MediaQuery.of(context).size.height > 1920 ? 30 : 10,
        containerHeigtWidth = MediaQuery.of(context).size.width > 500 ? 50 : 30;

  double percentWidth(double percent) {
    // 0 to 1.0
    return generalWidth * percent;
  }

  double percentHeight(double percent) {
    // 0 to 1.0
    return generalHeight * percent;
  }

  double iconSize() {
    if (generalWidth <= 320) {
      return 20;
    } else if (generalWidth <= 480) {
      return 30;
    } else {
      return 60;
    }
  }

  double iconStarSize() {
    if (generalWidth <= 320) {
      return 14;
    } else if (generalWidth <= 480) {
      return 18;
    } else {
      return 60;
    }
  }

  double widthBox() {
    if (generalWidth <= 320) {
      return 30;
    } else if (generalWidth <= 480) {
      return 60;
    } else {
      return 90;
    }
  }

  double fracctionWidth() {
    if (generalWidth <= 320) {
      return 0.35;
    } else if (generalWidth <= 480) {
      return 0.55;
    } else {
      return 0.75;
    }
  }

  double fontTitleresponsive() {
    if (generalWidth <= 320) {
      return 16;
    } else if (generalWidth <= 480) {
      return 20;
    } else {
      return 32;
    }
  }

  double fontLocationresponsive() {
    if (generalWidth <= 320) {
      return 12;
    } else if (generalWidth <= 480) {
      return 18;
    } else {
      return 32;
    }
  }

  double fontRatingresponsive() {
    if (generalWidth <= 320) {
      return 12;
    } else if (generalWidth <= 480) {
      return 16;
    } else {
      return 32;
    }
  }

  double fontDeliveryResponsive() {
    if (generalWidth <= 320) {
      return 10;
    } else if (generalWidth <= 480) {
      return 16;
    } else {
      return 32;
    }
  }

  double fontNumberRatingsresponsive() {
    if (generalWidth <= 320) {
      return 12;
    } else if (generalWidth <= 480) {
      return 18;
    } else {
      return 32;
    }
  }

  double iconSizeWidthProfile() {
    if (generalWidth <= 320) {
      return 50;
    } else if (generalWidth <= 480) {
      return 50;
    } else {
      return 32;
    }
  }

  double iconSizeHeightProfile() {
    if (generalWidth <= 320) {
      return 30;
    } else if (generalWidth <= 480) {
      return 30;
    } else {
      return 32;
    }
  }

  double imageSizeProfile() {
    if (generalWidth <= 320) {
      return 70;
    } else if (generalWidth <= 480) {
      return 100;
    } else {
      return 300;
    }
  }

  double imageEditSizeProfile() {
    if (generalWidth <= 320) {
      return 120;
    } else if (generalWidth <= 480) {
      return 150;
    } else {
      return 300;
    }
  }

  double fontSizeProfile() {
    if (generalWidth <= 320) {
      return 16;
    } else if (generalWidth <= 480) {
      return 20;
    } else {
      return 32;
    }
  }

  double textHeightEditProfile() {
    if (generalWidth <= 320) {
      return 60;
    } else if (generalWidth <= 480) {
      return 80;
    } else {
      return 32;
    }
  }

  double textFontEditProfile() {
    if (generalWidth <= 320) {
      return 16;
    } else if (generalWidth <= 480) {
      return 18;
    } else {
      return 32;
    }
  }

  double textFontDistanceRestaurantProfile() {
    if (generalWidth <= 320) {
      return 13;
    } else if (generalWidth <= 480) {
      return 18;
    } else {
      return 32;
    }
  }

  double iconScaleRestaurantProfile() {
    if (generalWidth <= 320) {
      return 1.5;
    } else if (generalWidth <= 480) {
      return 0.85;
    } else {
      return 1;
    }
  }

  double restaurantPagePickUpSize() {
    if (generalWidth <= 320) {
      return 14;
    } else if (generalWidth <= 480) {
      return 18;
    } else {
      return 32;
    }
  }

  double restaurantPageTitleSize() {
    if (generalWidth <= 320) {
      return 24;
    } else if (generalWidth <= 480) {
      return 30;
    } else {
      return 32;
    }
  }

  double orderTitleSize() {
    if (generalWidth <= 320) {
      return 20;
    } else if (generalWidth <= 480) {
      return 26;
    } else {
      return 32;
    }
  }

  double orderLocationSize() {
    if (generalWidth <= 320) {
      return 14;
    } else if (generalWidth <= 480) {
      return 18;
    } else {
      return 32;
    }
  }

  double orderProductTitleSize() {
    if (generalWidth <= 320) {
      return 14;
    } else if (generalWidth <= 480) {
      return 18;
    } else {
      return 32;
    }
  }

  double orderDescriptionSize() {
    if (generalWidth <= 320) {
      return 12;
    } else if (generalWidth <= 480) {
      return 16;
    } else {
      return 32;
    }
  }

  double orderPriceSize() {
    if (generalWidth <= 320) {
      return 12;
    } else if (generalWidth <= 480) {
      return 16;
    } else {
      return 32;
    }
  }

  double checkoutTitleSize() {
    if (generalWidth <= 320) {
      return 12;
    } else if (generalWidth <= 480) {
      return 16;
    } else {
      return 32;
    }
  }

  double checkoutInsideSize() {
    if (generalWidth <= 320) {
      return 16;
    } else if (generalWidth <= 480) {
      return 16;
    } else {
      return 32;
    }
  }

  Widget backButton(BuildContext context, Color iconColor) {
    return Align(
      alignment: Alignment.topLeft,
      child: IconButton(
        padding: EdgeInsets.only(top: paddingContainer),
        icon: Icon(
          Icons.arrow_back,
          color: iconColor,
        ),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }
}
