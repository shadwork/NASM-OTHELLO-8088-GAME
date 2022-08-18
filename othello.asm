CPU 8086
                            ; 16 - bit COM file example
                            ; nasm othello.asm -fbin -o othello.com

                            %define COLOR_BLACK 0x0
                            %define COLOR_BLUE 0x1
                            %define COLOR_GREEN 0x2
                            %define COLOR_CYAN 0x3
                            %define COLOR_RED 0x4
                            %define COLOR_MAGENTA 0x5
                            %define COLOR_BROWN 0x6
                            %define COLOR_LIGHT_GRAY 0x7
                            %define COLOR_DARK_GRAY 0x8
                            %define COLOR_LIGHT_BLUE 0x9
                            %define COLOR_LIGHT_GREEN 0xA
                            %define COLOR_LIGHT_CYAN 0xB
                            %define COLOR_LIGHT_RED 0xC
                            %define COLOR_LIGHT_MAGENTA 0xD
                            %define COLOR_YELLOW 0xE
                            %define COLOR_WHITE 0xf

                            %define ATTR(a,b) ((a<<4)+b)
                            %define COLOR_DEFAULT ATTR(COLOR_BLUE,COLOR_WHITE)
                            %define COLOR_BLACK_WHITE ATTR(COLOR_BLACK,COLOR_WHITE)
                            %define COLOR_GREEN_BLACK ATTR(COLOR_GREEN,COLOR_BLACK)

                            %define INPUT_PASS 'P'
                            %define INPUT_QUIT 'Q'
                            %define INPUT_SWAP 'S'
                            %define INPUT_UNDO 'U'
                            %define INPUT_CANCEL 0x08
                            %define INPUT_ENTER 0x0D
                            %define INPUT_YES_CAP 'Y'
                            %define INPUT_YES 'y'
                            %define INPUT_NO_CAP 'N'
                            %define INPUT_NO 'n'

                            %define SCORE_STARTED_VALUE 2
                            %define MOVES_COUNTER_START_VALUE 60
                            %define MOVES_COUNTER_LEFT_VALUE MOVES_COUNTER_START_VALUE+1
                            %define BOARD_SIZE 10
                            %define BOARD_LENGTH BOARD_SIZE*BOARD_SIZE

org 100h
section .code

                            JMP ENTRY_POINT
TEXT_APPLICATION:           db "***   8 0 8 8   O T H E L L O   ***"
TEXT_APPLICATION_LEN:       equ $-TEXT_APPLICATION
TEXT_COPYRIGHT:             db "By M.W. Bayley     11/85 "
TEXT_COPYRIGHT_LEN:         equ $-TEXT_COPYRIGHT
TEXT_GAME_NAME:             db "*** 8088 OTHELLO ***"
TEXT_GAME_NAME_LEN:         equ $-TEXT_GAME_NAME
TEXT_LINE_14:               db "--------------------"
TEXT_LINE_14_LEN:           equ $-TEXT_LINE_14
TEXT_MOVES_LEFT:            db "60 Moves left"
TEXT_MOVES_LEFT_LEN:        equ $-TEXT_MOVES_LEFT
TEXT_HUMAN_SCORE:           db "[ ]  Human   : 02"
TEXT_HUMAN_SCORE_LEN:       equ $-TEXT_HUMAN_SCORE
TEXT_COMPUTER_SCORE:        db "[",0xFE,"]  Computer: 02" ;FEh = Black square
TEXT_COMPUTER_SCORE_LEN:    equ $-TEXT_COMPUTER_SCORE
TEXT_TIP_P_S:               db "P - PASS   S - SWITCH"
TEXT_TIP_P_S_LEN:           equ $-TEXT_TIP_P_S
TEXT_TIP_Q_U:               db "Q - QUIT   U - UNMOVE"
TEXT_TIP_Q_U_LEN:           equ $-TEXT_TIP_Q_U
TEXT_INPUT_LEVEL:           db "Enter play level"
TEXT_INPUT_LEVEL_LEN:       equ $-TEXT_INPUT_LEVEL
TEXT_LEVEL_HINT:            db "(1-5): "
TEXT_LEVEL_HINT_LEN:        equ $-TEXT_LEVEL_HINT
TEXT_ENTER_MOVE:            db "Enter your move Human!"
TEXT_ENTER_MOVE_LEN:        equ $-TEXT_ENTER_MOVE
TEXT_FOOLISH_HUMAN:         db "Foolish human"
TEXT_FOOLISH_HUMAN_LEN:     equ $-TEXT_FOOLISH_HUMAN
TEXT_WRONG_MOVE:            db "You cannot move there!"
TEXT_WRONG_MOVE_LEN:        equ $-TEXT_WRONG_MOVE
TEXT_YOU_CANT_PASS:         db "You cannot pass!"
TEXT_YOU_CANT_PASS_LEN:     equ $-TEXT_YOU_CANT_PASS
TEXT_COMP_MOVES_TO:         db "Computer moves to"
TEXT_COMP_MOVES_TO_LEN:     equ $-TEXT_COMP_MOVES_TO
TEXT_COMP_FORFAITS:         db "Computer forfeits"
TEXT_COMP_FORFAITS_LEN:     equ $-TEXT_COMP_FORFAITS
TEXT_COMP_TURN:             db "turn"
TEXT_COMP_TURN_LEN:         equ $-TEXT_COMP_TURN
TEXT_GAME_OVER:             db "* Game Over *"
TEXT_GAME_OVER_LEN:         equ $-TEXT_GAME_OVER
TEXT_COMPUTER_WIN:          db "I win!"
TEXT_COMPUTER_WIN_LEN:      equ $-TEXT_COMPUTER_WIN
TEXT_PLAYER_WIN:            db "You win!"
TEXT_PLAYER_WIN_LEN:        equ $-TEXT_PLAYER_WIN
TEXT_TIE_GAME:              db "Tie game"
TEXT_TIE_GAME_LEN:          equ $-TEXT_TIE_GAME
TEXT_PLAY_AGAIN:            db "Play again?"
TEXT_PLAY_AGAIN_LEN:        equ $-TEXT_PLAY_AGAIN
TEXT_QUIT:                  db "QUIT"
TEXT_QUIT_LEN:              equ $-TEXT_QUIT
TEXT_PASS:                  db "PASS"
TEXT_PASS_LEN:              equ $-TEXT_PASS
TEXT_UNMOVE:                db "UNMOVE"
TEXT_UNMOVE_LEN:            equ $-TEXT_UNMOVE
TEXT_SWAP:                  db "SWAP"
TEXT_SWAP_LEN:              equ $-TEXT_SWAP
TEXT_SPACE_24               db "                        "
TEXT_SPACE_24_LEN:          equ $-TEXT_SPACE_24

image_white:             db 0x2F
                         db 0x20,0xDC,0xDC,0xDC,0x20
                         db 0xDE,0xDB,0xDB,0xDB,0xDD
                         db 0x20,0xDF,0xDF,0xDF,0x20
