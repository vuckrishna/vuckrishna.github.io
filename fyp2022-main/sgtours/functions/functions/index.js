const admin = require("firebase-admin");
admin.initializeApp();

const account = require('./src/account');
const poi = require('./src/poi');
const guide = require('./src/guide');

// Account EndPoint
exports.account = account.account;
exports.poi = poi.poi;
exports.guide = guide.guides;