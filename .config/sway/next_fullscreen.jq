#!/usr/bin/jq -rf
.nodes[] |
select(.active?) |
{
    name,
    workspaces: (
        .nodes |
        map(
            .nodes |
            walk(
                if type=="object" then
                    if has("app_id") then
                        {
                            id, 
                            fullfocus: (.focused and .fullscreen_mode==1)
                        }
                    else
                        .nodes[]?
                    end
                else
                    .
                end
            )
        )
    )
} |
{
    name,
    next_window: (
        .workspaces[] |
        sort_by(.id) |
        map(.id, .fullfocus) |
        [index(true), length, .] |
        .[2][(.[0] + 1) % .[1]]
    )
} |
select(.next_window | type=="number") |
.name, .next_window
