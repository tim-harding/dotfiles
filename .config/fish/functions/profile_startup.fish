function profile_startup
    fish --profile-startup ~/temp/fish.profile --command exit
    sort -nk2 ~/temp/fish.profile
end
