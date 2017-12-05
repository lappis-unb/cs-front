<p align="center"><img width="300"src="https://codeschool.lappis.rocks/static/img/logo.svg"></p>


# CodeSchool Frontend SPA

The CodeScool frontend SPA is based on and implemented in Elm. Before installing CodeScool completely, you must first install some dependencies of the project. The installation and implementation instructions for the project are as follows.

## Installation of dependencies

![nodeJS](https://kaskwp.kask.at/wp-content/uploads/2015/03/nodejs-new-pantone-black-1-150x150.png)
![yarn](https://techracho.bpsinc.jp/wp-content/uploads/2016/10/161012_1628_HsYHd6.png)
![npm](http://restfulbrilliance.com/img/tech/npm.png)


Node.js is a JavaScript interpreter that works on the server side. Its goal is to assist in the creation of highly scalable applications, with codes capable of handling simultaneous connections on a single machine.
First install a version greater than 7, we indicate that you install version 8.4.0.: [Install Node.js](https://nodejs.org/en/download/package-manager/)

Next you should install a package manager of JavaScript, we advise the installation of **yarn** promising to be faster than **npm** and is a project open source:

You should only install a management pack choosing between the **yarn** or **npm**:

[Install Yarn](https://yarnpkg.com/lang/en/docs/install/)

[Install Npm](https://docs.npmjs.com/cli/install)

## Development setup

Before run step of ```Yarn Install``` or ```Npm Install``` follow the steps off ```Install elm-install```.

###  Install elm-install

For the perfect functionality of Ace Editor in CodeSchool, is necessary install elm-install dependency manager and run it to install the software external dependences.

[Install elm-install](https://github.com/gdotdesign/elm-github-install)

###  Yarn Install
After the install of dependencies you need to install yarn packages using this command:

```bash
yarn install
```
An then run elm application with:

```bash
yarn dev
```

###  Npm Install
If you prefer run with npm, use the following commands to install npm packages:

```bash
npm install
```
An then run elm application with:

```bash
npm dev
```

**To use the application** in Development mode, just open on ```localhost:4000```


## Production setup

For production just replace **dev** for **buid**:

```bash
yarn build
```
