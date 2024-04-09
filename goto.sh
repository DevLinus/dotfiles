#!/usr/bin/env bash
selected=`cat ~/.tmux-cht-languages ~/.tmux-cht-command ~/.tmux-cht-urls | fzf`

if [[ -z $selected ]]; then
	    exit 0
fi

if grep -qs "$selected" ~/.tmux-cht-urls; then
	    url=$(grep "$selected" ~/.tmux-cht-urls | cut -d':' -f2-)
	        if [[ -n $url ]]; then
			        cmd.exe /c start $url
				    else
					            echo "URL für '$selected' nicht gefunden."
						        fi
							    exit 0
fi

read -p "Enter Query: " query

if grep -qs "$selected" ~/.tmux-cht-languages; then
	    query=$(echo $query | tr ' ' '+')
	        tmux neww bash -c "echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
	else
		    tmux neww bash -c "curl -s cht.sh/$selected~$query | less"
fi

