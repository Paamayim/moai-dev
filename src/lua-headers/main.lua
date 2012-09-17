----------------------------------------------------------------
-- Copyright (c) 2010-2011 Zipline Games, Inc. 
-- All Rights Reserved. 
-- http://getmoai.com
----------------------------------------------------------------

function dumpHeader ( filename, headername, outname )

	print ( filename )
	print ( headername )
	print ( outname )
	
	-- dump the function to Lua bytecode
	local compiled = string.dump ( loadfile ( filename ))
    
	-- write the header to a file
	local file = io.open ( outname, 'wb' )
    
    file:write(string.format("#ifndef _%s_H\n", headername))
    file:write(string.format("#define _%s_H\n\n", headername))
    
    file:write(string.format("#define %s_SIZE %d\n\n", headername, #compiled))
    file:write(string.format("unsigned char %s [] = {\n", headername))
    file:write("\t")
    
    for i = 1, #compiled do
        local byte = compiled:byte(i, i + 1)
    
        file:write(string.format("0x%02X, ", byte))
        
        if i % 12 == 0 then
            file:write("\n\t")
        end
    end
    
    file:write(string.format("\n};\n\n"))
    
    file:write(string.format("#endif\n"))
    
	file:close ()

end

dumpHeader ( 'moai.lua', 'moai_lua', 'moai_lua.h' )




