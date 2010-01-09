EKImageReflection
==========

EKImageReflection is an extension for the [Cappuccino](http://www.cappuccino.org) framework.

With EKImageReflection you can extend a regular CPImageView for displaying a reflection on it's bottom.

A demo can be seen [here](http://www.thisagree.com/EKImageReflection).

The class uses the canvas tag for drawing the reflection in modern browsers and uses MS effects in IE.

It works in Internet Explorer, Mozilla Firefox, Safari, Google Chrome and Opera.

This extension is inspired by Ken's [Reflection.js](http://cow.neondragon.net/stuff/reflection/).


## Installation

Simply import the file in your application's AppController or any other class:

	@import "EKImageReflection.j"


## Usage

A reflection can be added to the view after adding the target CPImageView:

	var reflection = [[EKImageReflection alloc] initWithImageView:myImage];
	[contentView addSubview:reflection];

Manipulate the reflection's height with

	[reflection setReflectionHeight:200];
	
Edit the reflection's opacity with

	[reflection setAlphaValue:0.5];
