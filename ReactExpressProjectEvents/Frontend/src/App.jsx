import axios from "axios";
import { useState, useEffect } from "react";

function App() {
  const [array, setArray] = useState([]);
  const [array2, setArray2] = useState([]);

  const fetchData = async () => {
    const response = await axios.get("http://localhost:8080");
    setArray(response.data.blogPost);
    // setArray2(response.data.latestPost);
  };
  const fetchData2 = async () => {
    const response = await axios.get("http://localhost:8080");
    // setArray(response.data.blogPost);
    setArray2(response.data.latestPost);
  };

  useEffect(() => {
    fetchData();
    fetchData2();
  }, []); // ul space-y-3

  return (
    <div className="min-h-screen w-full bg-yellow-100 flex p-5 flex-col gap-5">
      <h1 className="text-4xl font-bold text-gray-800 text-center">
        Technology News
      </h1>
      <h1 className="text-4xl font-bold text-gray-800">
        Latest Launch Events:
      </h1>
      <ul className="rounded-2xl shadow-lg p-2 bg-white  flex">
        {array.map((blog, index) => (
          <li
            key={index}
            className="bg-yellow-200 p-5 m-3 rounded-2xl transition-trasform transform hover:scale-105"
          >
            <p className="text-xl font semibold text-gray-800">{blog.title}</p>
            <p className="text-sm text-gray-600">{blog.content}</p>
          </li>
        ))}
      </ul>
      <h1 className="text-4xl font-bold text-gray-800 pt-4">
        Latest Mobiles Launched:
      </h1>
      <ul className="rounded-2xl shadow-lg p-2 bg-white  flex">
        {array2.map((blog, index) => (
          <li
            key={index}
            className="bg-yellow-200 p-5 m-3 rounded-2xl transition-trasform transform hover:scale-105"
          >
            <p className="text-xl font semibold text-gray-800">{blog.title}</p>
            <p className="text-sm text-gray-600">{blog.content}</p>
          </li>
        ))}
      </ul>
      <ul>
        <p className="text-xl font-bold">
          Frontend: React, Tailwind || Backend: Express.js, CORS, Axios
        </p>
        <p className="text-xl font-bold">
          Retriving Information from Backend and displaying on Frontend,
          communication between Client and Server ports using CORS.
        </p>
      </ul>
    </div>
  );
}

export default App;
