#!/usr/bin/env bash

PANE_PATH=$(tmux display-message -p -F "#{pane_current_path}" -t0)
cd $PANE_PATH

source $HOME/.tmux/plugins/helper.sh

function +vi-git-untracked() {
  
  local repoTopLevel="$(command git rev-parse --show-toplevel 2> /dev/null)"
  
  [[ $? != 0 || -z $repoTopLevel ]] && return

  local untrackedFiles=$(command git ls-files --others --exclude-standard "${repoTopLevel}" 2> /dev/null)

  [[ -z $untrackedFiles ]] && return

  local icon=$'\uF059'
  local theIcon=$(_decode_unicode_escapes "${icon-''}")

  printf "$theIcon "
}

function +vi-git-tagname() {
    local tag
    tag=$(command git describe --tags --exact-match HEAD 2>/dev/null)

    if [[ -n "${tag}" ]] ; then
        local icon=$'\uF02B '
        local theIcon=$(_decode_unicode_escapes "${icon-''}")
        printf "$theIcon$tag "
    fi
}

function +vi-vcs-detect-changes() {
    
    local remote=$(command git ls-remote --get-url 2> /dev/null)
    local icon=""

    if [[ "$remote" =~ "github" ]]; then
        icon=$'\uF113 '
    elif [[ "$remote" =~ "bitbucket" ]]; then
        icon=$'\uE703 '
    elif [[ "$remote" =~ "stash" ]]; then
        icon=$'\uE703 '
    elif [[ "$remote" =~ "gitlab" ]]; then
        icon=$'\uF296 '
    else
        icon=$'\uf1d3 '
    fi

    local theIcon=$(_decode_unicode_escapes "${icon-''}")

    printf "$theIcon"
}

function +vi-git-stash() {
  local stashes=$(git rev-list --walk-reflogs --count refs/stash)
  local icon=$'\uF01C '
  local theIcon=$(_decode_unicode_escapes "${icon-''}")
  if [ "$stashes" ]; then
    printf "$theIcon$stashes "
  fi
}

function +vi-git-unstaged() {
  local modified=$(git ls-files --others --exclude-standard --modified)
  local icon=$'\uF06A'
  local theIcon=$(_decode_unicode_escapes "${icon-''}")
  if [ "$modified" ]; then
    printf "$theIcon "
  fi
}

function +vi-git-staged() {
  local staged=$(git diff --cached)
  local icon=$'\uF055'
  local theIcon=$(_decode_unicode_escapes "${icon-''}")
  if [ "$staged" ]; then
    printf "$theIcon "
  fi
}

function +vi-git-aheadbehind() {
    local ahead behind
    local -a gitstatus

    ahead=$(command git rev-list --count "${hook_com[branch]}"@{upstream}..HEAD 2>/dev/null)
    local outgoing_icon=$'\uF01B '
    local outgoingChangesIcon=$(_decode_unicode_escapes "${outgoing_icon-''}")
    (( ahead )) && printf "$outgoingChangesIcon${ahead// /} "

    behind=$(command git rev-list --count HEAD.."${hook_com[branch]}"@{upstream} 2>/dev/null)
    local incoming_icon=$'\uF01A '
    local incomingChangesIcon=$(_decode_unicode_escapes "${incoming_icon-''}")
    (( behind )) && printf "$incomingChangesIcon${behind// /} "
}

git_status() {
  
  local branch_name=$(git rev-parse --abbrev-ref HEAD)
  local branch_icon=$'\uF126'
  local branchIcon=$(_decode_unicode_escapes "${branch_icon-''}")

  local vcsUntrackedIcon=$(+vi-git-untracked)
  local tagIcon=$(+vi-git-tagname)
  local vendorIcon=$(+vi-vcs-detect-changes)
  local stashIcon=$(+vi-git-stash)
  local unstagesIcon=$(+vi-git-unstaged)
  local stagedIcon=$(+vi-git-staged)
  local remoteChangesIcon=$(+vi-git-aheadbehind)
  
  local branch_has_changes=$(git diff-index --name-only HEAD --)
  local change_color='#94a96b'
  local label_color='#000000'
  
  if [ ${#branch_name} -gt "20" ]; then
    branch_name="${branch_name:0:20}..."
  fi

  if [ -n "$branch_has_changes" ]; then 
    change_color='#ffc107'
  fi

  if [[ -n $branch_name ]]; then
    printf " #[fg=colour252,bg=$change_color,nobold] #[fg=$label_color,bg=$change_color,nobold]$vendorIcon $branchIcon $branch_name $tagIcon$stagedIcon$unstagesIcon$vcsUntrackedIcon$remoteChangesIcon$stashIcon#[fg=$change_color,bg=colour233]"
  else 
    printf " #[fg=colour252,bg=colour233,nobold]"
  fi
}

main() {
  git_status
}

main
