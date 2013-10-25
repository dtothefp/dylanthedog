== README

###DylanTheDog

######From Africa to NYC...a Local to Global Animal Competition Platform

DylanTheDog was developed to create a platform for users to upload location tagged images, in order to share them with members of their community.  The app uses Ruby on Rails with a selection of Ruby Gems to access geotag metadata from images and to display uploaded photos by location as Markers on a Google Map.

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
  - In Post Contoller:

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

![image](./screenshots/todays_folder.png)

######Check out your development branch and make sure you are on the right branch

```bash
git branch development
git checkout development
git branch
```

![image](./screenshots/checkout.png)


######Move to your __OWN PERSONAL DIRECTORY__ and do the work
- Do NOT edit any files that are not in your personal directory
- Remember to save all your files
- Instructions for the assignment are [in the w01/d01 directory](https://github.com/ga-students/WDI_NYC_Array_Work/tree/master/w01/d01)

![image](./screenshots/own_directory.png)
![image](./screenshots/do_work.png)



######Check status and add files to the stage

```bash
git status
git add .
git status
```

![image](./screenshots/git_add.png)


######Commit changes and push to Github

```bash
git commit -m "Complete HW 01-01"
git push origin development
```

![image](./screenshots/git_commit_push.png)


######Merge changes in to master and push to Github

```bash
git checkout master
git branch
git merge development
git push origin master
```

![image](./screenshots/merge_master.png)



######Make ONE pull request

---

![image](./screenshots/pull_request_01.png)

---

![image](./screenshots/pull_request_02.png)

---

![image](./screenshots/pull_request_03.png)

---
###### Make your pull request
- Title your pull request with the week and day (for example `HW w01-d01`)
- You MUST inlucude comments on your successes and challenges

![image](./screenshots/pull_request_04.png)

---

You're DONE!
