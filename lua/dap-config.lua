-- dap configuration
vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
vim.keymap.set('n', '<F13>', function() require('dap').disconnect() end)
vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
vim.keymap.set('n', '<leader>b', function() require('dap').toggle_breakpoint() end)
vim.keymap.set('n', '<leader>B', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end)
vim.keymap.set('n', '<leader>lp', function() require('dap').set_breakpoint(vim.fn.input('Log point message: ')) end)
vim.keymap.set('n', '<leader>dr', function() require('dap').repl.open() end)
vim.keymap.set('n', '<leader>dl', function() require('dap').run_last() end)

require("dapui").setup()
local dap, dapui = require("dap"), require("dapui")
dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

-- dau-ui configuration
vim.keymap.set('n', 'dt', function() require('dapui').toggle() end)
vim.keymap.set('n', 'do', function() require('dapui').open() end)
vim.keymap.set('n', '<leader>e', function() vim.diagnostic.open_float() end)

require("neodev").setup({
  library = { plugins = { "nvim-dap-ui" }, types = true },
  ...
})

require("dap-python").setup("python")
-- Kotlin DAP setup (nvim-dap-kotlin auto-configures the adapter)
require("dap-kotlin").setup({
	dap_command = "kotlin-debug-adapter",
	project_root = "${workspaceFolder}",
	enable_logging = false,
	log_file_path = "",
})

-- Append coroutine-friendly configs to the ones dap-kotlin already set up
-- (dap-kotlin.setup() already creates the adapter and base configurations)
local kotlin_configs = dap.configurations.kotlin or {}

-- Add coroutine debug launch config
table.insert(kotlin_configs, {
	type = "kotlin",
	request = "launch",
	name = "Launch with coroutine debug",
	mainClass = function()
		local root = vim.fs.find("src", { path = vim.uv.cwd(), upward = true, stop = vim.env.HOME })[1] or ""
		local fname = vim.api.nvim_buf_get_name(0)
		return fname:gsub(root, ""):gsub("main/kotlin/", ""):gsub(".kt", "Kt"):gsub("/", "."):sub(2, -1)
	end,
	projectRoot = "${workspaceFolder}",
	jsonLogFile = "",
	enableJsonLogging = false,
	-- Enable coroutine debug mode + stacktrace recovery for better coroutine stack frames
	-- Requires kotlinx-coroutines-debug on your project classpath.
	args = {
		"-Dkotlinx.coroutines.debug",
		"-Dkotlinx.coroutines.stacktrace.recovery=true",
		"-ea",
	},
})

-- Add attach-to-remote config (e.g. after: ./gradlew --info cleanTest test --debug-jvm)
table.insert(kotlin_configs, {
	type = "kotlin",
	request = "attach",
	name = "Attach to running JVM (port 5005)",
	projectRoot = vim.fn.getcwd(),
	hostName = "localhost",
	port = 5005,
	timeout = 10000,
})

dap.configurations.kotlin = kotlin_configs

-- Kotlin-specific DAP keymaps (only in .kt files)
vim.api.nvim_create_autocmd("FileType", {
	pattern = "kotlin",
	callback = function()
		vim.keymap.set('n', '<leader>dc', function()
			-- Dump coroutines to the REPL (requires kotlinx-coroutines-debug on classpath)
			local session = require('dap').session()
			if session then
				session:evaluate("kotlinx.coroutines.debug.DebugProbes.dumpCoroutines()", function(err, resp)
					if err then
						vim.notify("Coroutine dump failed: " .. tostring(err), vim.log.levels.WARN)
					else
						vim.notify("Coroutine dump sent to REPL", vim.log.levels.INFO)
					end
				end)
			else
				vim.notify("No active debug session", vim.log.levels.WARN)
			end
		end, { buffer = true, desc = "Dump coroutines (DAP)" })
	end,
})

require("dap-go").setup({
	dap_configurations = {
    {
      -- Must be "go" or it will be ignored by the plugin
      type = "go",
      name = "Attach remote",
      mode = "remote",
      request = "attach",
    },
  },
  -- delve configurations
  delve = {
    -- the path to the executable dlv which will be used for debugging.
    -- by default, this is the "dlv" executable on your PATH.
    path = "dlv",
    -- time to wait for delve to initialize the debug session.
    -- default to 20 seconds
    initialize_timeout_sec = 20,
    -- a string that defines the port to start delve debugger.
    -- default to string "${port}" which instructs nvim-dap
    -- to start the process in a random available port.
    -- if you set a port in your debug configuration, its value will be
    -- assigned dynamically.
    port = "${port}",
    -- additional args to pass to dlv
    args = {},
    -- the build flags that are passed to delve.
    -- defaults to empty string, but can be used to provide flags
    -- such as "-tags=unit" to make sure the test suite is
    -- compiled during debugging, for example.
    -- passing build flags using args is ineffective, as those are
    -- ignored by delve in dap mode.
    -- avaliable ui interactive function to prompt for arguments get_arguments
    build_flags = {},
    -- whether the dlv process to be created detached or not. there is
    -- an issue on Windows where this needs to be set to false
    -- otherwise the dlv server creation will fail.
    -- avaliable ui interactive function to prompt for build flags: get_build_flags
    detached = vim.fn.has("win32") == 0,
    -- the current working directory to run dlv from, if other than
    -- the current working directory.
    cwd = nil,
  },
  -- options related to running closest test
  tests = {
    -- enables verbosity when running the test.
    verbose = false,
  },
})
