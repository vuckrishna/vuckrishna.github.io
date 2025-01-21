// type module in package.json will change the syntax from require to import - very imp
import express from "express";
import cors from "cors";

const app = express();

const corsOptions = {
    origin: ["http://localhost:5173"],
}

app.use(cors(corsOptions));

app.get("/", (req, res) => {
    res.json({
        blogPost:[{
            title:"Samsung unpacked event: S25 Series on Jan 23 2025",
            content:"Samsung's S25 Series mobiles and latest galaxy buds are going to unviel at the unpacked event.",
        },
        {
            title:"Oneplus Event: Unveiling Oneplus Flagship Devices on Jan 2025",
            content:"Oneplus's most awaited Oneplus 13 and 13R are to going to release at this event.",
        },
        {
            title:"Xiaomi Event: Xiaomi Flagships on Dec 2024",
            content:"Xiaomi's fan favourite flagship Xiaomi 15 and 15 pro are launching in this event.",
        },
        {
            title:"Apple Event: Iphone 16 Series on Sept 2024",
            content:"Apple's yearly update on Iphones with the latest 16 Series are going to launch.",
        },
        {
            title:"Google Event: Android 15 and Pixels 9 Series on Aug 2024",
            content:"Most updated Pixel 9 series and most awaited Android 15 are going to unveil at this event.",
        },
    ],
    latestPost:[{
        title:"Samsung S25, S25+, S25 Slim and S25 ULTRA",
        content:"Latest Snapdragon 8 Elite processor and flagship cameras",
    },
    {
        title:"Oneplus 13, 13R",
        content:"Latest Snapdragon 8 Elite processor and OxygenOS",
    },
    {
        title:"Iphone 16, 16 Plus, 16 Pro, 16 Pro Max",
        content:"Latest A18 bionic chip and better battery life",
    },
    {
        title:"Pixel 9, 9 Pro, 9 Pro XL, 9 Pro Fold",
        content:"Latest Tensor G4 processor and Stock Android",
    },
    ],
    });
});

app.listen(8080, () => {
    console.log("Server started on port 8080")
})