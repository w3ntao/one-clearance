# name: clearance
# ---------------
# Based on idan. Display the following bits on the left:
# - Virtualenv name (if applicable, see https://github.com/adambrenecki/virtualfish)
# - Current directory name
# - Git branch and dirty state (if inside a git repo)

function _git_branch_name
    echo (command git symbolic-ref HEAD 2> /dev/null | sed -e 's|^refs/heads/||')
end

function _git_is_dirty
    echo (command git status -s --ignore-submodules=dirty 2> /dev/null)
end

function fish_prompt
    set -l last_status $status

    set -l cyan (set_color cyan)
    set -l yellow (set_color yellow)
    set -l red (set_color red)
    set -l blue (set_color blue)
    set -l green (set_color green)
    set -l normal (set_color normal)
    set -l one_blue (set_color 5DC8FD)

    set -l turquoise (set_color 5fdfff)
    set -l hotpink (set_color df005f)
    set -l blue (set_color blue)
    set -l limegreen (set_color 87ff00)

    # Configure __fish_git_prompt
    set -g __fish_git_prompt_char_stateseparator ' '
    set -g __fish_git_prompt_color green
    set -g __fish_git_prompt_color_flags df5f00
    set -g __fish_git_prompt_color_prefix white
    set -g __fish_git_prompt_color_suffix white
    set -g __fish_git_prompt_showdirtystate true
    set -g __fish_git_prompt_showuntrackedfiles true
    set -g __fish_git_prompt_showstashstate true
    set -g __fish_git_prompt_show_informative_status true

    # Output the prompt, left to right

    # Add a newline before new prompts
    echo -e ''

    # Display [venvname] if in a virtualenv
    if set -q VIRTUAL_ENV
        echo -n -s (set_color -b cyan black) '[' (basename "$VIRTUAL_ENV") ']' $normal ' '
    end

    echo -n -s $one_blue(pwd | sed "s:^$HOME:~:")
    __fish_git_prompt " (%s)" $normal

    set -l prompt_color $red
    if test $last_status = 0
        set prompt_color $normal
    end

    # Terminate with a nice prompt char
    echo -e ''
    echo -e -n -s $prompt_color '❯ ' $normal
end
