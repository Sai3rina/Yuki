function _OnInit()
GameVersion = 0
print('Yuki')
end

function GetVersion() --Define anchor addresses
if (GAME_ID == 0xF266B00B or GAME_ID == 0xFAF99301) and ENGINE_TYPE == "ENGINE" then --PCSX2
	OnPC = false
	GameVersion = 1
	print('not offical supportet')
	Now = 0x032BAE0 --Current Location
	Obj0Pointer = 0x1D5BA10 --00objentry.bin Pointer Address
	Obj0 = ReadInt(Obj0Pointer)
elseif GAME_ID == 0x431219CC and ENGINE_TYPE == 'BACKEND' then --PC
	OnPC = true
	if ReadString(0x09A92F0,4) == 'KH2J' then --EGS
		GameVersion = 2
		print('Epic Version')
		Now = 0x0716DF8
		Obj0Pointer = 0x2A24A70
		Obj0 = ReadLong(Obj0Pointer)
	elseif ReadString(0x09A9830,4) == 'KH2J' then --Steam Global
		GameVersion = 3
		print('Steam Global Version')
		Now = 0x0717008
		Obj0Pointer = 0x2A24FB0
		Obj0 = ReadLong(Obj0Pointer)
	elseif ReadString(0x09A8830,4) == 'KH2J' then --Steam JP
		GameVersion = 4
		print('Steam JP Version')
		Now = 0x0716008
		Obj0Pointer = 0x2A23FB0
		Obj0 = ReadLong(Obj0Pointer)
	end
end
end

function _OnFrame()
if GameVersion == 0 then --Get anchor addresses
	GetVersion()
	return
end
if true then --Define current values for common addresses
	World  = ReadByte(Now+0x00)
	Room   = ReadByte(Now+0x01)
	Place  = ReadShort(Now+0x00)
	end
    CostumeSwap()
end

function CostumeSwap()
    if World == 0x07 then --Yuki Agrabah
        WriteString(Obj0+0x13f0,'P_EX100_AL\0',OnPC)
        WriteString(Obj0+0x4270,'H_EX500_AL\0',OnPC)
    elseif World == 0x10 then --Yuki Port Royal
        WriteString(Obj0+0x13f0,'P_EX100_PR\0',OnPC)
        WriteString(Obj0+0x4270,'H_EX500_PR\0',OnPC)
elseif Place == 0x1202 then --namine room
        WriteString(Obj0+0x13f0,'P_EX100_ME\0',OnPC)
    else --Revert costume changes
        WriteString(Obj0+0x13f0,'P_EX100\0',OnPC)
        WriteString(Obj0+0x4270,'H_EX500\0',OnPC)
    end
end