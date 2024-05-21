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
  
  get_usuario
  get_senha
  system_pm2_stop
  system_update_izing
  frontend_node_dependencies
  frontend_node_build
  backend_node_dependencies
  backend_db_migrate
  backend_db_seed
  system_pm2_start
  system_success2
}

instalar_firewall() {
  instalacao_firewall
}

ativar_firewall () {
  iniciar_firewall
}

desativar_firewall () {
  parar_firewall
}

inquiry_options() {
  
  print_banner
# Verifica se o UFW está ativado
if sudo ufw status | grep -q "Status: inactive"; then
  echo -e "\033[0;31m❌ Servidor inseguro! O firewall está desativado.\033[0m"
fi
  printf "${WHITE} 💻 O que você precisa fazer?${GRAY_LIGHT}"
  printf "\n\n"
  printf "   [1] Instalar\n"
  printf "   [2] Atualizar Izing(antes de atualizar faça um Snapshots da VPS\n"
  printf "   [3] Instalar Firewall(ufw) importante para evitar ataques HACKER\n"
  printf "   [4] Ativar Firewall\n"
  printf "   [5] Desativar Firewall\n"
  printf "\n"
  read -p "> " option

  case "${option}" in
    1) get_urls ;;


    2) 
      software_update 
      exit
      ;;

    3) 
      instalar_firewall 
      exit
      ;;
	  
    4) 
      ativar_firewall 
      exit
      ;;
	  
    5) 
      desativar_firewall 
      exit
      ;;

    *) exit ;;
  esac
}

