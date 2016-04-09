;###############################################################################
;
;    BitCity - City building game for Game Boy Color.
;    Copyright (C) 2016 Antonio Nino Diaz (AntonioND/SkyLyrac)
;
;    This program is free software: you can redistribute it and/or modify
;    it under the terms of the GNU General Public License as published by
;    the Free Software Foundation, either version 3 of the License, or
;    (at your option) any later version.
;
;    This program is distributed in the hope that it will be useful,
;    but WITHOUT ANY WARRANTY; without even the implied warranty of
;    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;    GNU General Public License for more details.
;
;    You should have received a copy of the GNU General Public License
;    along with this program.  If not, see <http://www.gnu.org/licenses/>.
;
;    Contact: antonio_nd@outlook.com
;
;###############################################################################

    INCLUDE "tileset_info.inc"
    INCLUDE "room_game.inc"

;###############################################################################

CURTILE SET 0

; Tile Set Count
TILE_SET_COUNT : MACRO ; 1 = Tile number
    IF (\1) < CURTILE ; check if going backwards and stop if so
        FAIL "ERROR : building_info.asm : Tile already in use!"
    ENDC
    IF (\1) > CURTILE ; If there's a hole to fill, fill it
        REPT (\1) - CURTILE
            DS TILESET_INFO_ELEMENT_SIZE ; Empty
        ENDR
    ENDC
CURTILE SET (\1)
ENDM

; Tile Add
T_ADD : MACRO ; 1=Name Define, 2=Palette, 3=Type, 4=Base X delta, 5=Base Y delta
    TILE_SET_COUNT (\1)
    IF CURTILE < 256
        DB (\2) ; Bank 0
    ELSE
        DB (\2)|%00001000 ; Bank 1
    ENDC
    DB (\3)
    DB (\4), (\5) ; Origin of coordinates of this building (if any)
CURTILE SET CURTILE+1 ; Set cursor for next item
ENDM

;###############################################################################

    SECTION "Tileset Information",ROMX[$4000]

;-------------------------------------------------------------------------------

IF TILESET_INFO_ELEMENT_SIZE != 4
    FAIL "tileset_info.asm: Fix this!"
ENDC

; Add a define check like this whenever using this array:
;    IF TILESET_INFO_ELEMENT_SIZE != 4
;        FAIL "file.asm: Fix this!"
;    ENDC

; The fourth and fifth elements are used to tell the origin of coordinates of a
; building if it is composed by more than one tile.