image_black:             db 0x20
                         db 0x20,0xDC,0xDC,0xDC,0x20
                         db 0xDE,0xDB,0xDB,0xDB,0xDD
                         db 0x20,0xDF,0xDF,0xDF,0x20
image_empty:             db 0x2F
                         db 0x20,0x20,0x20,0x20,0x20
                         db 0x20,0x20,0x20,0x20,0x20
                         db 0x20,0x20,0x20,0x20,0x20
move_validator_pattern:  dw 0x0001
                         dw 0x000B
                         dw 0x000A
                         dw 0x0009
                         dw 0xFFFF
                         dw 0xFFF5
                         dw 0xFFF6
                         dw 0xFFF7
                         db 128 dup (0)
game_level:              db 0x00
variable_ct2:            db 0x00
blink_counter:           db 0x00
variable_zer:            db 0x00
moves_counter:           db 0x00
moves_left:              db 0x00
score_pc:                db 0x00
score_user:              db 0x00
                         db 8 dup (0)
variable_validmove:      db 0x00
time_seed:               dw 0h
counter_to_seven:        dw 0h
calc_buffer:             db 768 dup (0)
board_template:          db 0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x8F,0x80,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x80,0x8F,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
board_previous:          db 0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
board_previous_data:     db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
board_current:           db 0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
board_current_data:      db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
board_current_1:         db 0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
board_current_2:         db 0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
board_current_3:         db 0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
board_current_4:         db 0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
board_validate:          db 0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
board_copy:              db 0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00,0xFF
                         db 0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF,0xFF
board_calc_origin:       dw 0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff
                         dw 0xffff,0x0118,0x000d,0x001c,0x001b,0x001b,0x001c,0x000d,0x0118,0xffff
                         dw 0xffff,0x000d,0xffa6,0xfff7,0xfff6,0xfff6,0xfff7,0xffa6,0x000d,0xffff
                         dw 0xffff,0x001c,0xfff7,0x0002,0x0001,0x0001,0x0002,0xfff7,0x001c,0xffff
                         dw 0xffff,0x001b,0xfff6,0x0001,0x0002,0x0002,0x0001,0xfff6,0x001b,0xffff
                         dw 0xffff,0x001b,0xfff6,0x0001,0x0002,0x0002,0x0001,0xfff6,0x001b,0xffff
                         dw 0xffff,0x001c,0xfff7,0x0002,0x0001,0x0001,0x0002,0xfff7,0x001c,0xffff
                         dw 0xffff,0x000d,0xffa6,0xfff7,0xfff6,0xfff6,0xfff7,0xffa6,0x000d,0xffff
                         dw 0xffff,0x0118,0x000d,0x001c,0x001b,0x001b,0x001c,0x000d,0x0118,0xffff
                         dw 0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff
board_calc:              dw 0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff
board_calc_data:         dw 0xffff,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0xffff
                         dw 0xffff,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0xffff
                         dw 0xffff,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0xffff
                         dw 0xffff,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0xffff
                         dw 0xffff,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0xffff
                         dw 0xffff,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0xffff
                         dw 0xffff,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0xffff
                         dw 0xffff,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0x0000,0xffff
                         dw 0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff,0xffff
validators:              dw 0x0058,0xfff5
                         db 0x09
                         dw 0x0053,0xfff6
                         db 0x08
                         dw 0x0054,0xfff6
                         db 0x07
                         dw 0x0055,0xfff6
                         db 0x07
                         dw 0x0056,0xfff6
                         db 0x08
                         dw 0x0051,0xfff7
                         db 0x09
                         dw 0x0026,0xffff
                         db 0x08
                         dw 0x0030,0xffff
                         db 0x07
                         dw 0x003a,0xffff
                         db 0x07
                         dw 0x0044,0xffff
                         db 0x08
                         dw 0x001f,0x0001
                         db 0x08
                         dw 0x0029,0x0001
                         db 0x07
                         dw 0x0033,0x0001
                         db 0x07
                         dw 0x003d,0x0001
                         db 0x08
                         dw 0x0012,0x0009
                         db 0x09
                         dw 0x000d,0x000a
                         db 0x08
                         dw 0x000e,0x000a
                         db 0x07
                         dw 0x000f,0x000a
                         db 0x07
                         dw 0x0010,0x000a
                         db 0x08
                         dw 0x000b,0x000b
                         db 0x09
                         dw 0x0000,0x0000
                         db 0x00
stack:                   db 4096 dup (0)
ENTRY_POINT:             MOV AX,CS
                         MOV DS,AX
                         MOV ES,AX
                         MOV SS,AX
                         LEA SP,[ENTRY_POINT]
                         MOV AH,COLOR_DEFAULT
                         CALL FILL_SCREEN
                         MOV DH,0x9
                         MOV DL,0x16
                         LEA BX,[TEXT_APPLICATION]
                         MOV CX,TEXT_APPLICATION_LEN
                         CALL PRINT_TEXT
                         MOV DH,0xb
                         MOV DL,0x1c
                         LEA BX,[TEXT_COPYRIGHT]
                         MOV CX,TEXT_COPYRIGHT_LEN
                         CALL PRINT_TEXT
                         MOV DI,0x96
                         CALL DELAY_UI
                         CALL GET_SEED_BY_TIME
                         OR AX,0x0001
                         MOV [time_seed],AX
                         JMP START_GAME
                         NOP
EXIT_GAME:               MOV AH,COLOR_BLACK_WHITE
                         CALL FILL_SCREEN
                         MOV AL,0x0
                         MOV AH,0x4c
                         INT 0x21
                         ;EXIT - TERMINATE WITH RETURN CODE
