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

[install Yarn](https://yarnpkg.com/lang/en/docs/install/)

[install npm](https://docs.npmjs.com/cli/install)


## Dev settup and prod

After the install just run:

```bash
yarn install
yarn dev
```
or
```bash
npm install
npm dev
```

For production just replace **dev** for **buid**:

```bash
yarn build
```
