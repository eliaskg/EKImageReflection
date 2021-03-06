/*
 * EKImageReflection.j
 * 
 * The MIT License
 * 
 * Copyright (c) 2009 Elias Klughammer
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 * 
 */

@implementation EKImageReflection : CPView
{
	CPView		_reflectionView;
	CPImageView	_targetImageView;
	int		_reflectionHeight;
	float		_alphaValue;
	DOMElement	_image;
}

- (id)initWithImageView:(CPImageView)anImageView
{
	self = [super initWithFrame:CGRectMake([anImageView frame].origin.x, 
						[anImageView frame].origin.y + [anImageView frame].size.height,
						[anImageView frame].size.width,
						[anImageView frame].size.height)];
	
	if(self) {
		_targetImageView = anImageView;
		_reflectionHeight = CGRectGetHeight([anImageView bounds]) / 3;
		_alphaValue = 0.5;
		
		_reflectionView = [[CPView alloc] initWithFrame:CGRectMake(0, 0, [self frame].size.width, [self frame].size.height)];
		
		_image = new Image();
		
		// Draws the reflection after image is loaded.
		_image.onload = function() {
			[self drawReflection];
		}
		
		// Creates the source for the reflection
		_image.src = [anImageView image]._image.src;
		
		[self addSubview:_reflectionView];
	}
	return self;
}

- (void)drawReflection
{	
	var imageHeight = _image.height;
	var imageWidth = _image.width;
	var DOMElement = _reflectionView._DOMElement;

	// Empties the view before adding the image or canvas
	while(DOMElement.hasChildNodes()) {
		DOMElement.removeChild(DOMElement.lastChild);
	}	
	
	// Use MS effects if is IE
	if (document.all && !window.opera) {
		var reflection = document.createElement("img");
		reflection.src = _image.src;
		reflection.style.width = imageWidth + "px";
		reflection.style.display = "block";
		reflection.style.height = imageHeight + "px";
		
		reflection.style.filter = "flipv progid:DXImageTransform.Microsoft.Alpha(opacity = " + (_alphaValue*100) + ", style = 1, finishOpacity = 0, startx = 0, starty = 0, finishx = 0, finishy = " + ((_reflectionHeight / imageHeight)*100) + ")";
		
		DOMElement.appendChild(reflection);
	}
	// Use canvas in modern browsers
	else {
		var canvas = document.createElement("canvas");
		
		if (canvas.getContext) {
			var context = canvas.getContext("2d");
        	
			canvas.style.height = _reflectionHeight + "px";
			canvas.style.width = imageWidth + "px";
			canvas.height = _reflectionHeight;
			canvas.width = imageWidth;
        	
			DOMElement.appendChild(canvas);
        	
			context.save();
        	
			context.translate(0, _image.height-1);
			context.scale(1, -1);
			context.drawImage(_image, 0, 0, imageWidth, _image.height);
        	
			context.restore();
        	
			context.globalCompositeOperation = "destination-out";
			var gradient = context.createLinearGradient(0, 0, 0, _reflectionHeight);
        	
			gradient.addColorStop(1, "rgba(255, 255, 255, 1.0)");
			gradient.addColorStop(0, "rgba(255, 255, 255, " + (1-_alphaValue) + ")");
        	
			context.fillStyle = gradient;
			context.rect(0, 0, imageWidth, _reflectionHeight*2);
			context.fill();
		}
	}
}

- (void)setReflectionHeight:(int)aValue
{
	_reflectionHeight = Math.floor(aValue);
	[self drawReflection];
}

- (int)reflectionHeight
{
	return _reflectionHeight;
}

- (void)setAlphaValue:(float)aValue
{
	_alphaValue = aValue;
	[self drawReflection];
}

- (float)alphaValue
{
	return _alphaValue;
}

@end
