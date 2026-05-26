# negligible for oh-my-zsh
#
# This theme is a pure zsh/oh-my-zsh approximation of the Oh My Posh
# negligible.omp.json theme. It does not require the oh-my-posh binary.

autoload -Uz vcs_info

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats '%b'
zstyle ':vcs_info:git:*' actionformats '%b'

function _negligible_os_release_value() {
  local key="$1" file name value
  local -a files

  if [[ -n "$NEGLIGIBLE_OS_RELEASE" ]]; then
    files=("$NEGLIGIBLE_OS_RELEASE")
  else
    files=(/etc/os-release /usr/lib/os-release)
  fi

  for file in "${files[@]}"; do
    [[ -r "$file" ]] || continue
    while IFS='=' read -r name value; do
      [[ "$name" == "$key" ]] || continue
      value="${value%\"}"
      value="${value#\"}"
      value="${value%\'}"
      value="${value#\'}"
      print -r -- "${value:l}"
      return 0
    done < "$file"
  done

  return 1
}

function _negligible_linux_icon_for_id() {
  case "$1" in
    almalinux) print -r -- "" ;;
    alpine) print -r -- "" ;;
    aosc|aosc-os) print -r -- "" ;;
    arch|archlinux) print -r -- "" ;;
    archcraft) print -r -- "" ;;
    archlabs) print -r -- "" ;;
    arcolinux) print -r -- "" ;;
    artix) print -r -- "" ;;
    biglinux) print -r -- "" ;;
    centos) print -r -- "" ;;
    coreos|fedora-coreos) print -r -- "" ;;
    debian) print -r -- "" ;;
    deepin) print -r -- "" ;;
    devuan) print -r -- "" ;;
    elementary|elementaryos) print -r -- "" ;;
    endeavour|endeavouros) print -r -- "" ;;
    fedora) print -r -- "" ;;
    garuda|garudalinux) print -r -- "" ;;
    gentoo) print -r -- "" ;;
    guix|guixsd|gnu-guix) print -r -- "" ;;
    hyperbola) print -r -- "" ;;
    kali|kali-linux) print -r -- "" ;;
    kde-neon|neon|org.kde.neon) print -r -- "" ;;
    kubuntu) print -r -- "" ;;
    linuxmint|mint) print -r -- "" ;;
    locos) print -r -- "" ;;
    lxle) print -r -- "" ;;
    mageia) print -r -- "" ;;
    mandriva) print -r -- "" ;;
    manjaro) print -r -- "" ;;
    mx|mxlinux) print -r -- "" ;;
    nixos) print -r -- "" ;;
    nobara) print -r -- "" ;;
    opensuse-tumbleweed|tumbleweed) print -r -- "" ;;
    opensuse-leap|leap) print -r -- "" ;;
    opensuse|suse|sles) print -r -- "" ;;
    parabola) print -r -- "" ;;
    parrot|parrotos) print -r -- "" ;;
    pop|pop-os|pop_os) print -r -- "" ;;
    postmarketos) print -r -- "" ;;
    puppy|puppy_linux|puppylinux) print -r -- "" ;;
    qubes|qubesos) print -r -- "" ;;
    raspbian|raspberry-pi|raspberry_pi|raspberrypi) print -r -- "" ;;
    amzn|amazon|amazonlinux|amazon-linux) print -r -- "" ;;
    ol|oracle|oraclelinux|oracle-linux) print -r -- "" ;;
    redhat|rhel|red-hat|redhatenterprise) print -r -- "" ;;
    rocky|rockylinux|rocky-linux) print -r -- "" ;;
    sabayon) print -r -- "" ;;
    slackware) print -r -- "" ;;
    solus) print -r -- "" ;;
    tails) print -r -- "" ;;
    trisquel) print -r -- "" ;;
    ubuntu) print -r -- "" ;;
    vanilla|vanillaos|vanilla-os) print -r -- "" ;;
    void|voidlinux|void-linux) print -r -- "" ;;
    xerolinux|xero-linux) print -r -- "" ;;
    zorin|zorin-os|zorinos) print -r -- "" ;;
    linux|gnu/linux) print -r -- "" ;;
    *) return 1 ;;
  esac
}

function _negligible_linux_os_icon() {
  local id variant_id id_like like_id icon

  for id in "$(_negligible_os_release_value ID)" "$(_negligible_os_release_value VARIANT_ID)"; do
    [[ -n "$id" ]] || continue
    icon="$(_negligible_linux_icon_for_id "$id")" && {
      print -r -- "$icon"
      return 0
    }
  done

  id_like="$(_negligible_os_release_value ID_LIKE)"
  for like_id in ${(s: :)id_like}; do
    icon="$(_negligible_linux_icon_for_id "$like_id")" && {
      print -r -- "$icon"
      return 0
    }
  done

  print -r -- ""
}

