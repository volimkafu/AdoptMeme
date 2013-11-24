# AdoptMeme Roadmap

AdoptMe.me is intended to be a platform for cat image macro creation and
sharing.  On AdoptMeme, you're making memes and doing good at the same time.
All of the animals featured on AdoptMeme are in need of adoption, so creatinga
nd sharing funny cat pictures you are also helping animals in need. 

## Completed features:
- Petfinder.com integration
    - configure `figaro` to securely store API keys 
    - fetch images from their service; populate `Image` table with image
      location metadata
    - Store pet info (name, breed, age, etc) into `Pet` models. We may want to
      use some of this info on a "pet show" page

- S3 integration (or other third-party image hosting solution.)
    - Write a `Saveable` module following the template pattern for saving images and
      captioned images to Amazon S3. My `ActiveRecord::Base` subclasses
      extending the `Saveable` module only need specify their own AWS resource
      names.
    - Environment-specific bucket configuration prevents local development from
      clobbering the contents of the AWS bucket used in production.

- Image captioning
  - Client-side text preview using HTML5 canvas and jQuery.
  - Server-side image manipulation with `RMagick`/`imagemagick`

- Shortlinks
  - displayed on captioned images (where watermark normally goes.)
  - Short link landing page provides pet information and a link to pet's petfinder page.
  - A simple rails controller catches type-in traffic requests to
    `AdoptMe.me/number` and forward them to `AdoptMe.me/#number`; someone might
    do this after seeing a captioned image shared on the web.  Backbone.js
    router is configured to use pushState and hide the ugly url hash-marks on
    supported browsers.

## MVP features to do:

- Improve Image captioning
    - Next write logic to adjust font size and positioning depending on message length.
    - Since text in images isn't searchable/analyzable, perhaps also store caption content
      in `Caption` models.  

- Social media sharing buttons

## Feature wishlist

- How to better keep my info in sync with petfinder?  Don't really want to keep
  featuring cats that are no longer available for adoption.
- More attractive/responsive css. Media queries.
- Geolocation: only show visitors cats local to them on the home page.
- Fancy editing. Flex those jawascript muscles.
- More complex user model, and social/gamification features.  (Meh. Seems like everyone
  does this.)
- `SimpleCV` face detection and image cropping, especially for thumbnails on the home page. 
- Caching?  Read about redis.
- Endless scrolling on index page.
- ~~User email notifications when cats they promote are adopted.~~ This is
  impossible because the Petfinder API only provides one status for
  adopted/removed  No way to tell if animal was placed or killed. 
