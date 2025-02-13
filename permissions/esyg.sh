#!/bin/bash

# Colores
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
RED='\033[1;31m'
NC='\033[0m'  # Sin color

# git add - Opciones simples y custom
echo -e "${YELLOW}git add:${NC}"
echo "  m - Add all files"
echo "  d - Add specific directory"
echo "  f - Add specific file"
echo "  c - Custom add command"
read -p "Choose option: " add_option

case $add_option in
  m)
    git add . 2>&1 || { echo -e "${RED}git error: Failed to add files${NC}"; exit 1; }
    echo -e "${GREEN}add done.${NC}"
    ;;
  d)
    read -p "Directory path: " dir_name
    git add $dir_name 2>&1 || { echo -e "${RED}git error: Failed to add directory${NC}"; exit 1; }
    echo -e "${GREEN}add done.${NC}"
    ;;
  f)
    read -p "File name: " file_name
    git add $file_name 2>&1 || { echo -e "${RED}git error: Failed to add file${NC}"; exit 1; }
    echo -e "${GREEN}add done.${NC}"
    ;;
  c)
    read -p "Custom add command (e.g., 'git add -p'): " custom_add
    $custom_add 2>&1 || { echo -e "${RED}git error: Failed to execute custom add${NC}"; exit 1; }
    echo -e "${GREEN}custom add done.${NC}"
    ;;
  *)
    echo -e "${RED}Invalid option for git add.${NC}"
    exit 1
    ;;
esac

# git commit - Opciones simples y custom
echo -e "${CYAN}git commit:${NC}"
echo "  m - Add message"
echo "  a - Amend last commit"
echo "  c - Custom commit command"
read -p "Choose option: " commit_option

case $commit_option in
  m)
    read -p "Commit message: " commit_message
    git commit -m "$commit_message" 2>&1 || { echo -e "${RED}git error: Failed to commit${NC}"; exit 1; }
    echo -e "${GREEN}commit done.${NC}"
    ;;
  a)
    git commit --amend 2>&1 || { echo -e "${RED}git error: Failed to amend commit${NC}"; exit 1; }
    echo -e "${GREEN}commit amend done.${NC}"
    ;;
  c)
    read -p "Custom commit command (e.g., 'git commit -S -m \"msg\"'): " custom_commit
    $custom_commit 2>&1 || { echo -e "${RED}git error: Failed to execute custom commit${NC}"; exit 1; }
    echo -e "${GREEN}custom commit done.${NC}"
    ;;
  *)
    echo -e "${RED}Invalid option for git commit.${NC}"
    exit 1
    ;;
esac

# git push - Opciones simples y custom
echo -e "${GREEN}git push:${NC}"
echo "  m - Push to origin master"
echo "  d - Push to default branch (git push)"
echo "  c - Custom push input"
read -p "Choose option: " push_option

case $push_option in
  m)
    git push origin master 2>&1 || { echo -e "${RED}git error: Failed to push to origin master${NC}"; exit 1; }
    echo -e "${GREEN}push to origin master done.${NC}"
    ;;
  d)
    git push 2>&1 || { echo -e "${RED}git error: Failed to push${NC}"; exit 1; }
    echo -e "${GREEN}push done.${NC}"
    ;;
  c)
    read -p "Custom push command (e.g., 'origin dev --force'): git push " custom_command
    git push $custom_command 2>&1 || { echo -e "${RED}git error: Failed to execute custom push${NC}"; exit 1; }
    echo -e "${GREEN}custom push done.${NC}"
    ;;
  *)
    echo -e "${RED}Invalid option for git push.${NC}"
    exit 1
    ;;
esac

# git status - Mostrar el estado del repositorio
echo -e "${CYAN}git status:${NC}"
git status

