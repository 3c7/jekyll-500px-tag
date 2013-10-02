Jekyll 500px Tag
================
Insert 500px.com pictures via liquid tags. This plugin is based on [macjasp's](https://github.com/macjasp) flickr plugin and [henninghoyer's](https://github.com/henninghoyer) 500px Image Set plugin.   

##Changes
-added some responsive features
-changed the exif info under the pictures

##Usage
{% 500px photoid %}   
Preview at [3c7.me](http://3c7.me).  

##Installation
Copy the ruby file under _plugin into your plugins/ directory. The sass file is an example of how to use the classes.
You have to set   
Fhp_Tag:  
  consumer_key:   
in your _config-file. You can obtain a consumer key via 500px.com settings.
You can use the stylesheet given or create your own using the given classes.
