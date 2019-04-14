import 'package:flutter/material.dart';

class KColors{

static  Color primary=Color.fromRGBO(35,39,42, 1);
static  Color secondary= Color.fromRGBO(44,47,51, 1);
static  Color third= Color.fromRGBO(255,255,255, 1);
static  Color fourth= Color.fromRGBO(153,170,181,1);
static  Color popout= Color.fromRGBO(114,137,218,1);
static  Color lightPopout= Color.fromRGBO(217,83,79,1);


static void setDark(){
  
primary=Color.fromRGBO(255,255,255, 1);
secondary= Color.fromRGBO(153,170,181,1);
third= Color.fromRGBO(35,39,42, 1);
fourth= Color.fromRGBO(44,47,51, 1);
}


static void setLight(){
  
primary=Color.fromRGBO(35,39,42, 1);
secondary= Color.fromRGBO(44,47,51, 1);
third= Color.fromRGBO(255,255,255, 1);
fourth= Color.fromRGBO(153,170,181,1);
}


}




