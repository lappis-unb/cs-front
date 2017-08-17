require('../src/scss/main.scss');

require('./index.html');

var logo = require('./logo.svg');
var Elm = require('../src/App.elm');

document.addEventListener('DOMContentLoaded', function() {
    var root = document.getElementById('app-root');
    var app = Elm.App.embed(root, logo);
});