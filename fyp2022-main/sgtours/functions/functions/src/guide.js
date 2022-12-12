const functions = require("firebase-functions");
const express = require("express");
const cors = require("cors");
const admin = require("firebase-admin");

const app = express();

// GET ALL
app.get("/", async (req, res) => {
  const snapshot = await admin.firestore().collection("Guides").get();

  let dataList = [];
  snapshot.forEach((doc) => {
    let id = doc.id;
    let data = doc.data();

    dataList.push({ id, ...data });
  });

  res.status(200).send(JSON.stringify(dataList));
});

// GET SINGLE ID
app.get("/:id", async (req, res) => {
  const snapshot = await admin
    .firestore()
    .collection("Guides")
    .doc(req.params.id)
    .get();

  const id = snapshot.id;
  const data = snapshot.data();

  res.status(200).send(JSON.stringify({ id: id, ...data }));
});

// ADD DATA
app.post("/", async (req, res) => {
  const data = req.body;

  await admin.firestore().collection("Guides").add(data);
  res.status(201).send();
});

// UPDATE DATA
app.put("/:id", async (req, res) => {
  const body = req.body;

  await admin.firestore().collection("Guides").doc(req.params.id).update(body);

  res.status(200).send();
});

// DELETE DATA
app.delete("/:id", async (req, res) => {
  await admin.firestore().collection("Guides").doc(req.params.id).delete();
  res.status(200).send();
});

exports.guides = functions.https.onRequest(app);