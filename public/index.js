// Import all sass
require('../src/scss/main.scss');

/*
//Import polimer elements
require("./bower_components/webcomponentsjs/webcomponents-lite.js");
require("./bower_components/iron-icon/iron-icon.html");
require("./bower_components/iron-flex-layout/iron-flex-layout-classes.html");

require("./bower_components/paper-button/paper-button.html");
require("./bower_components/paper-menu-button/paper-menu-button.html");
require("./bower_components/paper-icon-button/paper-icon-button.html");
require("./bower_components/paper-fab/paper-fab.html");

require("./bower_components/paper-dropdown-menu/paper-dropdown-menu.html");
require("./bower_components/paper-menu-button/paper-menu-button.html");
require("./bower_components/paper-item/paper-item.html");
require("./bower_components/paper-listbox/paper-listbox.html");

require("./bower_components/paper-toolbar/paper-toolbar.html");
require("./bower_components/paper-styles/paper-styles.html");
*/

require('./index.html');

var logo = require('./logo.svg');
var Elm = require('../src/App.elm');

document.addEventListener('DOMContentLoaded', function() {
    var root = document.getElementById('app-root');
    var app = Elm.App.embed(root, logo);
});