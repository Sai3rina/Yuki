function _OnInit()
    if (GAME_ID == 0xF266B00B or GAME_ID == 0xFAF99301) and ENGINE_TYPE == "ENGINE" then --PCSX2
        if ENGINE_VERSION < 3.0 then
            print('LuaEngine is Outdated. Things might not work properly.')
        end
        OnPC = false
        Now = 0x032BAE0 --Current Location
        Obj0 = 0x1C94100 --00objentry.bin
    elseif GAME_ID == 0x431219CC and ENGINE_TYPE == 'BACKEND' then --PC
        if ENGINE_VERSION < 5.0 then
            ConsolePrint('LuaBackend is Outdated. Things might not work properly.',2)
        end
        OnPC = true
        Now = 0x0714DB8 - 0x56454E
        Obj0 = 0x2A22B90 - 0x56450E
    end
end

function _OnFrame()
    if true then --Define current values for common addresses
        World  = ReadByte(Now+0x00)
        Room   = ReadByte(Now+0x01)
        Place  = ReadShort(Now+0x00)
    end
    CostumeSwap()
end

function CostumeSwap()
    if World == 0x07 then --Yuki Agrabah
        WriteString(Obj0+0x13f0,'P_EX100_AL\0')
    elseif World == 0x10 then --Yuki Port Royal
        WriteString(Obj0+0x13f0,'P_EX100_PR\0')
elseif Place == 0x1202 then --namine room
        WriteString(Obj0+0x13f0,'P_EX100_ME\0')
    else --Revert costume changes
        WriteString(Obj0+0x13f0,'P_EX100\0')
    end
end