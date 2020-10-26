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

* [Sobre el projecte](#sobre-el-projecte)
  * [Fet amb](#fet-amb)
* [Instal·lació del projecte](#instal·lació-del-projecte)
  * [Requisits previs](#requisits-previs)
  * [Instal·lació](#instal·lació)
* [Llicència](#llicència)
* [Contacte](#contacte)



<!-- ABOUT THE PROJECT -->
## Sobre el projecte

Aquest és el codi del projecte de Ruby on Rails de Agenda. És públic per motius educatius.

### Fet amb

* [Ruby](https://www.ruby-lang.org/es/)
* [Rails](https://rubyonrails.org/)
* [JQuery](https://jquery.com)

<!-- GETTING STARTED -->
## Instal·lació del projecte

Per instal·lar el projecte al teu ordinador, només has de clonar el repositori i seguir els [requisits previs](#requisits-previs)
```sh
git clone https://github.com/BinarySandia04/GendaServer.git
```

### Requisits previs

Primer necessites instal·lar Ruby 2.5.5. Ho pots fer amb rvm o qualsevol altre distribuïdor de Ruby. Després, instal·la la Gem de Bundler si no la tens:
```sh
gem install bundler
```

Necessites instal·lar **libvips** utilitzant el teu gestor de paquets:
```sh
sudo apt-get install libvips
```
I també **yarn**:
```sh
sudo apt-get install yarn
```

### Instal·lació

Per executar el servidor has d'instal·lar les Gems de la Gemfile:
```sh
bundle install
```
I també has d'instal·lar els **paquets de Yarn**:
```sh
yarn install --check-files
```

I ja està! Finalment executa el servidor amb el script **run.sh**:
```sh
./run.sh
```
El servidor s'obrirà al port 8080 en l'entorn de producció.

Si vols borrar les bases de dades utilitza **reset.sh**:
```sh
./reset.sh
```

<!-- LICENSE -->
## Llicència

Distributed under the MIT License. See `LICENSE` for more information.

<!-- CONTACT -->
## Contacte

Aran Roig - aranseraroig@gmail.com
