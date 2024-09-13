switch (uname)
case Darwin
    set TEALDEER_CONFIG_DIR ~/Library/Application\ Support/tealdeer
    set TEALDEER_CONFIG "$TEALDEER_CONFIG_DIR/config.toml"
    mkdir $TEALDEER_CONFIG_DIR 
    rm $TEALDEER_CONFIG 
    ln -s ~/.config/tealdeer/config.toml $TEALDEER_CONFIG
end