function _negligible_os_icon() {
  case "$OSTYPE" in
    darwin*) print -r -- "" ;;
    linux*) _negligible_linux_os_icon ;;
    freebsd*) print -r -- "" ;;
    openbsd*) print -r -- "" ;;
    msys*|cygwin*) print -r -- "" ;;
    *) print -r -- "" ;;
  esac
}

function _negligible_find_up() {
  local dir="$PWD"
  while [[ "$dir" != "/" ]]; do
    if [[ -e "$dir/$1" ]]; then
      print -r -- "$dir/$1"
      return 0
    fi
    dir="${dir:h}"
  done
  return 1
}

function _negligible_prompt_text() {
  local text="$1"
  print -r -- "${text//\%/%%}"
}

function _negligible_strip_prompt_escapes() {
  local text="$1"
  text="${text//\%F\{cyan\}/}"
  text="${text//\%F\{red\}/}"
  text="${text//\%F\{#F1502F\}/}"
  text="${text//\%F\{#06A4CE\}/}"
  text="${text//\%F\{#6CA35E\}/}"
  text="${text//\%F\{#4584b6\}/}"
  text="${text//\%F\{#4caf50\}/}"
  text="${text//\%F\{#40c4ff\}/}"
  text="${text//\%F\{#ff0000\}/}"
  text="${text//\%F\{#90ee90\}/}"
  text="${text//\%f/}"
  print -r -- "${text//\%\%/%}"
}

function _negligible_display_width() {
  emulate -L zsh
  setopt multibyte

  local text="$1" char width=0 i
  for (( i = 1; i <= ${#text}; i++ )); do
    char="${text[i]}"
    case "$char" in
      [$'\u0300'-$'\u036f'$'\ufe00'-$'\ufe0f'])
        ;;
      [$'\u1100'-$'\u115f'$'\u2329'$'\u232a'$'\u2e80'-$'\ua4cf'$'\uac00'-$'\ud7a3'$'\uf900'-$'\ufaff'$'\ufe10'-$'\ufe19'$'\ufe30'-$'\ufe6f'$'\uff00'-$'\uff60'$'\uffe0'-$'\uffe6'])
        (( width += 2 ))
        ;;
      *)
        (( width += 1 ))
        ;;
    esac
  done

  print -r -- "$width"
}

function _negligible_git_segment() {
  command git rev-parse --is-inside-work-tree &>/dev/null || return 0

  local branch ahead behind branch_status staged unstaged git_status segment
  branch="$(command git symbolic-ref --quiet --short HEAD 2>/dev/null \
    || command git rev-parse --short HEAD 2>/dev/null)"
  branch="$(_negligible_prompt_text "$branch")"

  local upstream
  upstream="$(command git rev-parse --abbrev-ref --symbolic-full-name '@{u}' 2>/dev/null)"
  if [[ -n "$upstream" ]]; then
    local counts_line
    counts_line="$(command git rev-list --left-right --count HEAD..."$upstream" 2>/dev/null)"
    ahead="${counts_line%%[[:space:]]*}"
    behind="${counts_line##*[[:space:]]}"
    case "$ahead" in (''|*[!0-9]*) ahead=0 ;; esac
    case "$behind" in (''|*[!0-9]*) behind=0 ;; esac
    if (( ahead > 0 && behind > 0 )); then
      branch_status="⇕${ahead}/${behind}"
    elif (( ahead > 0 )); then
      branch_status="⇡${ahead}"
    elif (( behind > 0 )); then
      branch_status="⇣${behind}"
    fi
  fi

  git_status="$(command git status --porcelain=v1 2>/dev/null)"
  staged="$(print -r -- "$git_status" | command awk 'substr($0,1,1) != " " && substr($0,1,1) != "?" { count++ } END { print count + 0 }')"
  unstaged="$(print -r -- "$git_status" | command awk 'substr($0,2,1) != " " { count++ } END { print count + 0 }')"

  segment=":: ${branch}"
  [[ -n "$branch_status" ]] && segment+=" ${branch_status}"
  [[ "$staged" != "0" ]] && segment+="  ${staged}"
  [[ "$staged" != "0" && "$unstaged" != "0" ]] && segment+=" |"
  [[ "$unstaged" != "0" ]] && segment+="  ${unstaged}"

  print -r -- "%F{#F1502F}${segment} %f"
}