START_GAME:              MOV AH,COLOR_DEFAULT
                         CALL FILL_SCREEN
                         MOV byte [moves_counter],MOVES_COUNTER_START_VALUE
                         MOV byte [moves_left],MOVES_COUNTER_LEFT_VALUE
                         MOV byte [score_pc],SCORE_STARTED_VALUE
                         MOV byte [score_user],SCORE_STARTED_VALUE
                         LEA SI,[board_template]
                         LEA DI,[board_previous]
                         MOV CX,BOARD_LENGTH
                         CLD
                         REP MOVSB
                         LEA SI,[board_template]
                         LEA DI,[board_current]
                         MOV CX,BOARD_LENGTH
                         REP MOVSB
                         LEA SI,[board_template]
                         LEA DI,[board_copy]
                         MOV CX,BOARD_LENGTH
                         REP MOVSB
                         LEA BX,[board_previous]
                         ;clear center cells
                         MOV byte [BX + 0x2c],0x00
                         MOV byte [BX + 0x2d],0x00
                         MOV byte [BX + 0x36],0x00
                         MOV byte [BX + 0x37],0x00
                         LEA SI,[board_calc_origin] ; from
                         LEA DI,[board_calc] ; to
                         MOV CX,BOARD_LENGTH
                         REP MOVSW
                         MOV DH,0x2
                         MOV DL,0x2
                         LEA BX,[TEXT_GAME_NAME] ;= "*** 8088 OTHELLO ***"
                         MOV CX,TEXT_GAME_NAME_LEN
                         CALL PRINT_TEXT
                         MOV DH,0x7
                         MOV DL,0x2
                         LEA BX,[TEXT_LINE_14] ;= "--------------------"
                         MOV CX,TEXT_LINE_14_LEN
                         CALL PRINT_TEXT
                         MOV DH,0xa
                         MOV DL,0x2
                         LEA BX,[TEXT_LINE_14] ;= "--------------------"
                         MOV CX,TEXT_LINE_14_LEN
                         CALL PRINT_TEXT
                         MOV DH,0xb
                         MOV DL,0x5
                         LEA BX,[TEXT_MOVES_LEFT] ;= "60 Moves left"
                         MOV CX,TEXT_MOVES_LEFT_LEN
                         CALL PRINT_TEXT
                         MOV DH,0xe
                         MOV DL,0x4
                         LEA BX,[TEXT_HUMAN_SCORE] ;= "[ ]  Human   : 02"
                         MOV CX,TEXT_HUMAN_SCORE_LEN
                         CALL PRINT_TEXT
                         MOV DH,0x10
                         MOV DL,0x4
                         LEA BX,[TEXT_COMPUTER_SCORE] ;= "[",0xFE,"]  Computer: 02"
                         MOV CX,TEXT_COMPUTER_SCORE_LEN
                         CALL PRINT_TEXT
                         MOV DH,0x14
                         MOV DL,0x2
                         LEA BX,[TEXT_TIP_P_S] ;= "P - PASS   S - SWITCH"
                         MOV CX,TEXT_TIP_P_S_LEN
                         CALL PRINT_TEXT
                         MOV DH,0x15
                         MOV DL,0x2
                         LEA BX,[TEXT_TIP_Q_U] ;= "Q - QUIT   U - UNMOVE"
                         MOV CX,TEXT_TIP_Q_U_LEN
                         CALL PRINT_TEXT
                         CALL PRINT_CELL_NAMES
                         CALL PRINT_CELL_IMAGES
                         JMP GAME_MAIN_LOOP
                         NOP
PRINT_CELL_NAMES:        MOV DH,0x0
                         MOV BL,0x18
PRINT_CELL_NAMES_FILL_X: MOV DL,0x18
                         MOV CX,0x0037
PRINT_CELL_NAMES_FILL_Y: MOV AL,0x20
                         MOV AH,COLOR_GREEN_BLACK
                         CALL PRINT_CHAR
                         INC DL
                         LOOP PRINT_CELL_NAMES_FILL_Y
                         INC DH
                         DEC BL
                         JNZ PRINT_CELL_NAMES_FILL_X
                         MOV DH,0x1
                         MOV BH,'A' ;start from "A"
                         MOV BL,'1' ;and number "1"
                         MOV CL,0x8
PRINT_CELL_NAMES_LOOP_X: MOV DL,0x1a
                         MOV CH,0x8
                         PUSH BX
                         PUSH DX
PRINT_CELL_NAMES_LOOP_Y: MOV AL,BH
                         MOV AH,COLOR_GREEN_BLACK
                         CALL PRINT_CHAR
                         INC DL
                         MOV AL,BL
                         MOV AH,COLOR_GREEN_BLACK
                         CALL PRINT_CHAR
                         ADD DL,0x6
                         INC BL
                         DEC CH
                         JNZ PRINT_CELL_NAMES_LOOP_Y
                         POP DX
                         POP BX
                         ADD DH,0x3
                         INC BH
                         DEC CL
                         JNZ PRINT_CELL_NAMES_LOOP_X
                         RET
GAME_MAIN_LOOP:          MOV DH,0x5
                         MOV DL,0x4
                         LEA BX,[TEXT_INPUT_LEVEL] ;= "Enter play level"
                         MOV CX,TEXT_INPUT_LEVEL_LEN
                         CALL PRINT_TEXT
                         MOV DH,0x6
                         MOV DL,0x8
                         LEA BX,[TEXT_LEVEL_HINT] ;= "(1-5): "
                         MOV CX,TEXT_LEVEL_HINT_LEN
                         CALL PRINT_TEXT
ENTER_LEVEL:             CALL READ_KEY
                         SUB AL,'0'
                         JBE ENTER_LEVEL
                         CMP AL,0x5
                         JA ENTER_LEVEL
                         MOV [game_level],AL
                         MOV DH,0x5
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         MOV DH,0x6
                         MOV DL,0x0
                         CALL CLEAR_LINE
READ_USER_INPUT:         MOV byte [variable_zer],0x0
                         MOV DH,0x5
                         MOV DL,0x1
                         LEA BX,[TEXT_ENTER_MOVE]
                         MOV CX,TEXT_ENTER_MOVE_LEN
                         CALL PRINT_TEXT
INPUT_BACKSPACED:        MOV DH,0x6
                         MOV DL,0xb
READ_KEYBOARD:           MOV AL,0x20
                         MOV AH,COLOR_DEFAULT
                         CALL PRINT_CHAR
                         CALL READ_KEY
                         CMP AL,INPUT_PASS
                         JNZ PLAYER_NOT_PASS
                         JMP USER_PASSED
PLAYER_NOT_PASS:         CMP AL,INPUT_QUIT
                         JNZ PLAYER_NOT_QUIT
                         MOV DH,0x6
                         MOV DL,0xa
                         LEA BX,[TEXT_QUIT] ;= "QUIT"
                         MOV CX,TEXT_QUIT_LEN
                         CALL PRINT_TEXT
QUIT_NOT_ACCEPTED:       CALL READ_KEY
                         CMP AL,INPUT_CANCEL
                         JNZ QUIT_NOT_CANCELED
                         MOV DH,0x5
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         MOV DH,0x6
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         JMP READ_USER_INPUT
QUIT_NOT_CANCELED:       CMP AL,INPUT_ENTER
                         JNZ QUIT_NOT_ACCEPTED
                         MOV DH,0x5
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         MOV DH,0x6
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         JMP LAB_0000_2509
PLAYER_NOT_QUIT:         CMP AL,INPUT_SWAP
                         JNZ PLAYER_NOT_SWITCH
                         MOV DH,0x6
                         MOV DL,0x9
                         LEA BX,[TEXT_SWAP] ;= "SWAP"
                         MOV CX,0x0004
                         CALL PRINT_TEXT
