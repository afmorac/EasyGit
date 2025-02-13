#!/bin/bash

# Colores
GREEN='\033[1;32m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
RED='\033[1;31m'
NC='\033[0m'  # Sin color

# Verifica si estás en un repositorio Git
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  echo -e "${RED}Error: You are not in a Git repository.${NC}"
  echo -e "${YELLOW}Tip: Use 'git init' to create a new repository here.${NC}"
  echo -e "${CYAN}Or navigate to an existing Git repository and try again.${NC}"
  read -p "Press any key to exit..."
  exit 1
fi

# git add - Validación del input y opción de salida
while true; do
  echo -e "${YELLOW}git add:${NC}"
  echo "  m - Add all files"
  echo "  d - Add specific directory"
  echo "  f - Add specific file"
  echo "  c - Custom add command"
  echo "  q - Quit"
  read -p "Choose option: " add_option

  case $add_option in
    m)
      git add . 2>&1 || { echo -e "${RED}git error: Failed to add files. Try again.${NC}"; continue; }
      echo -e "${GREEN}add done.${NC}"
      break
      ;;
    d)
      read -p "Directory path (or 'q' to quit): " dir_name
      if [ "$dir_name" == "q" ]; then
        echo "Exiting script."
        exit 0
      fi
      if [ -z "$dir_name" ]; then
        echo -e "${RED}No directory specified. Please try again.${NC}"
        continue
      fi
      git add $dir_name 2>&1 || { echo -e "${RED}git error: Failed to add directory. Try again.${NC}"; continue; }
      echo -e "${GREEN}add done.${NC}"
      break
      ;;
    f)
      read -p "File name (or 'q' to quit): " file_name
      if [ "$file_name" == "q" ]; then
        echo "Exiting script."
        exit 0
      fi
      if [ -z "$file_name" ]; then
        echo -e "${RED}No file specified. Please try again.${NC}"
        continue
      fi
      git add $file_name 2>&1 || { echo -e "${RED}git error: Failed to add file. Try again.${NC}"; continue; }
      echo -e "${GREEN}add done.${NC}"
      break
      ;;
    c)
      read -p "Custom add command (e.g., 'git add -p', or 'q' to quit): " custom_add
      if [ "$custom_add" == "q" ]; then
        echo "Exiting script."
        exit 0
      fi
      if [ -z "$custom_add" ]; then
        echo -e "${RED}No command specified. Please try again.${NC}"
        continue
      fi
      $custom_add 2>&1 || { echo -e "${RED}git error: Failed to execute custom add. Try again.${NC}"; continue; }
      echo -e "${GREEN}custom add done.${NC}"
      break
      ;;
    q)
      echo "Exiting git add."
      exit 0
      ;;
    *)
      echo -e "${RED}Invalid option. Try again.${NC}"
      continue
      ;;
  esac
done

# git commit - Validación y opción de salida
while true; do
  echo -e "${CYAN}git commit:${NC}"
  echo "  m - Add message"
  echo "  a - Amend last commit"
  echo "  c - Custom commit command"
  echo "  q - Quit"
  read -p "Choose option: " commit_option

  case $commit_option in
    m)
      read -p "Commit message (or 'q' to quit): " commit_message
      if [ "$commit_message" == "q" ]; then
        echo "Exiting script."
        exit 0
      fi
      git commit -m "$commit_message" 2>&1 || { echo -e "${RED}git error: Failed to commit. Try again.${NC}"; continue; }
      echo -e "${GREEN}commit done.${NC}"
      break
      ;;
    a)
      git commit --amend 2>&1 || { echo -e "${RED}git error: Failed to amend commit. Try again.${NC}"; continue; }
      echo -e "${GREEN}commit amend done.${NC}"
      break
      ;;
    c)
      read -p "Custom commit command (e.g., 'git commit -S -m \"msg\"', or 'q' to quit): " custom_commit
      if [ "$custom_commit" == "q" ]; then
        echo "Exiting script."
        exit 0
      fi
      if [ -z "$custom_commit" ]; then
        echo -e "${RED}No command specified. Please try again.${NC}"
        continue
      fi
      $custom_commit 2>&1 || { echo -e "${RED}git error: Failed to execute custom commit. Try again.${NC}"; continue; }
      echo -e "${GREEN}custom commit done.${NC}"
      break
      ;;
    q)
      echo "Exiting git commit."
      exit 0
      ;;
    *)
      echo -e "${RED}Invalid option. Try again.${NC}"
      continue
      ;;
  esac
done

# git push - Validación y opción de salida
while true; do
  echo -e "${GREEN}git push:${NC}"
  echo "  m - Push to origin master"
  echo "  d - Push to default branch (git push)"
  echo "  c - Custom push input"
  echo "  q - Quit"
  read -p "Choose option: " push_option

  case $push_option in
    m)
      git push origin master 2>&1 || { echo -e "${RED}git error: Failed to push to origin master. Try again.${NC}"; continue; }
      echo -e "${GREEN}push to origin master done.${NC}"
      break
      ;;
    d)
      git push 2>&1 || { echo -e "${RED}git error: Failed to push. Try again.${NC}"; continue; }
      echo -e "${GREEN}push done.${NC}"
      break
      ;;
    c)
      read -p "Custom push command (e.g., 'origin dev --force', or 'q' to quit): git push " custom_command
      if [ "$custom_command" == "q" ]; then
        echo "Exiting script."
        exit 0
      fi
      git push $custom_command 2>&1 || { echo -e "${RED}git error: Failed to execute custom push. Try again.${NC}"; continue; }
      echo -e "${GREEN}custom push done.${NC}"
      break
      ;;
    q)
      echo "Exiting git push."
      exit 0
      ;;
    *)
      echo -e "${RED}Invalid option. Try again.${NC}"
      continue
      ;;
  esac
done

# git status o git log - Elección del usuario con opción de volver al menú
while true; do
  echo -e "${CYAN}Choose what you want to do next:${NC}"
  echo "  1 - git status"
  echo "  2 - git log"
  echo "  q - Quit"
  read -p "Choose option: " final_option

  case $final_option in
    1)
      echo -e "${CYAN}git status:${NC}"
      git status
      ;;
    2)
      echo -e "${CYAN}git log:${NC}"
      git log --oneline --graph --decorate
      ;;
    q)
      echo "Exiting script."
      exit 0
      ;;
    *)
      echo -e "${RED}Invalid option. Please try again.${NC}"
      ;;
  esac
done

