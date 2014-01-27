###DylanTheDog

######From Africa to NYC...a Local to Global Animal Competition Platform

DylanTheDog was developed to create a platform for users to upload location tagged images, in order to share them with members of their community.  The app uses Ruby on Rails with a selection of Ruby Gems to access geotag metadata from images and to display uploaded photos by location as Markers on a Google Map.

[http://dylan-the-dog.herokuapp.com](http://dylan-the-dog.herokuapp.com/)

![image](https://dl.dropboxusercontent.com/u/8073874/d-tha-d.png)

1) Gemfile
```bash
gem 'paperclip', '~> 3.0'
gem 'aws-sdk', '~> 1.22.1'
gem 'exifr', '~> 1.1.3'
gem "gmaps4rails", "~> 2.0.3"
```

- EXIFR Gem
  - Removes all metadata from uploaded images, including GPS data if it exists
  - In Post Model:

```bash
  after_image_post_process :load_exif

  def load_exif
   exif_img = EXIFR::JPEG.new(image.queued_for_write[:custom].path)
    if !exif_img.gps.nil?
     self.latitude = exif_img.gps.latitude
     self.longitude = exif_img.gps.longitude
    end
  end
```

- gmaps4rails
  - Creates a Hash of custom map marker objects and plots them on the map by location
  - In Post Controller:

```bash
@hash = Gmaps4rails.build_markers(@posts) do |post, marker|
        marker.lat post.latitude.to_f
        marker.lng post.longitude.to_f
        marker.picture({
                  :url => post.image.url(:thumb),
                  :width   => 60,
                  :height  => 60
          }) 
```
  - In Post Index:

  ```bash
  handler = Gmaps.build('Google');
  handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
  markers = handler.addMarkers(<%=raw @hash.to_json %>);

  handler.bounds.extendWith(markers);
  handler.fitMapToBounds();
});

  google.maps.event.addListener(marker, 'mouseout', function(){
    infowindow.open(marker.get('map'), marker);
    });
```

- paperclip combined with aws-sdk 
 - paperclip used for image uploading, processing, and storing
 -aws-sdk used in Production of Heroku to Cloud Host images through Amazon S3


######My First Project Experience
Before coming to WDI I was self taught in HTML and CSS, but had little other programming knowledge.  I had the idea for DylanTheDog from my roommate who just moved back from South Africa.  His dog Dylan was born in South Africa and spent his first year of life traveling through many countries in Africa, playing with wild township dogs, and hiding in the back of a truck when passing through African borders.

The concept for the project presented many challenging aspects that I think will be very useful in future web development projects.  The most significant of these were:
- Database schema that stores Users, stores Posts/Images, and Joins Users with Posts in order to keep track of User & Post votes. 
- Custom coded voting mechanism not using any gems.
- Using EXIFR Gem to extract image metadata.
- Learning a significant amount about Google Maps API and using gmap4rails Gem to display custom Marker images by location on a map.


######Challenges Around the Way
The custom voting mechanism was a bit of a challenge and took a few iterations to do it in a RESTful way. Also, learning how to manipulate the Gems EXIFR and gmaps4rails was difficult because documentation is not thorough, in the case of EXIFR, and often written in a way that only a much more experienced developer could understand without a lot of StackOverflow'ing.  Also, Google Maps API is manipulated primarily through JavaScript, which we haven't learned yet at WDI.

######Future Plans for DylanTheDog Expansion
In the current version location mapping is only available for images uploaded with GPS metadata include.  Images without metadata are flagged, but there is not yet a method for the users to choose the location where they took the picture, and to update the image information in the database.  Also, functionality for the map Marker images is minimal at this point, and I would like to implement hover effects for images enlargement and displaying image information.
