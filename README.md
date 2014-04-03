#Cherdak: Web Performance
![Cherdak](logo.jpg)

##Client side

###Caching
- [jsCache](https://github.com/mortzdk/jsCache)

####Memoize
- [memoize.js](https://github.com/addyosmani/memoize.js)
- [underscore#memoize](http://underscorejs.org/#memoize)
- [lodash#memoize](http://lodash.com/docs#memoize)

####Web Storage
- [basket.js](https://github.com/addyosmani/basket.js) - caching scripts in local 
storage.

###Render

####CSS
- [Veinjs](https://github.com/israelidanny/veinjs) - inject css into dynamic stylesheet.
- [grunt-uncss](https://github.com/addyosmani/grunt-uncss).

###Images


**[Modern image formats comparison article](http://calendar.perfplanet.com/2013/browser-specific-image-formats/)** 

####Font icons
- [Font Awesome](http://fortawesome.github.io/Font-Awesome/) - set of icons combined
within one font.  
**Custom font builds generators:**
- [icnfnt](http://icnfnt.com/#/)
- [fontello](http://fontello.com/)
- [icomoon](http://icomoon.io/app/#/select)

####Convertion tools
- [Image Magick](http://www.imagemagick.org/)
- [Webp codecs](https://developers.google.com/speed/webp/download)
- [jxrlib](https://jxrlib.codeplex.com/) - converts bpm to jpegxr.

####Grunt plugins
- [grunt-imagemin](https://github.com/gruntjs/grunt-contrib-imagemin) - 
Minify images using OptiPNG, pngquant, jpegtran and gifsicle.
- [grunt-imageoptim](https://github.com/JamieMason/grunt-imageoptim) - 
automates batch optimisation of images with ImageOptim, ImageAlpha and JPEGmini for Mac.
- [grunt-imagine](https://github.com/asciidisco/grunt-imagine) - uses lots of tools
for optimization of png, gif, jpeg.  
- [grunt-spritesmith](https://github.com/Ensighten/grunt-spritesmith) - generates sprite and appropriate
CSS or preprocessor code.
- [grunt-webp](https://github.com/somerandomdude/grunt-webp) - wrapper around webp
codec.
- [grunt-jpegxr](https://github.com/msemenistyi/grunt-jpegxr) - plain wrapper
around ImageMagick emphasizing on jpeg-xr convertion.

####Gulp plugins
- [gulp-webp](https://github.com/sindresorhus/gulp-webp) - wrapper around webp
codec.
- [gulp-spritesmith](https://github.com/twolfson/gulp.spritesmith) - gulp analogue of 
grunt-spritesmith.
- [gulp-image](https://github.com/1000ch/gulp-image) - optimize png, jpg, gif.
- [gulp-imagemin](https://github.com/sindresorhus/gulp-imagemin) - gulp analogue of 
grunt-imagemin.

#### Server configs and middleware
- [webp-detect](https://github.com/igrigorik/webp-detect) - configs for different
servers for confitional webp serving.
- [connect-image-optimus](https://github.com/msemenistyi/connect-image-optimus) - 
conditionally serves either webp or jpegxr.
- [koa-image-optimus](https://github.com/msemenistyi/koa-image-optimus) - analogue 
of connect-image-optimus for koa. Work in progress.

### Perceived performance

####Sleeping devices

Method of taking advantage of knowledge about page visibility in order to reduce
load for hidden pages.

**Page Visibility API**:
- [W3C draft](http://www.w3.org/TR/2011/WD-page-visibility-20110602/#pv-page-preview)
- [visibilityjs](https://github.com/ai/visibilityjs) - A great wrapper which 
also provides several useful functions.  
- [HTML5Rocks article](http://www.html5rocks.com/en/tutorials/pagevisibility/intro/) - 
describes basic use cases and pitfalls.  

**Actually sleeping devices**:
- [hypnos](https://github.com/msemenistyi/hypnos) - Module for determining if device
is actually sleeping.  