SWOP_NOT_ACCEPTED:       CALL READ_KEY
                         CMP AL,INPUT_CANCEL
                         JNZ SWOP_NOT_CANCELLED
                         MOV DH,0x5
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         MOV DH,0x6
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         JMP READ_USER_INPUT
SWOP_NOT_CANCELLED:      CMP AL,INPUT_ENTER
                         JNZ SWOP_NOT_ACCEPTED
                         MOV DH,0x5
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         MOV DH,0x6
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         MOV DH,0x8
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         MOV DH,0x9
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         LEA BX,[board_previous]
                         LEA DX,[board_current]
                         CALL COPY_AND_INVERT
                         LEA SI,[board_previous]
                         LEA DI,[board_copy]
                         MOV CX,BOARD_LENGTH
                         CLD
                         REP MOVSB
                         INC byte [moves_counter]
                         MOV AL,[moves_counter]
                         MOV [moves_left],AL
                         CALL COUNT_AND_PRINT_SCORE
                         CALL PRINT_CELL_IMAGES
                         JMP AFTER_SWOP
PLAYER_NOT_SWITCH:       CMP AL,INPUT_UNDO
                         JZ UNMOVE_SELECTED
                         JMP INPUT_ROW
UNMOVE_SELECTED:         MOV DH,0x6
                         MOV DL,0x9
                         LEA BX,[TEXT_UNMOVE] ;= "UNMOVE"
                         MOV CX,TEXT_UNMOVE_LEN
                         CALL PRINT_TEXT
UNMOVE_NOT_ACCEPTED:     CALL READ_KEY
                         CMP AL,INPUT_CANCEL
                         JNZ UNMOVE_NOT_CANCELED
                         MOV DH,0x5
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         MOV DH,0x6
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         JMP READ_USER_INPUT
UNMOVE_NOT_CANCELED:     CMP AL,INPUT_ENTER
                         JNZ UNMOVE_NOT_ACCEPTED
                         MOV DH,0x5
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         MOV DH,0x6
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         MOV DH,0x8
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         MOV DH,0x9
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         CALL PRINT_CELL_NAMES
                         LEA SI,[board_copy]
                         LEA DI,[board_current]
                         MOV CX,BOARD_LENGTH
                         CLD
                         REP MOVSB
                         LEA SI,[board_template]
                         LEA DI,[board_previous]
                         MOV CX,BOARD_LENGTH
                         REP MOVSB
                         LEA BX,[board_previous]
                         MOV byte [BX + 0x2c],0x0
                         MOV byte [BX + 0x2d],0x0
                         MOV byte [BX + 0x36],0x0
                         MOV byte [BX + 0x37],0x0
                         LEA BX,[board_template]
                         MOV AL,[moves_left]
                         MOV [moves_counter],AL
                         CALL COUNT_AND_PRINT_SCORE
                         CALL PRINT_CELL_IMAGES
                         JMP READ_USER_INPUT
INPUT_ROW:               CMP AL,'A' ; from A to H
                         JNC VALIDATE_ROW
                         JMP READ_KEYBOARD
VALIDATE_ROW:            CMP AL,'H'
                         JBE ROW_IN_RANGE
                         JMP READ_KEYBOARD
ROW_IN_RANGE:            MOV BH,AL
                         MOV AH,COLOR_DEFAULT
                         CALL PRINT_CHAR
                         INC DL
BACKSPACE_PRESSED:       MOV AL,' '
                         MOV AH,COLOR_DEFAULT
                         CALL PRINT_CHAR
INPUT_COLUMN:            CALL READ_KEY
                         CMP AL,INPUT_CANCEL
                         JNZ COLUMN_NOT_CANCELED
                         DEC DL
                         JMP INPUT_BACKSPACED
COLUMN_NOT_CANCELED:     CMP AL,'1' ; from 1 to 8
                         JC INPUT_COLUMN
                         CMP AL,'8'
                         JA INPUT_COLUMN
                         MOV BL,AL
                         MOV AH,COLOR_DEFAULT
                         CALL PRINT_CHAR
                         INC DL
                         MOV AL,' '
                         MOV AH,COLOR_DEFAULT
                         CALL PRINT_CHAR
MOVE_NOT_APPROVE:        CALL READ_KEY
                         CMP AL,INPUT_CANCEL
                         JNZ MOVE_NOT_DELETE
                         DEC DL
                         JMP BACKSPACE_PRESSED
MOVE_NOT_DELETE:         CMP AL,INPUT_ENTER
                         JNZ MOVE_NOT_APPROVE
                         SUB BH,0x40
                         SUB BL,0x30
                         MOV DX,BX
                         MOV AH,0x0
                         MOV AL,0xa
                         MUL DH
                         MOV DH,0x0
                         ADD AX,DX
                         PUSH AX
                         LEA BX,[board_previous]
                         LEA DX,[board_current]
                         CALL COPY_AND_INVERT
                         POP BX
                         XCHG BX,DX
                         CALL VALIDATE_MOVE
                         JC INVALID_MOVE
                         JMP VALID_MOVE
INVALID_MOVE:            MOV DH,0x8
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         MOV DH,0x9
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         MOV DH,0x8
                         MOV DL,0x5
                         LEA BX,[TEXT_FOOLISH_HUMAN] ;= "Foolish human"
                         MOV CX,TEXT_FOOLISH_HUMAN_LEN
                         CALL PRINT_TEXT
                         MOV DH,0x9
                         MOV DL,0x1
                         LEA BX,[TEXT_WRONG_MOVE] ;= "You cannot move there!"
                         MOV CX,TEXT_WRONG_MOVE_LEN
                         CALL PRINT_TEXT
                         MOV DI,0x64
                         CALL DELAY_UI
                         MOV DH,0x5
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         MOV DH,0x6
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         MOV DH,0x8
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         MOV DH,0x9
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         JMP READ_USER_INPUT
USER_PASSED:             MOV DH,0x6
                         MOV DL,0xa
                         LEA BX,[TEXT_PASS] ;= "PASS"
                         MOV CX,TEXT_PASS_LEN
                         CALL PRINT_TEXT
NOT_ENTERED:             CALL READ_KEY
                         CMP AL,INPUT_CANCEL
                         JNZ PLAYER_PASS
                         MOV DH,0x5
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         MOV DH,0x6
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         JMP READ_USER_INPUT
PLAYER_PASS:             CMP AL,INPUT_ENTER
                         JNZ NOT_ENTERED
                         CMP byte [moves_counter],MOVES_COUNTER_START_VALUE
                         JZ MOVES_IS_FULL
                         MOV DX,0x000a
                         MOV CX,0x0050
LOOP_BY_ROW:             PUSH CX
                         PUSH DX
                         LEA BX,[board_previous]
                         LEA DX,[board_current]
                         CALL COPY_AND_INVERT
                         LEA BX,[board_current]
                         POP DX
                         PUSH DX
                         CALL VALIDATE_MOVE
                         POP DX
                         POP CX
                         JNC WRONG_MOVE
                         LOOP LOOP_BY_ROW
MOVES_IS_FULL:           MOV DH,0x5
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         MOV DH,0x6
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         MOV DH,0x8
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         MOV DH,0x9
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         MOV byte [variable_zer],0xff
                         JMP AFTER_SWOP
