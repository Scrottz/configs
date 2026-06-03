# Promot
PS1='\[\e[90m\][ \[\e[32m\]\u\[\e[90m\]@\[\e[1;32m\]\h \[\e[90m\]: \[\e[0;36m\]\w \[\e[90m\]]\n\[\e[1;32m\]❯ \[\e[0m\]'

#tmux mainframe init

mainframe() {
    local session="mainframe"

    # Falls die Session noch nicht existiert, bauen wir sie jetzt auf
    if ! tmux has-session -t "$session" 2>/dev/null; then

        # 1. Die Session direkt im Home-Verzeichnis starten (~)
        tmux new-session -d -s "$session" -n "mainframe" -c ~

        # 2. Die Splits direkt nach dem Connect über run-shell abfeuern
        tmux run-shell -t "$session" '
            # Erzeugt das rechte Drittel (Pane 1) direkt in ~/code
            tmux split-window -h -c ~/code -t "mainframe";

            # Teilt das rechte Drittel das erste Mal (erzeugt Pane 2 darunter)
            tmux split-window -v -c ~/code -t "mainframe";

            # Teilt den unteren rechten Bereich nochmals (erzeugt Pane 3 ganz unten)
            tmux split-window -v -c ~/code -t "mainframe";

            # --- JETZT SIND WIR GANZ UNTEN RECHTS (Pane 3: Freies Terminal) ---
            # Hier läuft nichts, das bleibt dein freies Terminal für SSH etc.

            # Ein Panel nach oben springen (Mitte rechts: Pane 2) und htop starten
            tmux select-pane -U;
            tmux send-keys "htop" C-m;

            # Noch ein Panel nach oben springen (Oben rechts: Pane 1) und ncspot starten
            tmux select-pane -U;
            tmux send-keys "ncspot" C-m;

            # Fokus wieder ganz nach links auf das große Haupt-Arbeitsfenster setzen
            tmux select-pane -L;
        '
    fi

    # An die Session verknüpfen
    tmux attach-session -t "$session"
}

# alias für das globale config git repo [https://github.com/Scrottz/configs]
# config config --local status.showUntrackedFiles no -> nich einfach dumm alle datein im root auflisten bei dotfiles status
# neue files adden mit: dotfiles add PATH
alias dotfiles='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

