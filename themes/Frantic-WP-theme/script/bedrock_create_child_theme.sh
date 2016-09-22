#!/bin/bash

# Checks the themes folder and offers the creation of a child theme
# based on Frantic-WP-theme

create_theme() {
    echo "creating"
    read -r -p "Write the name for your theme: " response

    echo "Create directory $response in $THEME_DIR"
    mkdir $THEME_DIR/$response
    cat <<EOF > $THEME_DIR/$response/style.css
/*
Theme Name:     $response
Author:         Frantic
Author URI:     http://frantic.com/
Template:       Frantic-WP-theme
Text Domain:    $response
Version:        1.0
*/
EOF
    cat <<EOF > $THEME_DIR/$response/functions.php
<?php
?>
EOF
    if which convert >/dev/null; then
        # In OSX make sure to install imagemagick with --with-fontconfig flag
        convert -background black -size 600x450 -fill "#FF69B4" \
            -pointsize 72 -gravity center label:$response \
            $THEME_DIR/$response/screenshot.png > /dev/null 2>&1
    else
        echo "Remember to put a nice screenshot"
    fi
}

THEME_DIR=web/app/themes
THEMES_COUNT=$(ls -l $THEME_DIR | grep -v total | wc -l | sed '/^$/d;s/[[:blank:]]//g')

if [[ "$THEMES_COUNT" -ne 1 ]]; then
    exit
fi

echo "Only one theme"
read -r -p "Do you want to create a new child theme based on Frantic-WP-theme? [y/N] " response

if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    create_theme
else
    echo "Nothing to do. Sorry for bothering you :-)"
fi
