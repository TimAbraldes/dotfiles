in_wsl = os.getenv('WSL_DISTRO_NAME') ~= nil

if in_wsl then
    vim.g.clipboard = {
        name = 'wsl clipboard',
        copy =  { ["+"] = { "clip.exe" },   ["*"] = { "clip.exe" } },
        paste = { ["+"] = { "powershell.exe", "Get-Clipboard | tr -d '\r' | sed -z '$ s/\n$//'" }, ["*"] = { "powershell.exe", "Get-Clipboard | tr -d '\r' | sed -z '$ s/\n$//'" } },
        cache_enabled = true
    }
end

