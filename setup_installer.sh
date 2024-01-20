sudo pacman -S waybar alacritty rofi cliphs zathura sddm swalock dunst 

# If startship is not installed then install it
if ! command -v starship &> /dev/null
then
    echo "starship could not be found"
    echo "Installing starship"
    curl -sS https://starship.rs/install.sh | sh
fi