WRONG_MOVE:              MOV DH,0x8
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         MOV DH,0x9
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         MOV DH,0x8
                         MOV DL,0x5
                         LEA BX,[TEXT_FOOLISH_HUMAN] ;= "Foolish human"
                         MOV CX,TEXT_FOOLISH_HUMAN_LEN
                         CALL PRINT_TEXT
                         MOV DH,0x9
                         MOV DL,0x4
                         LEA BX,[TEXT_YOU_CANT_PASS] ;= "You cannot pass!"
                         MOV CX,TEXT_YOU_CANT_PASS_LEN
                         CALL PRINT_TEXT
                         MOV DI,0x64
                         CALL DELAY_UI
                         MOV DH,0x5
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         MOV DH,0x6
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         MOV DH,0x8
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         MOV DH,0x9
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         JMP READ_USER_INPUT
VALID_MOVE:              LEA SI,[board_previous]
                         LEA DI,[board_copy]
                         MOV CX,BOARD_LENGTH
                         CLD
                         REP MOVSB
                         MOV AL,[moves_counter]
                         INC AL
                         MOV [moves_left],AL
                         LEA BX,[board_current]
                         LEA DX,[board_current]
                         CALL COPY_AND_INVERT
                         CALL COUNT_AND_PRINT_SCORE
                         CALL MOVE_ANIMATION
                         MOV DH,0x5
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         MOV DH,0x6
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         MOV DH,0x8
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         MOV DH,0x9
                         MOV DL,0x0
                         CALL CLEAR_LINE
AFTER_SWOP:              MOV AL,[game_level]
                         MOV [variable_ct2],AL
                         LEA BX,[board_previous]
                         LEA DI,[calc_buffer]
                         CALL COMP_CALC_MOVE
                         CMP word [SI],0x0
                         JNZ COMP_LOOSE_MOVE
                         MOV DH,0x8
                         MOV DL,0x3
                         LEA BX,[TEXT_COMP_FORFAITS] ;= "Computer forfeits"
                         MOV CX,TEXT_COMP_FORFAITS_LEN
                         CALL PRINT_TEXT
                         MOV DH,0x9
                         MOV DL,0xa
                         LEA BX,[TEXT_COMP_TURN] ;= "turn"
                         MOV CX,TEXT_COMP_TURN_LEN
                         CALL PRINT_TEXT
                         JMP READ_USER_INPUT
COMP_LOOSE_MOVE:         MOV DX,word [SI + 0x2]
                         PUSH DX
                         MOV DH,0x8
                         MOV DL,0x3
                         LEA BX,[TEXT_COMP_MOVES_TO] ;= "Computer moves to"
                         MOV CX,TEXT_COMP_MOVES_TO_LEN
                         CALL PRINT_TEXT
                         POP BX
                         PUSH BX
                         MOV DH,0x9
                         MOV DL,0xb
                         MOV AL,BL
                         MOV AH,0x0
                         MOV BH,0xa
                         DIV BH
                         PUSH AX
                         ADD AL,0x40
                         MOV AH,COLOR_DEFAULT
                         CALL PRINT_CHAR
                         POP AX
                         INC DL
                         MOV AL,AH
                         ADD AL,0x30
                         MOV AH,COLOR_DEFAULT
                         CALL PRINT_CHAR
                         LEA SI,[board_previous]
                         LEA DI,[board_current]
                         MOV CX,BOARD_LENGTH
                         CLD
                         REP MOVSB
                         LEA BX,[board_current]
                         POP DX
                         CALL VALIDATE_MOVE
                         CALL COUNT_AND_PRINT_SCORE
                         CALL MOVE_ANIMATION
                         JMP READ_USER_INPUT
COMP_CALC_MOVE:          PUSH BX
                         PUSH DI
                         ADD DI,0x30
                         PUSH DI
                         MOV DX,0x000a
                         MOV CX,0x0050
LAB_0000_216e:           PUSH BX
                         PUSH CX
                         PUSH DX
                         PUSH DI
                         MOV SI,BX
                         MOV DI,BX
                         ADD DI,0x64
                         PUSH DI
                         MOV CX,BOARD_LENGTH
                         CLD
                         REP MOVSB
                         POP BX
                         POP DI
                         PUSH DI
                         MOV word [DI],0x0
                         MOV word [DI + 0x2],DX
                         MOV word [DI + 0x4],0x0
                         CALL VALIDATE_MOVE
                         JC LAB_0000_21e6
                         MOV word [DI],0xffff
                         MOV DX,0x000a
                         MOV CX,0x0050
LAB_0000_219e:           PUSH BX
                         PUSH CX
                         PUSH DX
                         PUSH DI
                         LEA DX,[board_validate]
                         CALL COPY_AND_INVERT
                         POP DI
                         POP DX
                         PUSH DX
                         PUSH DI
                         LEA BX,[board_validate]
                         CALL VALIDATE_MOVE
                         MOV BX,0xffff
                         JC LAB_0000_21c9
                         LEA BX,[board_validate]
                         MOV DX,BX
                         CALL COPY_AND_INVERT
                         LEA BX,[board_validate]
                         CALL SUB_0000_230a
LAB_0000_21c9:           POP DI
                         POP DX
                         CMP BX,word [DI]
                         JNC LAB_0000_21d4
                         MOV word [DI],BX
                         MOV word [DI + 0x4],DX
LAB_0000_21d4:           POP CX
                         POP BX
                         INC DX
                         LOOP LAB_0000_219e
                         CMP word [DI],-0x1
                         JNZ LAB_0000_21e6
                         CALL SUB_0000_230a
                         ADD BX,BOARD_LENGTH
                         MOV word [DI],BX
LAB_0000_21e6:           POP DI
                         POP DX
                         POP CX
                         POP BX
                         INC DX
                         ADD DI,0x6
                         DEC CX
                         JZ LAB_0000_21f4
                         JMP LAB_0000_216e
LAB_0000_21f4:           POP DI
LAB_0000_21f5:           MOV DX,0x0000
                         MOV CX,0x004f
                         PUSH DI
LAB_0000_21fc:           MOV AX,word [DI]
                         CMP AX,word [DI + 0x6]
                         JNC LAB_0000_2226
                         MOV DX,word [DI + 0x6]
                         MOV word [DI],DX
                         MOV word [DI + 0x6],AX
                         MOV AX,word [DI + 0x2]
                         MOV DX,word [DI + 0x8]
                         MOV word [DI + 0x2],DX
                         MOV word [DI + 0x8],AX
                         MOV AX,word [DI + 0x4]
                         MOV DX,word [DI + 0xa]
                         MOV word [DI + 0x4],DX
                         MOV word [DI + 0xa],AX
                         MOV DX,0xffff
LAB_0000_2226:           ADD DI,0x6
                         LOOP LAB_0000_21fc
                         POP DI
                         CMP DX,0x0000
                         JNZ LAB_0000_21f5
                         DEC byte [variable_ct2]
                         JZ LAB_0000_228b
                         PUSH BX
                         PUSH DI
                         MOV CX,0x0008
