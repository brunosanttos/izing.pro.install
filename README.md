## CRIAR SUBDOMINIO E APONTAR PARA O IP DA SUA VPS

Testado ubuntu 20

Versão premium vai pedir usuario e senha para poder instalar

## CHECAR PROPAGAÇÃO DO DOMÍNIO

https://dnschecker.org/

## RODAR OS COMANDOS ABAIXO ##

para evitar erros recomendados atualizar sistema e apos atualizar reniciar para evitar erros

```bash
apt -y update && apt -y upgrade
```
```bash
reboot
```
 
Depois reniciar seguir com a instalacao

```bash
cd /root
```
```bash
git clone https://github.com/cleitonme/izing.pro.install.git izinginstalador
```
Para alterar as senhas alterar arquivo config, com nano para salvar aperta Ctrl + x
```bash
nano ./izinginstalador/config
```
```bash
sudo chmod +x ./izinginstalador/izing
```
```bash
cd ./izinginstalador
```
```bash
sudo ./izing
```

## Alterar Frontend

Para mudar nome do aplicativo:

/home/deploy/izing.io/frontend/quasar.conf

/home/deploy/izing.io/frontend/src/index.template.html

Para alterar logos e icones:

pasta /home/deploy/izing.io/frontend/public

Para alterar cores:

/home/deploy/izing.io/frontend/src/css/app.sass

/home/deploy/izing.io/frontend/src/css/quasar.variables.sass

Sempre alterar usando usuario deploy você pode conectar servidor com aplicativo Bitvise SSH Client. Depois das alterações compilar novamente o Frontend

```bash
su deploy
```
```bash
cd /home/deploy/izing.io/frontend/
```
```bash
export NODE_OPTIONS=--openssl-legacy-provider
```
```bash
npx quasar build -P -m pwa
```

Testar as alterações em aba anonima

## Recomendação de instalar e deixar Firewall ativado

Seu servidor pode sofrer ataques externos que fazem sistema travar e ter quedas por favor instale e mantenha o firewall ativado.
Utilizado UFW para saber mais de pesquisada no google.

## Recomendação de VPS boa e barata

-  [Powerful cloud VPS & Web hosting.](https://control.peramix.com/?affid=58)

## Consultoria particular

Esta versão chamar no whatsapp 48 999416725

Ela possui mais recursos e bugs são corrigidos com requência