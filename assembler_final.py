#This is the Assembler for the CPU 

#We open the text file containing our algorithm written in assembly language
assembly_code = open("assembly_code.txt", "r")

decimal_sequence = open("decimal_sequence.txt", "w")
hex_sequence = open("assembly_hex.hex", "w")

#Read assembly code
assembly_text = assembly_code.read()
assembly_list = assembly_text.split('\n')
assembly_code.close()
#print assembly_list

#We require a function to convert our machine code to decimal
def b2d(binary):
    decimal = str(int('0b'+binary,2))
    return decimal

#The assembler, which using our custom made ISA to convert assembly code to machine code
def decode2decimal(instruction_list):
    decimal_list=[]
    ISA = {
        'IDLE'      : '000000', #0
        'LDAC'      : '000011', #3
        'MOVACR'    : '000101', #5
        'MOVACR1'   : '000110', #6
        'MOVACR2'   : '000111', #7
        'MOVACR3'   : '001000', #8
        'MOVACR4'   : '001001', #9
        'MOVACR5'   : '001010', #10
        'MOVAC'     : '001011', #11
        'MOVRAC'    : '001100', #12
        'MOVR1AC'   : '001101', #13
        'MOVR2AC'   : '001110', #14
        'MOVR3AC'   : '001111', #15
        'MOVR4AC'   : '010000', #16
        'MOVR5AC'   : '010001', #17
        'STAC'      : '001011', #19
        'ADD'       : '000001', #20
        'SUB'       : '010110', #22
        'LSHIFT'    : '011000', #24
        'RSHIFT'    : '011010', #26
        'INCAC'     : '011100', #28
        'INCR1'     : '011110', #30
        'INCR2'     : '011111', #31
        'INCR3'     : '100000', #32
        'LDIAC'     : '100001', #33
        'JMPZ'      : '100011', #35
        'JPNZ'      : '100111', #39
        'JUMP'      : '101000', #40
        'NOP'       : '101001', #41
        'ENDOP'     : '101010', #42
        
    }
    N = 256 #First pixel for CONV to start is N+1
    
    F_CONV = (N*N-1)-(N+1) # Final pixel for CONV to end
                           # 65278 for N = 256
    F_SAMP = (N*N-1)-(N+1)-(N+1)-(N+1) # Final pixel for DOWN_SAMPLING to end
                                       # 64764 for N = 256
    
    #Jump commands
    JUMPZ1 = 129# To loop between rows of CONV
    JUMPZ2 = 138# To finish CONV and goto DOWN_SAMP
    JUMPZ3 = 171# To loop between rows of DOWN_SAMP
    JUMPZ4 = 186# To finish entire operation
    JUMP1 = 9  # To Loop CONV
    JUMP2 = 143 # To Loop DOWN_SAMP
    
    for instruction in instruction_list:
        if instruction in ISA:
            decimal_list.append("6\'d"+b2d(ISA[instruction]))
        elif instruction == "[Address of N+4]":
            decimal_list.append("16\'d"+str(N+4)) 
        elif instruction == "[Address of N+1]":
            decimal_list.append("16\'d"+str(N+1))
        elif instruction == "[Address of N]":
            decimal_list.append("16\'d"+str(N))
        elif instruction == "[Address of N-1]":
            decimal_list.append("8\'d"+str(N-1))
        elif instruction == "[Address of N-3]":
            decimal_list.append("8\'d"+str(N-3))
        elif instruction == "[Address of N-4]":
            decimal_list.append("8\'d"+str(N-4))
        elif instruction == "[Address of F_CONV]":
            decimal_list.append("16\'d"+str(F_CONV))
        elif instruction == "[Address of F_SAMP]":
            decimal_list.append("16\'d"+str(F_SAMP))
        else:
            decimal_list.append(str(instruction))
    return decimal_list

def decode2hex(instruction_list):
    hex_list=[]
    ISA = {
        'IDLE'      : '000000', #0
        'LDAC'      : '000011', #3
        'MOVACR'    : '000101', #5
        'MOVACR1'   : '000110', #6
        'MOVACR2'   : '000111', #7
        'MOVACR3'   : '001000', #8
        'MOVACR4'   : '001001', #9
        'MOVACR5'   : '001010', #10
        'MOVAC'     : '001011', #11
        'MOVRAC'    : '001100', #12
        'MOVR1AC'   : '001101', #13
        'MOVR2AC'   : '001110', #14
        'MOVR3AC'   : '001111', #15
        'MOVR4AC'   : '010000', #16
        'MOVR5AC'   : '010001', #17
        'STAC'      : '001011', #19
        'ADD'       : '000001', #20
        'SUB'       : '010110', #22
        'LSHIFT'    : '011000', #24
        'RSHIFT'    : '011010', #26
        'INCAC'     : '011100', #28
        'INCR1'     : '011110', #30
        'INCR2'     : '011111', #31
        'INCR3'     : '100000', #32
        'LDIAC'     : '100001', #33
        'JMPZ'      : '100011', #35
        'JPNZ'      : '100111', #39
        'JUMP'      : '101000', #40
        'NOP'       : '101001', #41
        'ENDOP'     : '101010', #42
    }
    N = 256 #First pixel for CONV to start is N+1
    
    F_CONV = (N*N-1)-(N+1) # Final pixel for CONV to end
                           # 65278 for N = 256
    F_SAMP = (N*N-1)-(N+1)-(N+1)-(N+1) # Final pixel for DOWN_SAMPLING to end
                                       # 64764 for N = 256
    
    for instruction in instruction_list:
        if instruction in ISA:
            hex_list.append(hex(int((ISA[instruction]), 2)))
        elif instruction == "[Address of N+4]":
            hex_list.append(hex(N+4)) 
        elif instruction == "[Address of N+1]":
            hex_list.append(hex(N+1))
        elif instruction == "[Address of N]":
            hex_list.append(hex(N))
        elif instruction == "[Address of N-1]":
            hex_list.append(hex(N-1))
        elif instruction == "[Address of N-3]":
            hex_list.append(hex(N-3))
        elif instruction == "[Address of N-4]":
            hex_list.append(hex(N-4))
        elif instruction == "[Address of F_CONV]":
            hex_list.append(hex(F_CONV))
        elif instruction == "[Address of F_SAMP]":
            hex_list.append(hex(F_SAMP))
        else:
            d = instruction.index('d')
            hex_list.append(hex(int(instruction[d+1:])))
    return hex_list

decimal_list = decode2decimal(assembly_list)
hex_list = decode2hex(assembly_list)

len_d = len(decimal_list)
len_h = len(hex_list)
print(len_h)
print(hex_list)
decimal_sequence.writelines(["%s\n"%value for value in decimal_list])
decimal_sequence.close()
hex_sequence.writelines(["%s\n"%value[2:] for value in hex_list])
hex_sequence.close()
