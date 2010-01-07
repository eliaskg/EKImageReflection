EKImageReflection
==========

EKImageReflection is an extension for the [Cappuccino](http://www.cappuccino.org) framework.

With EKImageReflection you can extend a regular CPImageView for displaying a reflection on it's bottom.

An example can be seen [here](http://www.thisagree.com/EKImageReflection).

The class uses the canvas tag for drawing the reflection in modern browsers and will be using MS effects in IE soon.


## Installation

Simply import the file in your application's AppController or any other class:

	@import "EKImageReflection.j"


## Usage

A reflection can be added to the view after adding the target CPImageView:

	var reflection = [[EKImageReflection alloc] initWithImageView:myImage];
	[contentView addSubview:reflection];

You can also manipulate the reflection's height with

	[reflection setReflectionHeight:200];
