import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class XODecoration {
  final List decoratedItems = [
    Positioned(
      right: 130,
      top: 20,
      child: SvgPicture.asset('assets/images/small_x.svg'),
    ),
    Positioned(
      right: 100,
      top: 50,
      child: SvgPicture.asset('assets/images/small_o.svg'),
    ),
    Positioned(
      left: 10,
      top: 60,
      child: SvgPicture.asset('assets/images/super_big_x.svg'),
    ),
    Positioned(
      left: 20,
      top: 200,
      child: SvgPicture.asset('assets/images/small_o.svg'),
    ),
    Positioned(
      left: 50,
      top: 170,
      child: SvgPicture.asset('assets/images/small_x.svg'),
    ),
    Positioned(
      left: 20,
      bottom: 200,
      child: SvgPicture.asset('assets/images/small_o.svg'),
    ),
    Positioned(
      left: 50,
      bottom: 170,
      child: SvgPicture.asset('assets/images/small_x.svg'),
    ),
    Positioned(
      right: 20,
      top: 220,
      child: SvgPicture.asset('assets/images/small_o.svg'),
    ),
    Positioned(
      right: 50,
      top: 250,
      child: SvgPicture.asset('assets/images/small_x.svg'),
    ),
    Positioned(
      right: 20,
      bottom: 230,
      child: SvgPicture.asset('assets/images/small_o.svg'),
    ),
    Positioned(
      right: 50,
      bottom: 200,
      child: SvgPicture.asset('assets/images/small_x.svg'),
    ),
    Positioned(
      right: 20,
      bottom: 60,
      child: SvgPicture.asset('assets/images/super_big_o.svg'),
    ),
  ];
  final List gameDecoratedItems = [
    Positioned(
      right: 130,
      top: 20,
      child: SvgPicture.asset('assets/images/small_x.svg'),
    ),
    Positioned(
      right: 100,
      top: 50,
      child: SvgPicture.asset('assets/images/small_o.svg'),
    ),
    Positioned(
      left: 10,
      top: 60,
      child: SvgPicture.asset('assets/images/super_big_x.svg'),
    ),
    Positioned(
      left: -5,
      top: 170,
      child: SvgPicture.asset('assets/images/small_x.svg'),
    ),
    Positioned(
      left: 20,
      bottom: 180,
      child: SvgPicture.asset('assets/images/small_o.svg'),
    ),
    Positioned(
      left: 50,
      bottom: 150,
      child: SvgPicture.asset('assets/images/small_x.svg'),
    ),
    Positioned(
      right: -10,
      top: 210,
      child: SvgPicture.asset('assets/images/small_o.svg'),
    ),
    Positioned(
      right: 50,
      top: 250,
      child: SvgPicture.asset('assets/images/small_x.svg'),
    ),
    Positioned(
      right: 20,
      bottom: 230,
      child: SvgPicture.asset('assets/images/small_o.svg'),
    ),
    Positioned(
      right: 50,
      bottom: 200,
      child: SvgPicture.asset('assets/images/small_x.svg'),
    ),
    Positioned(
      right: 100,
      bottom: -50,
      child: SvgPicture.asset('assets/images/super_big_o.svg'),
    ),
  ];
}

// /803 * deviceHeight,
