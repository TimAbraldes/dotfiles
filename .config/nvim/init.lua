in_wsl = os.getenv('WSL_DISTRO_NAME') ~= nil

if in_wsl then
	vim.g.clipboard = {
		['name'] = 'WslClipboard',
		['copy'] = {
			['+'] = 'clip.exe',
			['*'] = 'clip.exe',
		},
		['paste'] = {
			['+'] = 'fish --command wsl_paste',
			['*'] = 'fish --command wsl_paste',
		},
		['cache_enabled'] = 0,
	}
end

-- bootstrap lazy.nvim and plugins
require("config.lazy")
