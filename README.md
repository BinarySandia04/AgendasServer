<!-- PROJECT LOGO -->
<br />
<!-- <p align="center">-->
<!--   <a href="https://github.com/othneildrew/Best-README-Template">-->
<!--    <img src="images/logo.png" alt="Logo" width="80" height="80">-->
<!--   </a>-->

  <h3 align="center">Agenda Server</h3>

  <p align="center">
    Codi del meu TDR sobre la construcció d'una aplicació web
    <br />
    <a href="https://github.com/othneildrew/Best-README-Template/issues">Informa d'un error</a>
    ·
    <a href="https://github.com/othneildrew/Best-README-Template/issues">Demana una proposta</a>
  </p>
</p>

<!-- TABLE OF CONTENTS -->
## Índex

* [Sobre el projecte](#about-the-project)
  * [Fet amb](#built-with)
* [Instal·lació del projecte](#getting-started)
  * [Requisits previs](#prerequisites)
  * [Instal·lació](#installation)
* [Llicència](#license)
* [Contacte](#contact)



<!-- ABOUT THE PROJECT -->
## Sobre el projecte

This is the Agenda server side code. I'm posting it because I'm forced to do it.

### Fet amb

* [Ruby]
* [Rails](https://getbootstrap.com)
* [JQuery](https://jquery.com)

<!-- GETTING STARTED -->
## Instal·lació del projecte

Ok so if you want to get the source code clone this repo:
```sh
git clone https://github.com/BinarySandia04/GendaServer.git
```

### Requisits previs

First, you need to install ruby 2.5.5. Do it with rvm or other ruby package manager you like. Then install the bundler gem if you don't have it:
```sh
gem install bundler
```

Now you must install **libvips** using your package manager:
```sh
sudo apt-get install libvips
```
And also you need to install **yarn**:
```sh
sudo apt-get install yarn
```

### Instal·lació

Ok so if you want to get the source code clone this repo:
```sh
git clone https://github.com/BinarySandia04/GendaServer.git
```
If you want to run the server you must install the **gem dependencies**:
```sh
bundle install
```
And you must install the **yarn packages**:
```sh
yarn install --check-files
```

Enjoy. Run the server with the run script:
```sh
./run.sh
```

If you want to **DROP** the entire database use the reset script:
```sh
./reset.sh
```

<!-- LICENSE -->
## Llicència

Distributed under the MIT License. See `LICENSE` for more information.

<!-- CONTACT -->
## Contacte

Your Name - [@your_twitter](https://twitter.com/your_username) - email@example.com

Project Link: [https://github.com/your_username/repo_name](https://github.com/your_username/repo_name)
