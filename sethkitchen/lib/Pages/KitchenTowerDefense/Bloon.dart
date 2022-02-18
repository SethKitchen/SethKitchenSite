/*  Bloon.dart
 	Seth Kitchen
	Class used to generate Bloon objects in the game that the Tower objects can shoot down.
*/

import 'package:flutter/material.dart';

enum BloonType {
  red,
  blue,
  green,
  yellow,
  pink,
  black,
  white,
  camo,
  lead,
  zebra,
  rainbow,
  ceramic,
  moab,
  bfb,
  zomg,
}

abstract class Bloon {
  //different images for the different Bloon types
  //getImage() returns the respective image of the Bloon
  Widget getImage();

  double x; //x pos of the Bloon (top left)
  double y; //y pos of the Bloon (top left)

  //Bloons stats
  BloonType bloonType;
  double health;
  double moneyValue;
  double speed;
  double width;
  double height;

  bool isRemoved; //determines if the Bloon is removed
  bool isFrozen;
  bool isGlued;

  bool explosionImmunity;
  bool freezeImmunity;
  bool sharpImmunity;
  bool glueImmunity;
  bool detectionImmunity;

  //delay counter and tick to determine when Bloon loses freeze status effect
  double freezeCounter;
  final double freezeTick = 300;

  //delay counter and tick to determine when Bloon loses glued status effect
  double glueCounter;
  final double glueTick = 700;

  double
      nodesPassed; //used to determine how much intersections Bloon has passed on the track
  //(for move() function)

  //CONSTUCTOR
  Bloon(
      {required this.bloonType,
      required this.x,
      required this.y,
      required this.nodesPassed})
      : isRemoved = false,
        isFrozen = false,
        isGlued = false,
        explosionImmunity = false,
        freezeImmunity = false,
        sharpImmunity = false,
        glueImmunity = false,
        detectionImmunity = false,
        freezeCounter = 0,
        glueCounter = 0,
        health = 0,
        height = 0,
        width = 0,
        moneyValue = 0,
        speed = 2;

  Widget getBaseImage(double width, double height, Color color) {
    return Container(width: width, height: height, color: color);
  }

  //breakIntoBloons() adds more Bloon objects as certain Bloon types
  //break up into weaker Bloon(s) when popped
  List<Bloon> breakIntoBloons();

  void playPopNoise() {
    if (isRemoved == true) {
      // pop.play();
    } else if (isFrozen == true) {
      // frozenBloonHit.play();
    }
  }