LAB_0000_223c:           CMP word [DI],0x0
                         JZ LAB_0000_2289
                         PUSH BX
                         PUSH CX
                         PUSH DI
                         MOV DI,BX
                         ADD DI,0x64
                         PUSH DI
                         MOV CX,BOARD_LENGTH
                         CLD
                         REP MOVSB
                         MOV AX,0x0008
                         SUB AX,CX
                         POP BX
                         POP DI
                         PUSH DI
                         MOV DX,word [DI + 0x2]
                         CALL VALIDATE_MOVE
                         MOV DX,BX
                         CALL COPY_AND_INVERT
                         MOV DX,word [DI + 0x4]
                         CALL VALIDATE_MOVE
                         MOV DX,BX
                         CALL COPY_AND_INVERT
                         CALL COMP_CALC_MOVE
                         CMP word [SI],0x0
                         JNZ LAB_0000_227d
                         MOV word [DI],0x1
                         JMP LAB_0000_2281
                         NOP
LAB_0000_227d:           MOV AX,word [SI]
                         MOV word [DI],AX
LAB_0000_2281:           POP DI
                         POP CX
                         POP BX
                         ADD DI,0x6
                         LOOP LAB_0000_223c
LAB_0000_2289:           POP DI
                         POP BX
LAB_0000_228b:           MOV DX,0x0000
                         MOV CX,0x0007
                         PUSH DI
LAB_0000_2292:           MOV AX,word [DI]
                         CMP AX,word [DI + 0x6]
                         JNC LAB_0000_22bc
                         MOV DX,word [DI + 0x6]
                         MOV word [DI],DX
                         MOV word [DI + 0x6],AX
                         MOV AX,word [DI + 0x2]
                         MOV DX,word [DI + 0x8]
                         MOV word [DI + 0x2],DX
                         MOV word [DI + 0x8],AX
                         MOV AX,word [DI + 0x4]
                         MOV DX,word [DI + 0xa]
                         MOV word [DI + 0x4],DX
                         MOV word [DI + 0xa],AX
                         MOV DX,0xffff
LAB_0000_22bc:           ADD DI,0x6
                         LOOP LAB_0000_2292
                         POP DI
                         CMP DX,0x0000
                         JNZ LAB_0000_228b
                         MOV word [counter_to_seven],0x0
                         MOV SI,DI
                         CMP word [SI],0x0
                         JZ LAB_0000_2307
                         PUSH SI
                         MOV AX,word [SI]
                         MOV CX,0x0008
LAB_0000_22da:           CMP word [SI],AX
                         JNZ LAB_0000_22e2
                         INC word [counter_to_seven]
LAB_0000_22e2:           ADD SI,0x6
                         LOOP LAB_0000_22da
LAB_0000_22e7:           CALL SUB_0000_25c6
                         SHR BX,0x0001
                         SHR BX,0x0001
                         SHR BX,0x0001
                         SHR BX,0x0001
                         AND BX,strict word 0x0007
                         CMP BX,word [counter_to_seven]
                         JNC LAB_0000_22e7
                         MOV SI,BX
                         ADD BX,BX
                         ADD BX,SI
                         ADD BX,BX
                         POP SI
                         ADD SI,BX
LAB_0000_2307:           POP DI
                         POP BX
                         RET
SUB_0000_230a:           PUSH CX
                         PUSH SI
                         PUSH DI
                         ADD BX,0x000a
                         LEA SI,[board_calc_data]
                         MOV CX,0x0050
                         MOV DI,0x0
LAB_0000_231a:           CMP byte [BX],0x8f
                         JNZ LAB_0000_2324
                         ADD DI,word [SI]
                         JMP LAB_0000_232b
                         NOP
LAB_0000_2324:           CMP byte [BX],0x80
                         JNZ LAB_0000_232b
                         SUB DI,word [SI]
LAB_0000_232b:           INC BX
                         ADD SI,0x2
                         LOOP LAB_0000_231a
                         ADD DI,0x7d0
                         MOV BX,DI
                         POP DI
                         POP SI
                         POP CX
                         RET
COPY_AND_INVERT:         PUSH BX
                         PUSH CX
                         MOV SI,DX
                         MOV CX,BOARD_LENGTH
LAB_0000_2342:           MOV AL,byte [BX]
                         CMP AL,0x0
                         JZ LAB_0000_234e
                         CMP AL,0xff
                         JZ LAB_0000_234e
                         XOR AL,0xf
LAB_0000_234e:           MOV byte [SI],AL
                         INC BX
                         INC SI
                         LOOP LAB_0000_2342
                         POP CX
                         POP BX
                         RET
VALIDATE_MOVE:           PUSH BX
                         PUSH DX
                         PUSH CX
                         MOV byte [variable_validmove],0xff
                         ADD BX,DX
                         CMP byte [BX],0x0
                         JNZ LAB_0000_23ac
                         MOV byte [BX],0x8f
                         MOV CX,0x0008
                         LEA SI,[move_validator_pattern]
MOVE_VALIDATION:         PUSH BX
                         MOV DX,word [SI]
                         ADD BX,DX
                         CMP byte [BX],0x80
                         JNZ LAB_0000_239c
LAB_0000_237a:           ADD BX,DX
                         CMP byte [BX],0x8f
                         JZ LAB_0000_2389
                         CMP byte [BX],0x80
                         JZ LAB_0000_237a
                         JMP LAB_0000_239c
                         NOP
LAB_0000_2389:           POP BX
                         PUSH BX
                         MOV byte [variable_validmove],0x0
LAB_0000_2390:           ADD BX,DX
                         CMP byte [BX],0x8f
                         JZ LAB_0000_239c
                         MOV byte [BX],0x8f
                         JMP LAB_0000_2390
LAB_0000_239c:           POP BX
                         ADD SI,0x2
                         LOOP MOVE_VALIDATION
                         CMP byte [variable_validmove],0x0
                         JZ LAB_0000_23ac
                         MOV byte [BX],0x0
LAB_0000_23ac:           POP CX
                         POP DX
                         POP BX
                         CMP byte [variable_validmove],0x0
                         JZ LAB_0000_23b7
                         STC
LAB_0000_23b7:           RET
MOVE_ANIMATION:          MOV byte [blink_counter],0x8
PRINT_CELL_IMAGES:       LEA BX,[board_previous_data]
                         LEA SI,[board_current_data]
                         MOV CH,0x10
                         MOV CL,0x50
LAB_0000_23c9:           MOV AL,byte [SI]
                         CMP AL,byte [BX]
                         JZ PRINT_CELL_IMAGES_EQUAL
                         CMP byte [blink_counter],0x0
                         JNZ LAB_0000_23d8
                         MOV byte [BX],AL