function _negligible_root_segment() {
  (( EUID == 0 )) && print -r -- "%F{red}| root %f"
}

function _negligible_dart_segment() {
  _negligible_find_up pubspec.yaml &>/dev/null || [[ -d .dart_tool ]] || return 0
  command dart --version &>/dev/null || return 0

  local version
  version="$(command dart --version 2>&1)"
  version="${version#Dart SDK version: }"
  version="${version%% *}"
  version="$(_negligible_prompt_text "$version")"
  [[ -n "$version" ]] && print -r -- "%F{#06A4CE}|  ${version} %f"
}

function _negligible_node_segment() {
  _negligible_find_up package.json &>/dev/null || _negligible_find_up node_modules &>/dev/null || _negligible_find_up .nvmrc &>/dev/null || return 0
  command node --version &>/dev/null || return 0

  local version manager=""
  version="$(command node --version 2>/dev/null)"
  version="$(_negligible_prompt_text "$version")"
  command pnpm --version &>/dev/null && [[ -e package.json && -e pnpm-lock.yaml ]] && manager=" "
  command yarn --version &>/dev/null && [[ -e package.json && -e yarn.lock ]] && manager=" "
  command npm --version &>/dev/null && [[ -z "$manager" && -e package.json ]] && manager=" "

  print -r -- "%F{#6CA35E}|  ${manager}${version} %f"
}

function _negligible_python_segment() {
  local venv=""
  if [[ -n "$VIRTUAL_ENV" ]]; then
    venv="${VIRTUAL_ENV:t}"
  elif [[ -n "$CONDA_DEFAULT_ENV" ]]; then
    venv="$CONDA_DEFAULT_ENV"
  fi

  venv="$(_negligible_prompt_text "$venv")"
  [[ -n "$venv" ]] && print -r -- "%F{#4584b6}|  ${venv} %f"
}

function _negligible_battery_segment() {
  [[ "$OSTYPE" == darwin* ]] || return 0
  command pmset -g batt &>/dev/null || return 0

  local line percent icon color
  line="$(command pmset -g batt | command awk '/[0-9]+%/ { print; exit }')"
  [[ -n "$line" ]] || return 0

  percent="${${line#*	}%%;*}"
  percent="$(_negligible_prompt_text "$percent")"
  if [[ "$line" == *"discharging"* ]]; then
    icon=""
    color="#40c4ff"
  elif [[ "$line" == *"charging"* ]]; then
    icon=" "
    color="#4caf50"
  elif [[ "$line" == *"charged"* || "$line" == *"AC Power"* ]]; then
    icon=" "
    color="#ff0000"
  else
    color="#40c4ff"
  fi

  print -r -- "%F{$color}| ${icon}${percent}  %f"
}

function _negligible_time_segment() {
  print -r -- "%F{#90ee90}| $(date '+%H:%M:%S') %f"
}

function _negligible_right_prompt() {
  local parts
  parts="$(_negligible_root_segment)$(_negligible_dart_segment)$(_negligible_node_segment)$(_negligible_python_segment)$(_negligible_battery_segment)$(_negligible_time_segment)"
  print -r -- "$parts"
}

function _negligible_first_line() {
  local prompt_path git_segment left right left_plain right_plain left_width right_width columns usable_columns spaces padding
  prompt_path="$(_negligible_prompt_text "${(%):-%~}")"
  git_segment="$(_negligible_git_segment)"
  left="%F{cyan}$(_negligible_os_icon)%f%F{cyan} ${prompt_path} %f${git_segment}"
  right="$(_negligible_right_prompt)"

  if [[ -z "$right" ]]; then
    print -r -- "$left"
    return
  fi

  left_plain="$(_negligible_strip_prompt_escapes "$left")"
  right_plain="$(_negligible_strip_prompt_escapes "$right")"
  left_width="$(_negligible_display_width "$left_plain")"
  right_width="$(_negligible_display_width "$right_plain")"
  columns="${COLUMNS:-80}"
  usable_columns=$(( columns > 1 ? columns - 1 : columns ))

  if (( left_width + right_width + 1 < usable_columns )); then
    spaces=$(( usable_columns - left_width - right_width ))
    padding="$(printf "%${spaces}s" "")"
    print -r -- "${left}${padding}${right}"
  else
    print -r -- "${left} ${right}"
  fi
}

setopt PROMPT_SUBST

PROMPT='$(_negligible_first_line)
%(?.%F{#90ee90}.%F{red})➜ %f'

RPROMPT=''