  //move() moves the Bloon across the track with the Bloon direction
  //determined from how many intersections it passed (checked with Rect objects)
  void move() {
    double movementSpeed = speed;
    //Bloon doesn't move if frozen
    if (isFrozen == true) {
      movementSpeed = 0;
    }
    //Bloon moves at half speed if glued
    if (isGlued == true) {
      movementSpeed = (movementSpeed / 2).truncate() * 1.0;
    }

    if (nodesPassed == 0) {
      y += movementSpeed;
      if (getRect().overlaps(const Rect.fromLTWH(683, 175, 5, 5))) {
        nodesPassed += 1;
      }
    } else if (nodesPassed == 1) {
      x -= movementSpeed;
      if (getRect().overlaps(const Rect.fromLTWH(560, 175, 5, 5))) {
        nodesPassed += 1;
      }
    } else if (nodesPassed == 2) {
      y -= movementSpeed;
      if (getRect().overlaps(const Rect.fromLTWH(562, 80, 5, 5))) {
        nodesPassed += 1;
      }
    } else if (nodesPassed == 3) {
      x -= movementSpeed;
      if (getRect().overlaps(const Rect.fromLTWH(70, 94, 5, 5))) {
        nodesPassed += 1;
      }
    } else if (nodesPassed == 4) {
      y += movementSpeed;
      if (getRect().overlaps(const Rect.fromLTWH(81, 285, 5, 5))) {
        nodesPassed += 1;
      }
    } else if (nodesPassed == 5) {
      x += movementSpeed;
      if (getRect().overlaps(const Rect.fromLTWH(205, 285, 5, 5))) {
        nodesPassed += 1;
      }
    } else if (nodesPassed == 6) {
      y -= movementSpeed;
      if (getRect().overlaps(const Rect.fromLTWH(205, 190, 5, 5))) {
        nodesPassed += 1;
      }
    } else if (nodesPassed == 7) {
      x += movementSpeed;
      if (getRect().overlaps(const Rect.fromLTWH(290, 193, 5, 5))) {
        nodesPassed += 1;
      }
    } else if (nodesPassed == 8) {
      y += movementSpeed;
      if (getRect().overlaps(const Rect.fromLTWH(290, 295, 5, 5))) {
        nodesPassed += 1;
      }
    } else if (nodesPassed == 9) {
      x += movementSpeed;
      if (getRect().overlaps(const Rect.fromLTWH(390, 295, 5, 5))) {
        nodesPassed += 1;
      }
    } else if (nodesPassed == 10) {
      y -= movementSpeed;
      if (getRect().overlaps(const Rect.fromLTWH(380, 194, 5, 5))) {
        nodesPassed += 1;
      }
    } else if (nodesPassed == 11) {
      x += movementSpeed;
      if (getRect().overlaps(const Rect.fromLTWH(480, 194, 5, 5))) {
        nodesPassed += 1;
      }
    } else if (nodesPassed == 12) {
      y += movementSpeed;
      if (getRect().overlaps(const Rect.fromLTWH(470, 385, 5, 5))) {
        nodesPassed += 1;
      }
    } else if (nodesPassed == 13) {
      x += movementSpeed;
      if (getRect().overlaps(const Rect.fromLTWH(595, 385, 5, 5))) {
        nodesPassed += 1;
      }
    } else if (nodesPassed == 14) {
      y -= movementSpeed;
      if (getRect().overlaps(const Rect.fromLTWH(595, 260, 5, 5))) {
        nodesPassed += 1;
      }
    } else if (nodesPassed == 15) {
      x += movementSpeed;
      if (getRect().overlaps(const Rect.fromLTWH(710, 260, 5, 5))) {
        nodesPassed += 1;
      }
    } else if (nodesPassed == 16) {
      y += movementSpeed;
      if (getRect().overlaps(const Rect.fromLTWH(710, 465, 5, 5))) {
        nodesPassed += 1;
      }
    } else if (nodesPassed == 17) {
      x -= movementSpeed;
      if (getRect().overlaps(const Rect.fromLTWH(340, 465, 5, 5))) {
        nodesPassed += 1;
      }
    } else if (nodesPassed == 18) {
      y -= movementSpeed;
      if (getRect().overlaps(const Rect.fromLTWH(352, 365, 5, 5))) {
        nodesPassed += 1;
      }
    } else if (nodesPassed == 19) {
      x -= movementSpeed;
    }
  }

  //checkStatusEffects() increases the respective status counters
  //if the Bloon is afflicted with a status effect and determines
  //when to remove it (when the tick is reached)
  void checkStatusEffects() {
    if (isFrozen == true) {
      freezeCounter++;
      if (freezeCounter == freezeTick) {
        freezeCounter = 0;
        isFrozen = false;
      }
    }
    if (isGlued == true) {
      glueCounter++;
      if (glueCounter == glueTick) {
        glueCounter = 0;
        isGlued = false;
      }
    }
  }

  //paint() paints the Bloon on the screen
  /*void paint(Graphics2D g2) {
    g2.drawImage(getImage(), (double)(x), (double)(y), null);
    if (isFrozen == true) {
      g2.drawImage(freezeImage, (double)(x), (double)(y), null);
    }
    else if (isGlued == true) {
      g2.drawImage(gluedImage, (double)(x), (double)(y), null);
    }
  }*/

  //getRect() gets the Rect of the Bloon
  Rect getRect() {
    return Rect.fromLTWH(x, y, width, height);
  }
}
