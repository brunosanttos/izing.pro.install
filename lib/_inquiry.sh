#!/bin/bash

get_frontend_url() {
  print_banner
  printf "${WHITE} 💻 Digite o domínio da interface web (Frontend):${GRAY_LIGHT}"
  printf "\n\n"
  read -p "> " frontend_url
}

get_backend_url() {
  print_banner
  printf "${WHITE} 💻 Digite o domínio da sua API (Backend):${GRAY_LIGHT}"
  printf "\n\n"
  read -p "> " backend_url
}

get_usuario() {
  print_banner
  printf "${WHITE} 💻 Digite o nome de usuario recebido na compra:${GRAY_LIGHT}"
  printf "\n\n"
  read -p "> " username_down
}

get_senha() {
  print_banner
  printf "${WHITE} 💻 Digite a senha recebida na compra:${GRAY_LIGHT}"
  printf "\n\n"
  read -p "> " senha_down
}

get_urls() {
  get_frontend_url
  get_backend_url
  get_usuario
  get_senha
}

software_update() {
  
  # frontend_update
  backend_update
}


inquiry_options() {
  
  print_banner
  printf "${WHITE} 💻 O que você precisa fazer?${GRAY_LIGHT}"
  printf "\n\n"
  printf "   [1] Instalar\n"
  printf "   [2] Atualizar Izing\n"
  printf "\n"
  read -p "> " option

  case "${option}" in
    1) get_urls ;;


    2) 
      software_update 
      exit
      ;;

    *) exit ;;
  esac
}

