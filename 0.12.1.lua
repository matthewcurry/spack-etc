help([[
This module, if needed, installs or updates Spack in ~/.spack-install, then loads
this version of Spack for the user.

Version 0.12.1
]])

whatis("Name: Spack")
whatis("Version: 0.12.1")
whatis("Category: System/Configuration")
whatis("Description: Spack package management")
whatis("URL: https://github.com/spack/spack")

local homedir = os.getenv("HOME")
-- Can set repo to upstream if you wish.
-- local repo_url = "https://github.com/spack/spack.git"
local repo_url = homedir .. "/spack-upstream"
local install_path = homedir .. "/.spack-install"

if (mode() == "load") then
   local t = os.execute("ls -d " .. install_path .. " 1>&2 2> /dev/null")

   if (t == 0) then
      io.stderr:write("Checking for updates, please wait...\n")
      t = os.execute("git -C " .. install_path .. " pull 1>&2 ")
      if (t ~= 0) then
      	 LmodError("git returned error code " .. t)
      end
   else
      io.stderr:write("Installing in " .. install_path .. ", please wait...\n")
      t = os.execute("git clone " .. repo_url .. " " .. install_path .. " 1>&2")

      if (t ~= 0) then
	 LmodError("git returned error code " .. t)
      end
   end   
end

set_alias("version", "0.12.1")
prepend_path("PATH", install_path .. "/bin")
prepend_path("MODULEPATH", install_path .. "/modules")

setenv("SPACK_DIR", install_path)
setenv("SPACK_BIN", install_path .. "/bin")
setenv("SPACK_LIB", install_path .. "/lib")

setenv("SPACK_ROOT", install_path)
