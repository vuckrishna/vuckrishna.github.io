/* eslint-disable no-unused-vars */
// import React from 'react'

import Posts from "./Posts";
import SharePost from "./SharePost";
import image1 from "/public/post-images/1.jpg";
import image2 from "/public/post-images/2.jpg";
import image3 from "/public/post-images/3.jpg";
import image4 from "/public/post-images/4.jpg";
import image5 from "/public/post-images/5.jpg";
import image6 from "/public/post-images/6.jpg";
import image7 from "/public/post-images/7.jpg";
import image8 from "/public/post-images/8.jpg";
import friend1 from "/public/friends/friend-1.jpg";
import friend2 from "/public/friends/friend-2.jpg";
import friend3 from "/public/friends/friend-3.jpg";
import friend4 from "/public/friends/friend-4.jpg";
import friend5 from "/public/friends/friend-5.jpg";

const Feed = () => {
  return (
    <div className="flex flex-[2] flex-col items-center justify-center gap-3 px-3">
      <SharePost />
      <Posts image={image6} friend={friend1} name="Jason" />
      <Posts image={image2} friend={friend2} name="Emily"/>
      <Posts image={image3} friend={friend3} name="Gary"/>
      <Posts image={image4} friend={friend4} name="Susan"/>
      <Posts image={image5} friend={friend5} name="Rose"/>
      <Posts image={image1} friend={friend1} name="Jason"/>
      <Posts image={image7} friend={friend3} name="Gary"/>
      <Posts image={image8} friend={friend2} name="Emily"/>
    </div>
  );
};

export default Feed;
