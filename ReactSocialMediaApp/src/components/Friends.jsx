// import React from 'react'
import friend1 from "/friends/friend-1.jpg";
import friend2 from "/friends/friend-2.jpg";
import friend3 from "/friends/friend-3.jpg";
import friend4 from "/friends/friend-4.jpg";
import friend5 from "/friends/friend-5.jpg";

const Friends = () => {
  const friendsList = [
    { img: friend1, name: "Jason" },
    { img: friend2, name: "Emily" },
    { img: friend3, name: "Gary" },
    { img: friend4, name: "Susan" },
    { img: friend5, name: "Rose" },
  ];
  return (
    <div className="sticky hidden xl:flex items-start justify-start flex-1">
      <div
        className="sticky top-10 flex flex-col w-full gap-5 rounded-3xl 
      border bg-white p-5 text-center md:w-5/6 dark:border-gray-700 dark:bg-black
      dark:text-white"
      >
        <h3 className="text-4xl font-semibold">Friends</h3>
        <ul className="flex w-full flex-col gap-5">
          {friendsList.map((friend, index) => (
            <li
              key={index}
              className="flex cursor-pointer flex-wrap items-center justify-between 
              gap-5 rounded-3xl bg-gray-100 p-3 transition-all duration-300 
              hover:bg-gray-200 dark:bg-gray-900 dark:hover:bg-gray-800"
            >
              <div className="flex items-center gap-5">
                <img
                  src={friend.img}
                  alt=""
                  className="w-14 rounded-full md:w-16"
                />
                <span className="text-lg font-semibold">{friend.name}</span>
              </div>
              <button className="rounded-3xl bg-blue-500 p-2 text-white transition-all duration-300 hover:bg-blue-400">
                Message
              </button>
            </li>
          ))}
        </ul>
      </div>
    </div>
  );
};

export default Friends;