TILESET_INFO:: ; 3 bytes per element, up to 512 elements
    TILE_SET_COUNT 0

    T_ADD   T_GRASS__FOREST_TL, 0, TYPE_FOREST, 0,0
    T_ADD   T_GRASS__FOREST_TC, 0, TYPE_FOREST, 0,0
    T_ADD   T_GRASS__FOREST_TR, 0, TYPE_FOREST, 0,0
    T_ADD   T_GRASS__FOREST_CL, 0, TYPE_FOREST, 0,0
    T_ADD   T_GRASS, 0, TYPE_FIELD, 0,0
    T_ADD   T_GRASS__FOREST_CR, 0, TYPE_FOREST, 0,0
    T_ADD   T_GRASS__FOREST_BL, 0, TYPE_FOREST, 0,0
    T_ADD   T_GRASS__FOREST_BC, 0, TYPE_FOREST, 0,0
    T_ADD   T_GRASS__FOREST_BR, 0, TYPE_FOREST, 0,0
    T_ADD   T_GRASS__FOREST_CORNER_TL, 0, TYPE_FIELD, 0,0
    T_ADD   T_GRASS__FOREST_CORNER_TR, 0, TYPE_FIELD, 0,0
    T_ADD   T_GRASS__FOREST_CORNER_BL, 0, TYPE_FIELD, 0,0
    T_ADD   T_GRASS__FOREST_CORNER_BR, 0, TYPE_FIELD, 0,0
    T_ADD   T_FOREST, 0, TYPE_FOREST, 0,0
    T_ADD   T_GRASS_EXTRA, 0, TYPE_FIELD, 0,0
    T_ADD   T_FOREST_EXTRA, 0, TYPE_FOREST, 0,0

    T_ADD   T_WATER__GRASS_TL, 1, TYPE_WATER, 0,0
    T_ADD   T_WATER__GRASS_TC, 1, TYPE_WATER, 0,0
    T_ADD   T_WATER__GRASS_TR, 1, TYPE_WATER, 0,0
    T_ADD   T_WATER__GRASS_CL, 1, TYPE_WATER, 0,0
    T_ADD   T_WATER, 1, TYPE_WATER, 0,0
    T_ADD   T_WATER__GRASS_CR, 1, TYPE_WATER, 0,0
    T_ADD   T_WATER__GRASS_BL, 1, TYPE_WATER, 0,0
    T_ADD   T_WATER__GRASS_BC, 1, TYPE_WATER, 0,0
    T_ADD   T_WATER__GRASS_BR, 1, TYPE_WATER, 0,0
    T_ADD   T_WATER__GRASS_CORNER_TL, 1, TYPE_WATER, 0,0
    T_ADD   T_WATER__GRASS_CORNER_TR, 1, TYPE_WATER, 0,0
    T_ADD   T_WATER__GRASS_CORNER_BL, 1, TYPE_WATER, 0,0
    T_ADD   T_WATER__GRASS_CORNER_BR, 1, TYPE_WATER, 0,0
    T_ADD   T_WATER_EXTRA, 1, TYPE_WATER, 0,0

    T_ADD   T_RESIDENTIAL, 0, TYPE_RESIDENTIAL, 0,0
    T_ADD   T_COMMERCIAL, 1, TYPE_COMMERCIAL, 0,0
    T_ADD   T_INDUSTRIAL, 2, TYPE_INDUSTRIAL, 0,0
    T_ADD   T_DEMOLISHED, 7, TYPE_FIELD, 0,0

    T_ADD   T_ROAD_TB, 7, TYPE_FIELD|TYPE_HAS_ROAD, 0,0
    T_ADD   T_ROAD_LR, 7, TYPE_FIELD|TYPE_HAS_ROAD, 0,0
    T_ADD   T_ROAD_RB, 7, TYPE_FIELD|TYPE_HAS_ROAD, 0,0
    T_ADD   T_ROAD_LB, 7, TYPE_FIELD|TYPE_HAS_ROAD, 0,0
    T_ADD   T_ROAD_TR, 7, TYPE_FIELD|TYPE_HAS_ROAD, 0,0
    T_ADD   T_ROAD_TL, 7, TYPE_FIELD|TYPE_HAS_ROAD, 0,0
    T_ADD   T_ROAD_TRB, 7, TYPE_FIELD|TYPE_HAS_ROAD, 0,0
    T_ADD   T_ROAD_LRB, 7, TYPE_FIELD|TYPE_HAS_ROAD, 0,0
    T_ADD   T_ROAD_TLB, 7, TYPE_FIELD|TYPE_HAS_ROAD, 0,0
    T_ADD   T_ROAD_TLR, 7, TYPE_FIELD|TYPE_HAS_ROAD, 0,0
    T_ADD   T_ROAD_TLRB, 7, TYPE_FIELD|TYPE_HAS_ROAD, 0,0
    T_ADD   T_ROAD_TB_POWER_LINES, 7, TYPE_FIELD|TYPE_HAS_ROAD|TYPE_HAS_POWER, 0,0
    T_ADD   T_ROAD_LR_POWER_LINES, 7, TYPE_FIELD|TYPE_HAS_ROAD|TYPE_HAS_POWER, 0,0
    T_ADD   T_ROAD_TB_BRIDGE, 7, TYPE_WATER|TYPE_HAS_ROAD, 0,0
    T_ADD   T_ROAD_LR_BRIDGE, 7, TYPE_WATER|TYPE_HAS_ROAD, 0,0

    T_ADD   T_TRAIN_TB, 7, TYPE_FIELD|TYPE_HAS_TRAIN, 0,0
    T_ADD   T_TRAIN_LR, 7, TYPE_FIELD|TYPE_HAS_TRAIN, 0,0
    T_ADD   T_TRAIN_RB, 7, TYPE_FIELD|TYPE_HAS_TRAIN, 0,0
    T_ADD   T_TRAIN_LB, 7, TYPE_FIELD|TYPE_HAS_TRAIN, 0,0
    T_ADD   T_TRAIN_TR, 7, TYPE_FIELD|TYPE_HAS_TRAIN, 0,0
    T_ADD   T_TRAIN_TL, 7, TYPE_FIELD|TYPE_HAS_TRAIN, 0,0
    T_ADD   T_TRAIN_TRB, 7, TYPE_FIELD|TYPE_HAS_TRAIN, 0,0
    T_ADD   T_TRAIN_LRB, 7, TYPE_FIELD|TYPE_HAS_TRAIN, 0,0
    T_ADD   T_TRAIN_TLB, 7, TYPE_FIELD|TYPE_HAS_TRAIN, 0,0
    T_ADD   T_TRAIN_TLR, 7, TYPE_FIELD|TYPE_HAS_TRAIN, 0,0
    T_ADD   T_TRAIN_TLRB, 7, TYPE_FIELD|TYPE_HAS_TRAIN, 0,0
    T_ADD   T_TRAIN_LR_ROAD, 7, TYPE_FIELD|TYPE_HAS_TRAIN|TYPE_HAS_ROAD, 0,0
    T_ADD   T_TRAIN_TB_ROAD, 7, TYPE_FIELD|TYPE_HAS_TRAIN|TYPE_HAS_ROAD, 0,0
    T_ADD   T_TRAIN_TB_POWER_LINES, 7, TYPE_FIELD|TYPE_HAS_TRAIN|TYPE_HAS_POWER, 0,0
    T_ADD   T_TRAIN_LR_POWER_LINES, 7, TYPE_FIELD|TYPE_HAS_TRAIN|TYPE_HAS_POWER, 0,0
    T_ADD   T_TRAIN_TB_BRIDGE, 7, TYPE_WATER|TYPE_HAS_TRAIN, 0,0
    T_ADD   T_TRAIN_LR_BRIDGE, 7, TYPE_WATER|TYPE_HAS_TRAIN, 0,0

    T_ADD   T_POWER_LINES_TB, 7, TYPE_FIELD|TYPE_HAS_POWER, 0,0
    T_ADD   T_POWER_LINES_LR, 7, TYPE_FIELD|TYPE_HAS_POWER, 0,0
    T_ADD   T_POWER_LINES_RB, 7, TYPE_FIELD|TYPE_HAS_POWER, 0,0
    T_ADD   T_POWER_LINES_LB, 7, TYPE_FIELD|TYPE_HAS_POWER, 0,0
    T_ADD   T_POWER_LINES_TR, 7, TYPE_FIELD|TYPE_HAS_POWER, 0,0
    T_ADD   T_POWER_LINES_TL, 7, TYPE_FIELD|TYPE_HAS_POWER, 0,0
    T_ADD   T_POWER_LINES_TRB, 7, TYPE_FIELD|TYPE_HAS_POWER, 0,0
    T_ADD   T_POWER_LINES_LRB, 7, TYPE_FIELD|TYPE_HAS_POWER, 0,0
    T_ADD   T_POWER_LINES_TLB, 7, TYPE_FIELD|TYPE_HAS_POWER, 0,0
    T_ADD   T_POWER_LINES_TLR, 7, TYPE_FIELD|TYPE_HAS_POWER, 0,0
    T_ADD   T_POWER_LINES_TLRB, 7, TYPE_FIELD|TYPE_HAS_POWER, 0,0
    T_ADD   T_POWER_LINES_TB_BRIDGE, 1, TYPE_WATER|TYPE_HAS_POWER, 0,0
    T_ADD   T_POWER_LINES_LR_BRIDGE, 1, TYPE_WATER|TYPE_HAS_POWER, 0,0

    T_ADD   T_POLICE+0, 1, TYPE_POLICE,  0, 0
    T_ADD   T_POLICE+1, 1, TYPE_POLICE, -1, 0
    T_ADD   T_POLICE+2, 1, TYPE_POLICE, -2, 0
    T_ADD   T_POLICE+3, 1, TYPE_POLICE,  0,-1
    T_ADD   T_POLICE+4, 1, TYPE_POLICE, -1,-1
    T_ADD   T_POLICE+5, 1, TYPE_POLICE, -2,-1
    T_ADD   T_POLICE+6, 7, TYPE_POLICE,  0,-2
    T_ADD   T_POLICE+7, 1, TYPE_POLICE, -1,-2
    T_ADD   T_POLICE+8, 1, TYPE_POLICE, -2,-2

    T_ADD   T_FIREMEN+0, 1, TYPE_FIREMEN,  0, 0
    T_ADD   T_FIREMEN+1, 5, TYPE_FIREMEN, -1, 0
    T_ADD   T_FIREMEN+2, 5, TYPE_FIREMEN, -2, 0
    T_ADD   T_FIREMEN+3, 1, TYPE_FIREMEN,  0,-1
    T_ADD   T_FIREMEN+4, 5, TYPE_FIREMEN, -1,-1
    T_ADD   T_FIREMEN+5, 5, TYPE_FIREMEN, -2,-1
    T_ADD   T_FIREMEN+6, 7, TYPE_FIREMEN,  0,-2
    T_ADD   T_FIREMEN+7, 1, TYPE_FIREMEN, -1,-2
    T_ADD   T_FIREMEN+8, 5, TYPE_FIREMEN, -2,-2

    T_ADD   T_HOSPITAL+0, 1, TYPE_HOSPITAL,  0, 0
    T_ADD   T_HOSPITAL+1, 4, TYPE_HOSPITAL, -1, 0
    T_ADD   T_HOSPITAL+2, 1, TYPE_HOSPITAL, -2, 0
    T_ADD   T_HOSPITAL+3, 1, TYPE_HOSPITAL,  0,-1
    T_ADD   T_HOSPITAL+4, 1, TYPE_HOSPITAL, -1,-1
    T_ADD   T_HOSPITAL+5, 4, TYPE_HOSPITAL, -2,-1
    T_ADD   T_HOSPITAL+6, 1, TYPE_HOSPITAL,  0,-2
    T_ADD   T_HOSPITAL+7, 1, TYPE_HOSPITAL, -1,-2
    T_ADD   T_HOSPITAL+8, 4, TYPE_HOSPITAL, -2,-2

    T_ADD   T_PARK_SMALL+0, 0, TYPE_PARK,  0, 0

    T_ADD   T_PARK_BIG+0, 0, TYPE_PARK,  0, 0
    T_ADD   T_PARK_BIG+1, 0, TYPE_PARK, -1, 0
    T_ADD   T_PARK_BIG+2, 0, TYPE_PARK, -2, 0
    T_ADD   T_PARK_BIG+3, 0, TYPE_PARK,  0,-1
    T_ADD   T_PARK_BIG+4, 1, TYPE_PARK, -1,-1
    T_ADD   T_PARK_BIG+5, 0, TYPE_PARK, -2,-1
    T_ADD   T_PARK_BIG+6, 0, TYPE_PARK,  0,-2
    T_ADD   T_PARK_BIG+7, 0, TYPE_PARK, -1,-2
    T_ADD   T_PARK_BIG+8, 0, TYPE_PARK, -2,-2

    T_ADD   T_STADIUM+0,  2, TYPE_STADIUM,  0, 0
    T_ADD   T_STADIUM+1,  2, TYPE_STADIUM, -1, 0
    T_ADD   T_STADIUM+2,  1, TYPE_STADIUM, -2, 0
    T_ADD   T_STADIUM+3,  1, TYPE_STADIUM, -3, 0
    T_ADD   T_STADIUM+4,  1, TYPE_STADIUM, -4, 0
    T_ADD   T_STADIUM+5,  2, TYPE_STADIUM,  0,-1
    T_ADD   T_STADIUM+6,  4, TYPE_STADIUM, -1,-1
    T_ADD   T_STADIUM+7,  4, TYPE_STADIUM, -2,-1
    T_ADD   T_STADIUM+8,  4, TYPE_STADIUM, -3,-1
    T_ADD   T_STADIUM+9,  1, TYPE_STADIUM, -4,-1
    T_ADD   T_STADIUM+10, 2, TYPE_STADIUM,  0,-2
    T_ADD   T_STADIUM+11, 4, TYPE_STADIUM, -1,-2
    T_ADD   T_STADIUM+12, 4, TYPE_STADIUM, -2,-2
    T_ADD   T_STADIUM+13, 4, TYPE_STADIUM, -3,-2
    T_ADD   T_STADIUM+14, 1, TYPE_STADIUM, -4,-2
    T_ADD   T_STADIUM+15, 2, TYPE_STADIUM,  0,-3
    T_ADD   T_STADIUM+16, 2, TYPE_STADIUM, -1,-3
    T_ADD   T_STADIUM+17, 2, TYPE_STADIUM, -2,-3
    T_ADD   T_STADIUM+18, 1, TYPE_STADIUM, -3,-3
    T_ADD   T_STADIUM+19, 1, TYPE_STADIUM, -4,-3

    T_ADD   T_SCHOOL+0, 0, TYPE_SCHOOL,  0, 0
    T_ADD   T_SCHOOL+1, 1, TYPE_SCHOOL, -1, 0
    T_ADD   T_SCHOOL+2, 1, TYPE_SCHOOL, -2, 0
    T_ADD   T_SCHOOL+3, 0, TYPE_SCHOOL,  0,-1
    T_ADD   T_SCHOOL+4, 1, TYPE_SCHOOL, -1,-1
    T_ADD   T_SCHOOL+5, 1, TYPE_SCHOOL, -2,-1

    T_ADD   T_HIGH_SCHOOL+0, 1, TYPE_HIGH_SCHOOL,  0, 0
    T_ADD   T_HIGH_SCHOOL+1, 1, TYPE_HIGH_SCHOOL, -1, 0
    T_ADD   T_HIGH_SCHOOL+2, 1, TYPE_HIGH_SCHOOL, -2, 0
    T_ADD   T_HIGH_SCHOOL+3, 1, TYPE_HIGH_SCHOOL,  0,-1
    T_ADD   T_HIGH_SCHOOL+4, 1, TYPE_HIGH_SCHOOL, -1,-1
    T_ADD   T_HIGH_SCHOOL+5, 1, TYPE_HIGH_SCHOOL, -2,-1
    T_ADD   T_HIGH_SCHOOL+6, 7, TYPE_HIGH_SCHOOL,  0,-2
    T_ADD   T_HIGH_SCHOOL+7, 7, TYPE_HIGH_SCHOOL, -1,-2
    T_ADD   T_HIGH_SCHOOL+8, 4, TYPE_HIGH_SCHOOL, -2,-2

    T_ADD   T_UNIVERSITY+0,  1, TYPE_UNIVERSITY,  0, 0
    T_ADD   T_UNIVERSITY+1,  4, TYPE_UNIVERSITY, -1, 0
    T_ADD   T_UNIVERSITY+2,  1, TYPE_UNIVERSITY, -2, 0
    T_ADD   T_UNIVERSITY+3,  2, TYPE_UNIVERSITY, -3, 0
    T_ADD   T_UNIVERSITY+4,  2, TYPE_UNIVERSITY, -4, 0
    T_ADD   T_UNIVERSITY+5,  1, TYPE_UNIVERSITY,  0,-1
    T_ADD   T_UNIVERSITY+6,  1, TYPE_UNIVERSITY, -1,-1
    T_ADD   T_UNIVERSITY+7,  1, TYPE_UNIVERSITY, -2,-1
    T_ADD   T_UNIVERSITY+8,  2, TYPE_UNIVERSITY, -3,-1
    T_ADD   T_UNIVERSITY+9,  2, TYPE_UNIVERSITY, -4,-1
    T_ADD   T_UNIVERSITY+10, 4, TYPE_UNIVERSITY,  0,-2
    T_ADD   T_UNIVERSITY+11, 1, TYPE_UNIVERSITY, -1,-2
    T_ADD   T_UNIVERSITY+12, 1, TYPE_UNIVERSITY, -2,-2
    T_ADD   T_UNIVERSITY+13, 1, TYPE_UNIVERSITY, -3,-2
    T_ADD   T_UNIVERSITY+14, 1, TYPE_UNIVERSITY, -4,-2
    T_ADD   T_UNIVERSITY+15, 4, TYPE_UNIVERSITY,  0,-3
    T_ADD   T_UNIVERSITY+16, 4, TYPE_UNIVERSITY, -1,-3
    T_ADD   T_UNIVERSITY+17, 4, TYPE_UNIVERSITY, -2,-3
    T_ADD   T_UNIVERSITY+18, 4, TYPE_UNIVERSITY, -3,-3
    T_ADD   T_UNIVERSITY+19, 4, TYPE_UNIVERSITY, -4,-3
    T_ADD   T_UNIVERSITY+20, 1, TYPE_UNIVERSITY,  0,-4
    T_ADD   T_UNIVERSITY+21, 1, TYPE_UNIVERSITY, -1,-4
    T_ADD   T_UNIVERSITY+22, 0, TYPE_UNIVERSITY, -2,-4
    T_ADD   T_UNIVERSITY+23, 7, TYPE_UNIVERSITY, -3,-4
    T_ADD   T_UNIVERSITY+24, 7, TYPE_UNIVERSITY, -4,-4

    T_ADD   T_MUSEUM+0,  7, TYPE_MUSEUM,  0, 0
    T_ADD   T_MUSEUM+1,  7, TYPE_MUSEUM, -1, 0
    T_ADD   T_MUSEUM+2,  7, TYPE_MUSEUM, -2, 0
    T_ADD   T_MUSEUM+3,  7, TYPE_MUSEUM, -3, 0
    T_ADD   T_MUSEUM+4,  7, TYPE_MUSEUM,  0,-1
    T_ADD   T_MUSEUM+5,  7, TYPE_MUSEUM, -1,-1
    T_ADD   T_MUSEUM+6,  7, TYPE_MUSEUM, -2,-1
    T_ADD   T_MUSEUM+7,  7, TYPE_MUSEUM, -3,-1
    T_ADD   T_MUSEUM+8,  7, TYPE_MUSEUM,  0,-2
    T_ADD   T_MUSEUM+9,  7, TYPE_MUSEUM, -1,-2
    T_ADD   T_MUSEUM+10, 7, TYPE_MUSEUM, -2,-2
    T_ADD   T_MUSEUM+11, 7, TYPE_MUSEUM, -3,-2

    T_ADD   T_LIBRARY+0, 1, TYPE_LIBRARY,  0, 0
    T_ADD   T_LIBRARY+1, 7, TYPE_LIBRARY, -1, 0
    T_ADD   T_LIBRARY+2, 7, TYPE_LIBRARY, -2, 0
    T_ADD   T_LIBRARY+3, 1, TYPE_LIBRARY,  0,-1
    T_ADD   T_LIBRARY+4, 1, TYPE_LIBRARY, -1,-1
    T_ADD   T_LIBRARY+5, 1, TYPE_LIBRARY, -2,-1

    T_ADD   T_TRAIN_STATION+0, 5, TYPE_TRAIN_STATION,  0, 0
    T_ADD   T_TRAIN_STATION+1, 5, TYPE_TRAIN_STATION, -1, 0
    T_ADD   T_TRAIN_STATION+2, 1, TYPE_TRAIN_STATION,  0,-1
    T_ADD   T_TRAIN_STATION+3, 5, TYPE_TRAIN_STATION, -1,-1

    T_ADD   T_AIRPORT+0,  7, TYPE_AIRPORT,  0, 0
    T_ADD   T_AIRPORT+1,  7, TYPE_AIRPORT, -1, 0
    T_ADD   T_AIRPORT+2,  1, TYPE_AIRPORT, -2, 0
    T_ADD   T_AIRPORT+3,  1, TYPE_AIRPORT, -3, 0
    T_ADD   T_AIRPORT+4,  1, TYPE_AIRPORT, -4, 0
    T_ADD   T_AIRPORT+5,  7, TYPE_AIRPORT,  0,-1
    T_ADD   T_AIRPORT+6,  7, TYPE_AIRPORT, -1,-1
    T_ADD   T_AIRPORT+7,  7, TYPE_AIRPORT, -2,-1
    T_ADD   T_AIRPORT+8,  7, TYPE_AIRPORT, -3,-1
    T_ADD   T_AIRPORT+9,  1, TYPE_AIRPORT, -4,-1
    T_ADD   T_AIRPORT+10, 7, TYPE_AIRPORT,  0,-2
    T_ADD   T_AIRPORT+11, 7, TYPE_AIRPORT, -1,-2
    T_ADD   T_AIRPORT+12, 7, TYPE_AIRPORT, -2,-2
    T_ADD   T_AIRPORT+13, 7, TYPE_AIRPORT, -3,-2
    T_ADD   T_AIRPORT+14, 7, TYPE_AIRPORT, -4,-2

    T_ADD   T_PORT+0, 1, TYPE_PORT,  0, 0
    T_ADD   T_PORT+1, 7, TYPE_PORT, -1, 0
    T_ADD   T_PORT+2, 7, TYPE_PORT, -2, 0
    T_ADD   T_PORT+3, 1, TYPE_PORT,  0,-1
    T_ADD   T_PORT+4, 7, TYPE_PORT, -1,-1
    T_ADD   T_PORT+5, 7, TYPE_PORT, -2,-1
    T_ADD   T_PORT+6, 1, TYPE_PORT,  0,-2
    T_ADD   T_PORT+7, 1, TYPE_PORT, -1,-2
    T_ADD   T_PORT+8, 1, TYPE_PORT, -2,-2

    T_ADD   T_PORT_WATER_L, 7, TYPE_DOCK,  0, 0
    T_ADD   T_PORT_WATER_R, 7, TYPE_DOCK,  0, 0
    T_ADD   T_PORT_WATER_D, 7, TYPE_DOCK,  0, 0
    T_ADD   T_PORT_WATER_U, 7, TYPE_DOCK,  0, 0

    T_ADD   T_POWER_PLANT_COAL+0,  7, TYPE_POWER_PLANT,  0, 0
    T_ADD   T_POWER_PLANT_COAL+1,  7, TYPE_POWER_PLANT, -1, 0
    T_ADD   T_POWER_PLANT_COAL+2,  7, TYPE_POWER_PLANT, -2, 0
    T_ADD   T_POWER_PLANT_COAL+3,  7, TYPE_POWER_PLANT, -3, 0
    T_ADD   T_POWER_PLANT_COAL+4,  7, TYPE_POWER_PLANT,  0,-1
    T_ADD   T_POWER_PLANT_COAL+5,  7, TYPE_POWER_PLANT, -1,-1
    T_ADD   T_POWER_PLANT_COAL+6,  7, TYPE_POWER_PLANT, -2,-1
    T_ADD   T_POWER_PLANT_COAL+7,  7, TYPE_POWER_PLANT, -3,-1
    T_ADD   T_POWER_PLANT_COAL+8,  7, TYPE_POWER_PLANT,  0,-2
    T_ADD   T_POWER_PLANT_COAL+9,  7, TYPE_POWER_PLANT, -1,-2
    T_ADD   T_POWER_PLANT_COAL+10, 7, TYPE_POWER_PLANT, -2,-2
    T_ADD   T_POWER_PLANT_COAL+11, 7, TYPE_POWER_PLANT, -3,-2
    T_ADD   T_POWER_PLANT_COAL+12, 7, TYPE_POWER_PLANT,  0,-3
    T_ADD   T_POWER_PLANT_COAL+13, 7, TYPE_POWER_PLANT, -1,-3
    T_ADD   T_POWER_PLANT_COAL+14, 7, TYPE_POWER_PLANT, -2,-3
    T_ADD   T_POWER_PLANT_COAL+15, 7, TYPE_POWER_PLANT, -3,-3

    T_ADD   T_POWER_PLANT_OIL+0,  7, TYPE_POWER_PLANT,  0, 0
    T_ADD   T_POWER_PLANT_OIL+1,  7, TYPE_POWER_PLANT, -1, 0
    T_ADD   T_POWER_PLANT_OIL+2,  7, TYPE_POWER_PLANT, -2, 0
    T_ADD   T_POWER_PLANT_OIL+3,  7, TYPE_POWER_PLANT, -3, 0
    T_ADD   T_POWER_PLANT_OIL+4,  7, TYPE_POWER_PLANT,  0,-1
    T_ADD   T_POWER_PLANT_OIL+5,  7, TYPE_POWER_PLANT, -1,-1
    T_ADD   T_POWER_PLANT_OIL+6,  7, TYPE_POWER_PLANT, -2,-1
    T_ADD   T_POWER_PLANT_OIL+7,  7, TYPE_POWER_PLANT, -3,-1
    T_ADD   T_POWER_PLANT_OIL+8,  7, TYPE_POWER_PLANT,  0,-2
    T_ADD   T_POWER_PLANT_OIL+9,  7, TYPE_POWER_PLANT, -1,-2
    T_ADD   T_POWER_PLANT_OIL+10, 7, TYPE_POWER_PLANT, -2,-2
    T_ADD   T_POWER_PLANT_OIL+11, 7, TYPE_POWER_PLANT, -3,-2
    T_ADD   T_POWER_PLANT_OIL+12, 7, TYPE_POWER_PLANT,  0,-3
    T_ADD   T_POWER_PLANT_OIL+13, 7, TYPE_POWER_PLANT, -1,-3
    T_ADD   T_POWER_PLANT_OIL+14, 7, TYPE_POWER_PLANT, -2,-3
    T_ADD   T_POWER_PLANT_OIL+15, 7, TYPE_POWER_PLANT, -3,-3

    T_ADD   T_POWER_PLANT_WIND+0,  4, TYPE_POWER_PLANT,  0, 0
    T_ADD   T_POWER_PLANT_WIND+1,  4, TYPE_POWER_PLANT, -1, 0
    T_ADD   T_POWER_PLANT_WIND+2,  7, TYPE_POWER_PLANT,  0,-1
    T_ADD   T_POWER_PLANT_WIND+3,  4, TYPE_POWER_PLANT, -1,-1

    T_ADD   T_POWER_PLANT_SOLAR+0,  1, TYPE_POWER_PLANT,  0, 0
    T_ADD   T_POWER_PLANT_SOLAR+1,  1, TYPE_POWER_PLANT, -1, 0
    T_ADD   T_POWER_PLANT_SOLAR+2,  1, TYPE_POWER_PLANT, -2, 0
    T_ADD   T_POWER_PLANT_SOLAR+3,  1, TYPE_POWER_PLANT, -3, 0
    T_ADD   T_POWER_PLANT_SOLAR+4,  1, TYPE_POWER_PLANT,  0,-1
    T_ADD   T_POWER_PLANT_SOLAR+5,  1, TYPE_POWER_PLANT, -1,-1
    T_ADD   T_POWER_PLANT_SOLAR+6,  1, TYPE_POWER_PLANT, -2,-1
    T_ADD   T_POWER_PLANT_SOLAR+7,  1, TYPE_POWER_PLANT, -3,-1
    T_ADD   T_POWER_PLANT_SOLAR+8,  1, TYPE_POWER_PLANT,  0,-2
    T_ADD   T_POWER_PLANT_SOLAR+9,  1, TYPE_POWER_PLANT, -1,-2
    T_ADD   T_POWER_PLANT_SOLAR+10, 7, TYPE_POWER_PLANT, -2,-2
    T_ADD   T_POWER_PLANT_SOLAR+11, 1, TYPE_POWER_PLANT, -3,-2
    T_ADD   T_POWER_PLANT_SOLAR+12, 1, TYPE_POWER_PLANT,  0,-3
    T_ADD   T_POWER_PLANT_SOLAR+13, 1, TYPE_POWER_PLANT, -1,-3
    T_ADD   T_POWER_PLANT_SOLAR+14, 7, TYPE_POWER_PLANT, -2,-3
    T_ADD   T_POWER_PLANT_SOLAR+15, 7, TYPE_POWER_PLANT, -3,-3

    T_ADD   T_POWER_PLANT_NUCLEAR+0,  7, TYPE_POWER_PLANT,  0, 0
    T_ADD   T_POWER_PLANT_NUCLEAR+1,  7, TYPE_POWER_PLANT, -1, 0
    T_ADD   T_POWER_PLANT_NUCLEAR+2,  7, TYPE_POWER_PLANT, -2, 0
    T_ADD   T_POWER_PLANT_NUCLEAR+3,  7, TYPE_POWER_PLANT, -3, 0
    T_ADD   T_POWER_PLANT_NUCLEAR+4,  7, TYPE_POWER_PLANT,  0,-1
    T_ADD   T_POWER_PLANT_NUCLEAR+5,  7, TYPE_POWER_PLANT, -1,-1
    T_ADD   T_POWER_PLANT_NUCLEAR+6,  7, TYPE_POWER_PLANT, -2,-1
    T_ADD   T_POWER_PLANT_NUCLEAR+7,  7, TYPE_POWER_PLANT, -3,-1
    T_ADD   T_POWER_PLANT_NUCLEAR+8,  7, TYPE_POWER_PLANT,  0,-2
    T_ADD   T_POWER_PLANT_NUCLEAR+9,  7, TYPE_POWER_PLANT, -1,-2
    T_ADD   T_POWER_PLANT_NUCLEAR+10, 7, TYPE_POWER_PLANT, -2,-2
    T_ADD   T_POWER_PLANT_NUCLEAR+11, 2, TYPE_POWER_PLANT, -3,-2
    T_ADD   T_POWER_PLANT_NUCLEAR+12, 7, TYPE_POWER_PLANT,  0,-3
    T_ADD   T_POWER_PLANT_NUCLEAR+13, 7, TYPE_POWER_PLANT, -1,-3
    T_ADD   T_POWER_PLANT_NUCLEAR+14, 7, TYPE_POWER_PLANT, -2,-3
    T_ADD   T_POWER_PLANT_NUCLEAR+15, 7, TYPE_POWER_PLANT, -3,-3

    T_ADD   T_POWER_PLANT_FUSION+0,  1, TYPE_POWER_PLANT,  0, 0
    T_ADD   T_POWER_PLANT_FUSION+1,  1, TYPE_POWER_PLANT, -1, 0
    T_ADD   T_POWER_PLANT_FUSION+2,  7, TYPE_POWER_PLANT, -2, 0
    T_ADD   T_POWER_PLANT_FUSION+3,  7, TYPE_POWER_PLANT, -3, 0
    T_ADD   T_POWER_PLANT_FUSION+4,  1, TYPE_POWER_PLANT,  0,-1
    T_ADD   T_POWER_PLANT_FUSION+5,  1, TYPE_POWER_PLANT, -1,-1
    T_ADD   T_POWER_PLANT_FUSION+6,  7, TYPE_POWER_PLANT, -2,-1
    T_ADD   T_POWER_PLANT_FUSION+7,  7, TYPE_POWER_PLANT, -3,-1
    T_ADD   T_POWER_PLANT_FUSION+8,  7, TYPE_POWER_PLANT,  0,-2
    T_ADD   T_POWER_PLANT_FUSION+9,  7, TYPE_POWER_PLANT, -1,-2
    T_ADD   T_POWER_PLANT_FUSION+10, 7, TYPE_POWER_PLANT, -2,-2
    T_ADD   T_POWER_PLANT_FUSION+11, 7, TYPE_POWER_PLANT, -3,-2
    T_ADD   T_POWER_PLANT_FUSION+12, 7, TYPE_POWER_PLANT,  0,-3
    T_ADD   T_POWER_PLANT_FUSION+13, 7, TYPE_POWER_PLANT, -1,-3
    T_ADD   T_POWER_PLANT_FUSION+14, 7, TYPE_POWER_PLANT, -2,-3
    T_ADD   T_POWER_PLANT_FUSION+15, 7, TYPE_POWER_PLANT, -3,-3

    T_ADD   T_RESIDENTIAL_S1_A, 4, TYPE_RESIDENTIAL,  0, 0
    T_ADD   T_RESIDENTIAL_S1_B, 4, TYPE_RESIDENTIAL,  0, 0
    T_ADD   T_RESIDENTIAL_S1_C, 4, TYPE_RESIDENTIAL,  0, 0
    T_ADD   T_RESIDENTIAL_S1_D, 4, TYPE_RESIDENTIAL,  0, 0

    T_ADD   T_RESIDENTIAL_S2_A+0, 4, TYPE_RESIDENTIAL,  0, 0
    T_ADD   T_RESIDENTIAL_S2_A+1, 4, TYPE_RESIDENTIAL, -1, 0
    T_ADD   T_RESIDENTIAL_S2_A+2, 4, TYPE_RESIDENTIAL,  0,-1
    T_ADD   T_RESIDENTIAL_S2_A+3, 4, TYPE_RESIDENTIAL, -1,-1

    T_ADD   T_RESIDENTIAL_S2_B+0, 4, TYPE_RESIDENTIAL,  0, 0
    T_ADD   T_RESIDENTIAL_S2_B+1, 4, TYPE_RESIDENTIAL, -1, 0
    T_ADD   T_RESIDENTIAL_S2_B+2, 4, TYPE_RESIDENTIAL,  0,-1
    T_ADD   T_RESIDENTIAL_S2_B+3, 4, TYPE_RESIDENTIAL, -1,-1

    T_ADD   T_RESIDENTIAL_S2_C+0, 4, TYPE_RESIDENTIAL,  0, 0
    T_ADD   T_RESIDENTIAL_S2_C+1, 4, TYPE_RESIDENTIAL, -1, 0
    T_ADD   T_RESIDENTIAL_S2_C+2, 4, TYPE_RESIDENTIAL,  0,-1
    T_ADD   T_RESIDENTIAL_S2_C+3, 4, TYPE_RESIDENTIAL, -1,-1

    T_ADD   T_RESIDENTIAL_S2_D+0, 4, TYPE_RESIDENTIAL,  0, 0
    T_ADD   T_RESIDENTIAL_S2_D+1, 4, TYPE_RESIDENTIAL, -1, 0
    T_ADD   T_RESIDENTIAL_S2_D+2, 4, TYPE_RESIDENTIAL,  0,-1
    T_ADD   T_RESIDENTIAL_S2_D+3, 4, TYPE_RESIDENTIAL, -1,-1

    T_ADD   T_RESIDENTIAL_S3_A+0, 4, TYPE_RESIDENTIAL,  0, 0
    T_ADD   T_RESIDENTIAL_S3_A+1, 4, TYPE_RESIDENTIAL, -1, 0
    T_ADD   T_RESIDENTIAL_S3_A+2, 4, TYPE_RESIDENTIAL, -2, 0
    T_ADD   T_RESIDENTIAL_S3_A+3, 4, TYPE_RESIDENTIAL,  0,-1
    T_ADD   T_RESIDENTIAL_S3_A+4, 4, TYPE_RESIDENTIAL, -1,-1
    T_ADD   T_RESIDENTIAL_S3_A+5, 4, TYPE_RESIDENTIAL, -2,-1
    T_ADD   T_RESIDENTIAL_S3_A+6, 4, TYPE_RESIDENTIAL,  0,-2
    T_ADD   T_RESIDENTIAL_S3_A+7, 4, TYPE_RESIDENTIAL, -1,-2
    T_ADD   T_RESIDENTIAL_S3_A+8, 4, TYPE_RESIDENTIAL, -2,-2

    T_ADD   T_RESIDENTIAL_S3_B+0, 4, TYPE_RESIDENTIAL,  0, 0
    T_ADD   T_RESIDENTIAL_S3_B+1, 4, TYPE_RESIDENTIAL, -1, 0
    T_ADD   T_RESIDENTIAL_S3_B+2, 4, TYPE_RESIDENTIAL, -2, 0
    T_ADD   T_RESIDENTIAL_S3_B+3, 4, TYPE_RESIDENTIAL,  0,-1
    T_ADD   T_RESIDENTIAL_S3_B+4, 4, TYPE_RESIDENTIAL, -1,-1
    T_ADD   T_RESIDENTIAL_S3_B+5, 4, TYPE_RESIDENTIAL, -2,-1
    T_ADD   T_RESIDENTIAL_S3_B+6, 4, TYPE_RESIDENTIAL,  0,-2
    T_ADD   T_RESIDENTIAL_S3_B+7, 4, TYPE_RESIDENTIAL, -1,-2
    T_ADD   T_RESIDENTIAL_S3_B+8, 4, TYPE_RESIDENTIAL, -2,-2

    T_ADD   T_RESIDENTIAL_S3_C+0, 4, TYPE_RESIDENTIAL,  0, 0
    T_ADD   T_RESIDENTIAL_S3_C+1, 4, TYPE_RESIDENTIAL, -1, 0
    T_ADD   T_RESIDENTIAL_S3_C+2, 4, TYPE_RESIDENTIAL, -2, 0
    T_ADD   T_RESIDENTIAL_S3_C+3, 4, TYPE_RESIDENTIAL,  0,-1
    T_ADD   T_RESIDENTIAL_S3_C+4, 4, TYPE_RESIDENTIAL, -1,-1
    T_ADD   T_RESIDENTIAL_S3_C+5, 4, TYPE_RESIDENTIAL, -2,-1
    T_ADD   T_RESIDENTIAL_S3_C+6, 4, TYPE_RESIDENTIAL,  0,-2
    T_ADD   T_RESIDENTIAL_S3_C+7, 4, TYPE_RESIDENTIAL, -1,-2
    T_ADD   T_RESIDENTIAL_S3_C+8, 4, TYPE_RESIDENTIAL, -2,-2

    T_ADD   T_RESIDENTIAL_S3_D+0, 4, TYPE_RESIDENTIAL,  0, 0
    T_ADD   T_RESIDENTIAL_S3_D+1, 4, TYPE_RESIDENTIAL, -1, 0
    T_ADD   T_RESIDENTIAL_S3_D+2, 4, TYPE_RESIDENTIAL, -2, 0
    T_ADD   T_RESIDENTIAL_S3_D+3, 4, TYPE_RESIDENTIAL,  0,-1
    T_ADD   T_RESIDENTIAL_S3_D+4, 4, TYPE_RESIDENTIAL, -1,-1
    T_ADD   T_RESIDENTIAL_S3_D+5, 4, TYPE_RESIDENTIAL, -2,-1
    T_ADD   T_RESIDENTIAL_S3_D+6, 4, TYPE_RESIDENTIAL,  0,-2
    T_ADD   T_RESIDENTIAL_S3_D+7, 4, TYPE_RESIDENTIAL, -1,-2
    T_ADD   T_RESIDENTIAL_S3_D+8, 4, TYPE_RESIDENTIAL, -2,-2

    T_ADD   T_COMMERCIAL_S1_A, 1, TYPE_COMMERCIAL,  0, 0
    T_ADD   T_COMMERCIAL_S1_B, 1, TYPE_COMMERCIAL,  0, 0
    T_ADD   T_COMMERCIAL_S1_C, 1, TYPE_COMMERCIAL,  0, 0
    T_ADD   T_COMMERCIAL_S1_D, 1, TYPE_COMMERCIAL,  0, 0

    T_ADD   T_COMMERCIAL_S2_A+0, 1, TYPE_COMMERCIAL,  0, 0
    T_ADD   T_COMMERCIAL_S2_A+1, 1, TYPE_COMMERCIAL, -1, 0
    T_ADD   T_COMMERCIAL_S2_A+2, 1, TYPE_COMMERCIAL,  0,-1
    T_ADD   T_COMMERCIAL_S2_A+3, 1, TYPE_COMMERCIAL, -1,-1

    T_ADD   T_COMMERCIAL_S2_B+0, 1, TYPE_COMMERCIAL,  0, 0
    T_ADD   T_COMMERCIAL_S2_B+1, 1, TYPE_COMMERCIAL, -1, 0
    T_ADD   T_COMMERCIAL_S2_B+2, 1, TYPE_COMMERCIAL,  0,-1
    T_ADD   T_COMMERCIAL_S2_B+3, 1, TYPE_COMMERCIAL, -1,-1

    T_ADD   T_COMMERCIAL_S2_C+0, 1, TYPE_COMMERCIAL,  0, 0
    T_ADD   T_COMMERCIAL_S2_C+1, 1, TYPE_COMMERCIAL, -1, 0
    T_ADD   T_COMMERCIAL_S2_C+2, 1, TYPE_COMMERCIAL,  0,-1
    T_ADD   T_COMMERCIAL_S2_C+3, 1, TYPE_COMMERCIAL, -1,-1

    T_ADD   T_COMMERCIAL_S2_D+0, 1, TYPE_COMMERCIAL,  0, 0
    T_ADD   T_COMMERCIAL_S2_D+1, 1, TYPE_COMMERCIAL, -1, 0
    T_ADD   T_COMMERCIAL_S2_D+2, 1, TYPE_COMMERCIAL,  0,-1
    T_ADD   T_COMMERCIAL_S2_D+3, 1, TYPE_COMMERCIAL, -1,-1

    T_ADD   T_COMMERCIAL_S3_A+0, 1, TYPE_COMMERCIAL,  0, 0
    T_ADD   T_COMMERCIAL_S3_A+1, 1, TYPE_COMMERCIAL, -1, 0
    T_ADD   T_COMMERCIAL_S3_A+2, 1, TYPE_COMMERCIAL, -2, 0
    T_ADD   T_COMMERCIAL_S3_A+3, 1, TYPE_COMMERCIAL,  0,-1
    T_ADD   T_COMMERCIAL_S3_A+4, 1, TYPE_COMMERCIAL, -1,-1
    T_ADD   T_COMMERCIAL_S3_A+5, 1, TYPE_COMMERCIAL, -2,-1
    T_ADD   T_COMMERCIAL_S3_A+6, 1, TYPE_COMMERCIAL,  0,-2
    T_ADD   T_COMMERCIAL_S3_A+7, 1, TYPE_COMMERCIAL, -1,-2
    T_ADD   T_COMMERCIAL_S3_A+8, 1, TYPE_COMMERCIAL, -2,-2

    T_ADD   T_COMMERCIAL_S3_B+0, 1, TYPE_COMMERCIAL,  0, 0
    T_ADD   T_COMMERCIAL_S3_B+1, 1, TYPE_COMMERCIAL, -1, 0
    T_ADD   T_COMMERCIAL_S3_B+2, 1, TYPE_COMMERCIAL, -2, 0
    T_ADD   T_COMMERCIAL_S3_B+3, 1, TYPE_COMMERCIAL,  0,-1
    T_ADD   T_COMMERCIAL_S3_B+4, 1, TYPE_COMMERCIAL, -1,-1
    T_ADD   T_COMMERCIAL_S3_B+5, 1, TYPE_COMMERCIAL, -2,-1
    T_ADD   T_COMMERCIAL_S3_B+6, 1, TYPE_COMMERCIAL,  0,-2
    T_ADD   T_COMMERCIAL_S3_B+7, 1, TYPE_COMMERCIAL, -1,-2
    T_ADD   T_COMMERCIAL_S3_B+8, 1, TYPE_COMMERCIAL, -2,-2

    T_ADD   T_COMMERCIAL_S3_C+0, 1, TYPE_COMMERCIAL,  0, 0
    T_ADD   T_COMMERCIAL_S3_C+1, 1, TYPE_COMMERCIAL, -1, 0
    T_ADD   T_COMMERCIAL_S3_C+2, 1, TYPE_COMMERCIAL, -2, 0
    T_ADD   T_COMMERCIAL_S3_C+3, 1, TYPE_COMMERCIAL,  0,-1
    T_ADD   T_COMMERCIAL_S3_C+4, 1, TYPE_COMMERCIAL, -1,-1
    T_ADD   T_COMMERCIAL_S3_C+5, 1, TYPE_COMMERCIAL, -2,-1
    T_ADD   T_COMMERCIAL_S3_C+6, 1, TYPE_COMMERCIAL,  0,-2
    T_ADD   T_COMMERCIAL_S3_C+7, 1, TYPE_COMMERCIAL, -1,-2
    T_ADD   T_COMMERCIAL_S3_C+8, 1, TYPE_COMMERCIAL, -2,-2

    T_ADD   T_COMMERCIAL_S3_D+0, 1, TYPE_COMMERCIAL,  0, 0
    T_ADD   T_COMMERCIAL_S3_D+1, 1, TYPE_COMMERCIAL, -1, 0
    T_ADD   T_COMMERCIAL_S3_D+2, 1, TYPE_COMMERCIAL, -2, 0
    T_ADD   T_COMMERCIAL_S3_D+3, 1, TYPE_COMMERCIAL,  0,-1
    T_ADD   T_COMMERCIAL_S3_D+4, 1, TYPE_COMMERCIAL, -1,-1
    T_ADD   T_COMMERCIAL_S3_D+5, 1, TYPE_COMMERCIAL, -2,-1
    T_ADD   T_COMMERCIAL_S3_D+6, 1, TYPE_COMMERCIAL,  0,-2
    T_ADD   T_COMMERCIAL_S3_D+7, 1, TYPE_COMMERCIAL, -1,-2
    T_ADD   T_COMMERCIAL_S3_D+8, 1, TYPE_COMMERCIAL, -2,-2

    T_ADD   T_INDUSTRIAL_S1_A, 2, TYPE_INDUSTRIAL,  0, 0
    T_ADD   T_INDUSTRIAL_S1_B, 2, TYPE_INDUSTRIAL,  0, 0
    T_ADD   T_INDUSTRIAL_S1_C, 2, TYPE_INDUSTRIAL,  0, 0
    T_ADD   T_INDUSTRIAL_S1_D, 2, TYPE_INDUSTRIAL,  0, 0

    T_ADD   T_INDUSTRIAL_S2_A+0, 2, TYPE_INDUSTRIAL,  0, 0
    T_ADD   T_INDUSTRIAL_S2_A+1, 2, TYPE_INDUSTRIAL, -1, 0
    T_ADD   T_INDUSTRIAL_S2_A+2, 2, TYPE_INDUSTRIAL,  0,-1
    T_ADD   T_INDUSTRIAL_S2_A+3, 2, TYPE_INDUSTRIAL, -1,-1

    T_ADD   T_INDUSTRIAL_S2_B+0, 2, TYPE_INDUSTRIAL,  0, 0
    T_ADD   T_INDUSTRIAL_S2_B+1, 2, TYPE_INDUSTRIAL, -1, 0
    T_ADD   T_INDUSTRIAL_S2_B+2, 2, TYPE_INDUSTRIAL,  0,-1
    T_ADD   T_INDUSTRIAL_S2_B+3, 2, TYPE_INDUSTRIAL, -1,-1

    T_ADD   T_INDUSTRIAL_S2_C+0, 2, TYPE_INDUSTRIAL,  0, 0
    T_ADD   T_INDUSTRIAL_S2_C+1, 2, TYPE_INDUSTRIAL, -1, 0
    T_ADD   T_INDUSTRIAL_S2_C+2, 2, TYPE_INDUSTRIAL,  0,-1
    T_ADD   T_INDUSTRIAL_S2_C+3, 2, TYPE_INDUSTRIAL, -1,-1

    T_ADD   T_INDUSTRIAL_S2_D+0, 2, TYPE_INDUSTRIAL,  0, 0
    T_ADD   T_INDUSTRIAL_S2_D+1, 2, TYPE_INDUSTRIAL, -1, 0
    T_ADD   T_INDUSTRIAL_S2_D+2, 2, TYPE_INDUSTRIAL,  0,-1
    T_ADD   T_INDUSTRIAL_S2_D+3, 2, TYPE_INDUSTRIAL, -1,-1

    T_ADD   T_INDUSTRIAL_S3_A+0, 2, TYPE_INDUSTRIAL,  0, 0
    T_ADD   T_INDUSTRIAL_S3_A+1, 2, TYPE_INDUSTRIAL, -1, 0
    T_ADD   T_INDUSTRIAL_S3_A+2, 2, TYPE_INDUSTRIAL, -2, 0
    T_ADD   T_INDUSTRIAL_S3_A+3, 2, TYPE_INDUSTRIAL,  0,-1
    T_ADD   T_INDUSTRIAL_S3_A+4, 2, TYPE_INDUSTRIAL, -1,-1
    T_ADD   T_INDUSTRIAL_S3_A+5, 2, TYPE_INDUSTRIAL, -2,-1
    T_ADD   T_INDUSTRIAL_S3_A+6, 2, TYPE_INDUSTRIAL,  0,-2
    T_ADD   T_INDUSTRIAL_S3_A+7, 2, TYPE_INDUSTRIAL, -1,-2
    T_ADD   T_INDUSTRIAL_S3_A+8, 2, TYPE_INDUSTRIAL, -2,-2

    T_ADD   T_INDUSTRIAL_S3_B+0, 2, TYPE_INDUSTRIAL,  0, 0
    T_ADD   T_INDUSTRIAL_S3_B+1, 2, TYPE_INDUSTRIAL, -1, 0
    T_ADD   T_INDUSTRIAL_S3_B+2, 2, TYPE_INDUSTRIAL, -2, 0
    T_ADD   T_INDUSTRIAL_S3_B+3, 2, TYPE_INDUSTRIAL,  0,-1
    T_ADD   T_INDUSTRIAL_S3_B+4, 2, TYPE_INDUSTRIAL, -1,-1
    T_ADD   T_INDUSTRIAL_S3_B+5, 2, TYPE_INDUSTRIAL, -2,-1
    T_ADD   T_INDUSTRIAL_S3_B+6, 2, TYPE_INDUSTRIAL,  0,-2
    T_ADD   T_INDUSTRIAL_S3_B+7, 2, TYPE_INDUSTRIAL, -1,-2
    T_ADD   T_INDUSTRIAL_S3_B+8, 2, TYPE_INDUSTRIAL, -2,-2

    T_ADD   T_INDUSTRIAL_S3_C+0, 2, TYPE_INDUSTRIAL,  0, 0
    T_ADD   T_INDUSTRIAL_S3_C+1, 2, TYPE_INDUSTRIAL, -1, 0
    T_ADD   T_INDUSTRIAL_S3_C+2, 2, TYPE_INDUSTRIAL, -2, 0
    T_ADD   T_INDUSTRIAL_S3_C+3, 2, TYPE_INDUSTRIAL,  0,-1
    T_ADD   T_INDUSTRIAL_S3_C+4, 2, TYPE_INDUSTRIAL, -1,-1
    T_ADD   T_INDUSTRIAL_S3_C+5, 2, TYPE_INDUSTRIAL, -2,-1
    T_ADD   T_INDUSTRIAL_S3_C+6, 2, TYPE_INDUSTRIAL,  0,-2
    T_ADD   T_INDUSTRIAL_S3_C+7, 2, TYPE_INDUSTRIAL, -1,-2
    T_ADD   T_INDUSTRIAL_S3_C+8, 2, TYPE_INDUSTRIAL, -2,-2

    T_ADD   T_INDUSTRIAL_S3_D+0, 2, TYPE_INDUSTRIAL,  0, 0
    T_ADD   T_INDUSTRIAL_S3_D+1, 2, TYPE_INDUSTRIAL, -1, 0
    T_ADD   T_INDUSTRIAL_S3_D+2, 2, TYPE_INDUSTRIAL, -2, 0
    T_ADD   T_INDUSTRIAL_S3_D+3, 2, TYPE_INDUSTRIAL,  0,-1
    T_ADD   T_INDUSTRIAL_S3_D+4, 2, TYPE_INDUSTRIAL, -1,-1
    T_ADD   T_INDUSTRIAL_S3_D+5, 2, TYPE_INDUSTRIAL, -2,-1
    T_ADD   T_INDUSTRIAL_S3_D+6, 2, TYPE_INDUSTRIAL,  0,-2
    T_ADD   T_INDUSTRIAL_S3_D+7, 2, TYPE_INDUSTRIAL, -1,-2
    T_ADD   T_INDUSTRIAL_S3_D+8, 2, TYPE_INDUSTRIAL, -2,-2

;---------------

    TILE_SET_COUNT 512 ; Fill array

;###############################################################################