LAB_0000_23d8:           PUSH BX
                         PUSH DX
                         PUSH CX
                         MOV BX,0x0019
                         MOV DX,0x0300
                         MOV CL,AL
                         MOV AL,CH
                         ROR AL,0x1
                         ROR AL,0x1
                         ROR AL,0x1
                         ROR AL,0x1
                         AND AL,0xf
                         DEC AL
                         JZ LAB_0000_23f9
LAB_0000_23f3:           ADD BX,DX
                         DEC AL
                         JNZ LAB_0000_23f3
LAB_0000_23f9:           MOV DX,0x0007
                         MOV AL,CH
                         AND AL,0xf
                         DEC AL
                         JZ LAB_0000_240a
LAB_0000_2404:           ADD BX,DX
                         DEC AL
                         JNZ LAB_0000_2404
LAB_0000_240a:           XCHG DX,BX
                         LEA BX,[image_empty]
                         MOV AL,[blink_counter]
                         AND AL,0x1
                         JNZ LAB_0000_2425
                         LEA BX,[image_black]
                         MOV AL,CL
                         AND AL,0xf
                         JZ LAB_0000_2425
                         LEA BX,[image_white]
LAB_0000_2425:           MOV AH,byte [BX]
                         INC BX
                         MOV CH,0x3
LAB_0000_242a:           PUSH CX
                         PUSH DX
                         MOV CL,0x5
LAB_0000_242e:           MOV AL,byte [BX]
                         CALL PRINT_CHAR
                         INC DL
                         INC BX
                         DEC CL
                         JNZ LAB_0000_242e
                         POP DX
                         POP CX
                         INC DH
                         DEC CH
                         JNZ LAB_0000_242a
                         POP CX
                         POP DX
                         POP BX
PRINT_CELL_IMAGES_EQUAL: INC BX
                         INC SI
                         MOV AL,CH
                         ADD AL,0x1
                         DAA
                         MOV CH,AL
                         DEC CL
                         JZ LAB_0000_2455
                         JMP LAB_0000_23c9
LAB_0000_2455:           CMP byte [blink_counter],0x00
                         JZ LAB_0000_2469
                         DEC byte [blink_counter]
                         MOV DI,0x2
                         CALL DELAY_UI
                         JMP PRINT_CELL_IMAGES
LAB_0000_2469:           LEA BX,[board_previous]
                         LEA SI,[validators]
LAB_0000_2471:           MOV DX,word [SI]
                         ADD SI,0x2
                         MOV CX,word [SI]
                         ADD SI,0x2
                         MOV AL,byte [SI]
                         INC SI
                         CMP AL,0x0
                         JZ LAB_0000_24a1
                         PUSH BX
                         ADD BX,DX
                         MOV AH,byte [BX]
                         AND AH,0x80
                         JZ LAB_0000_249e
                         LEA BX,[board_calc]
                         ADD BX,DX
                         ADD BX,DX
                         ADD BX,CX
                         ADD BX,CX
                         MOV byte [BX],AL
                         INC BX
                         MOV byte [BX],0x0
LAB_0000_249e:           POP BX
                         JMP LAB_0000_2471
LAB_0000_24a1:           CMP byte [moves_counter],0x0
                         JNZ LAB_0000_24ab
                         JMP LAB_0000_2509
                         NOP
LAB_0000_24ab:           CMP byte [score_pc],0x0
                         JNZ LAB_0000_24b5
                         JMP LAB_0000_2509
                         NOP
LAB_0000_24b5:           CMP byte [score_user],0x0
                         JNZ LAB_0000_24bf
                         JMP LAB_0000_2509
                         NOP
LAB_0000_24bf:           RET
COUNT_AND_PRINT_SCORE:   DEC byte [moves_counter]
                         LEA BX,[board_current]
                         MOV DX,0x0000
                         MOV CX,BOARD_LENGTH
LAB_0000_24ce:           CMP byte [BX],0x80
                         JNZ LAB_0000_24d8
                         INC DH
                         JMP LAB_0000_24df
                         NOP
LAB_0000_24d8:           CMP byte [BX],0x8f
                         JNZ LAB_0000_24df
                         INC DL
LAB_0000_24df:           INC BX
                         LOOP LAB_0000_24ce
                         MOV byte [score_pc],DH
                         MOV byte [score_user],DL
                         MOV DH,0xb
                         MOV DL,0x5
                         MOV AL,[moves_counter]
                         CALL PRINT_NUMBER
                         MOV DH,0xe
                         MOV DL,0x13
                         MOV AL,[score_pc]
                         CALL PRINT_NUMBER
                         MOV DH,0x10
                         MOV DL,0x13
                         MOV AL,[score_user]
                         CALL PRINT_NUMBER
                         RET
LAB_0000_2509:           MOV DH,0x5
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         MOV DH,0x6
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         MOV DH,0x5
                         MOV DL,0x5
                         LEA BX,[TEXT_GAME_OVER] ;= "* Game Over *"
                         MOV CX,TEXT_GAME_OVER_LEN
                         CALL PRINT_TEXT
                         MOV AL,[score_user]
                         CMP AL,byte [score_pc]
                         JZ TIE_GAME
                         JL PLAYER_WIN
                         MOV DH,0x6
                         MOV DL,0x9
                         LEA BX,[TEXT_COMPUTER_WIN] ;= "I win!"
                         MOV CX,TEXT_COMPUTER_WIN_LEN
                         CALL PRINT_TEXT
                         JMP PLAY_AGAINE
                         NOP
PLAYER_WIN:              MOV DH,0x6
                         MOV DL,0x8
                         LEA BX,[TEXT_PLAYER_WIN] ;= "You win!"
                         MOV CX,TEXT_PLAYER_WIN_LEN
                         CALL PRINT_TEXT
                         JMP PLAY_AGAINE
                         NOP
TIE_GAME:                MOV DH,0x6
                         MOV DL,0x7
                         LEA BX,[TEXT_TIE_GAME] ;= "Tie game"
                         MOV CX,TEXT_TIE_GAME_LEN
                         CALL PRINT_TEXT
PLAY_AGAINE:             MOV DH,0x8
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         MOV DH,0x9
                         MOV DL,0x0
                         CALL CLEAR_LINE
                         MOV DH,0x8
                         MOV DL,0x6
                         LEA BX,[TEXT_PLAY_AGAIN]
                         MOV CX,TEXT_PLAY_AGAIN_LEN
                         CALL PRINT_TEXT
                         MOV DH,0x9
                         MOV DL,0xb
                         MOV AL,0x20
                         MOV AH,COLOR_DEFAULT
                         CALL PRINT_CHAR
PRESS_ANOTHER:           CALL READ_KEY
                         CMP AL,INPUT_YES_CAP
                         JZ PRESS_YES
                         CMP AL,INPUT_YES
                         JNZ PRESS_NOT_YES
PRESS_YES:               JMP START_GAME
PRESS_NOT_YES:           CMP AL,INPUT_NO_CAP
                         JZ PRESS_NO
                         CMP AL,INPUT_NO
                         JNZ PRESS_ANOTHER
PRESS_NO:                JMP EXIT_GAME
PRINT_NUMBER:            MOV AH,0x0
                         MOV BL,0xa
                         DIV BL
                         ADD AL,'0'
                         PUSH AX
                         MOV AH,COLOR_DEFAULT
                         CALL PRINT_CHAR
                         POP AX
                         INC DL
                         MOV AL,AH
                         ADD AL,0x30
                         MOV AH,COLOR_DEFAULT
                         CALL PRINT_CHAR
                         RET
DELAY_UI:                PUSH CX ; DI - time in pseudo-cycle
DELAY_UI_LOOP_OUT:       MOV CX,0x12c0
DELAY_UI_LOOP:           LOOP DELAY_UI_LOOP
                         DEC DI
                         JNZ DELAY_UI_LOOP_OUT
                         POP CX
                         RET
SUB_0000_25c6:           MOV AX,[time_seed]
                         SHR AX,0x0001
                         MOV BX,AX
                         ADD BX,BX
                         ADD BX,BX
                         ADD BX,AX
                         MOV word [time_seed],BX
                         RET
FILL_SCREEN:             PUSH ES ; AH - attributes to fill
                         PUSH DS
                         PUSH SI
                         PUSH DI
                         PUSH DX
                         PUSH CX
                         PUSH BX
                         MOV BH,0x0
                         MOV DH,0x0
                         MOV DL,0x0
                         PUSH AX
                         MOV AH,0x2
                         INT 0x10
                         ;VIDEO - SET CURSOR POSITION
                         ;AH = 0x02
                         ;BH = page number
                         ;0-3 in modes 2&3
                         ;0-7 in modes 0&1
                         ;0 in graphics modes
                         ;DH = row (00h is top)
                         ;DL = column (00h is left)
                         POP AX
                         MOV BL,AH
                         MOV AL,0x20
                         MOV CX,0x0780
                         MOV AH,0x9
                         INT 0x10
                         ;VIDEO - WRITE CHARACTER AND ATTRIBUTE AT CURSOR POSITION
                         ;AH = 0x09
                         ;AL = character to display
                         ;BH = page number (00h to number of pages - 1) (see #00010)
                         ;background color in 256-color graphics modes (ET4000)
                         ;BL = attribute (text mode) or color (graphics mode)
                         ;if bit 7 set in <256-color graphics mode, character is XOR'ed
                         ;onto screen
                         ;CX = number of times to write character
                         MOV BH,0x0
                         MOV DH,0x18
                         MOV DL,0x0
                         MOV AH,0x2
                         INT 0x10
                         ;VIDEO - SET CURSOR POSITION
                         MOV BL,0x0
                         MOV AL,0x20
                         MOV CX,0x0050
                         MOV AH,0x9
                         INT 0x10
                         ;VIDEO - WRITE CHARACTER AND ATTRIBUTE AT CURSOR POSITION
                         POP BX
                         POP CX
                         POP DX
                         POP DI
                         POP SI
                         POP DS
                         POP ES
                         RET
PRINT_CHAR:              PUSH ES
                         PUSH DS
                         PUSH SI
                         PUSH DI
                         PUSH DX
                         PUSH CX
                         PUSH BX
                         PUSH AX
                         MOV BH,0x0
                         MOV AH,0x2
                         INT 0x10
                         ;VIDEO - SET CURSOR POSITION
                         POP AX
                         PUSH AX
                         MOV BL,AH
                         MOV CX,0x0001
                         MOV AH,0x9
                         INT 0x10
                         ;VIDEO - WRITE CHARACTER AND ATTRIBUTE AT CURSOR POSITION
                         POP AX
                         POP BX
                         POP CX
                         POP DX
                         POP DI
                         POP SI
                         POP DS
                         POP ES
                         RET
CLEAR_LINE:              PUSH ES
                         PUSH DS
                         PUSH SI
                         PUSH DI
                         PUSH DX
                         PUSH CX
                         PUSH BX
                         MOV BH,0x0
                         MOV AH,0x2
                         INT 0x10
                         ;VIDEO - SET CURSOR POSITION
                         MOV BL,COLOR_DEFAULT ;white on blue
                         MOV AL,0x20
                         MOV CX,0x0018 ;18 spaces
                         MOV AH,0x9
                         INT 0x10
                         ;WRITE CHARACTER AND ATTRIBUTE AT CURSOR POSITION
                         POP BX
                         POP CX
                         POP DX
                         POP DI
                         POP SI
                         POP DS
                         POP ES
                         RET
PRINT_TEXT:              PUSH ES
                         PUSH DS
                         PUSH SI
                         PUSH DI
                         PUSH CX
                         PUSH BX
LAB_0000_265b:           MOV AL,byte [BX]
                         MOV AH,COLOR_DEFAULT
                         CALL PRINT_CHAR
                         INC BX
                         INC DL
                         LOOP LAB_0000_265b
                         POP BX
                         POP CX
                         POP DI
                         POP SI
                         POP DS
                         POP ES
                         RET
PUSHPOP:                 PUSH ES
                         PUSH DS
                         PUSH SI
                         PUSH DI
                         PUSH DX
                         PUSH CX
                         PUSH BX
                         POP BX
                         POP CX
                         POP DX
                         POP DI
                         POP SI
                         POP DS
                         POP ES
                         RET
READ_KEY:                PUSH ES
                         PUSH DS
                         PUSH SI
                         PUSH DI
                         PUSH DX
                         PUSH CX
                         PUSH BX
                         MOV BH,0x0
                         MOV AH,0x2
                         INT 0x10
                         ;VIDEO - SET CURSOR POSITION
                         MOV AH,0xc
                         MOV AL,0x7
                         INT 0x21
                         ;DIRECT CHARACTER INPUT, WITHOUT ECHO
                         CMP AL,0x61 ;filter from "a"
                         JC LAB_0000_269a
                         CMP AL,0x7a ;filter to "z"
                         JA LAB_0000_269a
                         AND AL,0x5f
LAB_0000_269a:           POP BX
                         POP CX
                         POP DX
                         POP DI
                         POP SI
                         POP DS
                         POP ES
                         RET
GET_SEED_BY_TIME:        PUSH ES
                         PUSH DS
                         PUSH SI
                         PUSH DI
                         PUSH DX
                         PUSH CX
                         PUSH BX
                         MOV AH,0x2c
                         INT 0x21
                         ;DOS 1+ - GET SYSTEM TIME
                         ;AH = 0x2C
                         ;
                         ;Return:
                         ;CH = hour
                         ;CL = minute
                         ;DH = second
                         ;DL = 1/100 seconds
                         MOV AX,DX
                         SHR AX,0x0001
                         SHR AX,0x0001
                         SHR AX,0x0001
                         SHR AX,0x0001
                         SHR AX,0x0001
                         POP BX
                         POP CX
                         POP DX
                         POP DI
                         POP SI
                         POP DS
                         POP ES
                         RET


    section .text
    section .data
    section .bss

