--[[
	Mod Oficios_Basicos para Minetest
	Copyright (C) 2018 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Inicializador de scripts
  ]]

local path = minetest.get_modpath("oficios_basicos")

oficios_basicos = {}

minetest.log('verbose',"[OFICIOS_BASICO] iniciando carreamento...")

dofile(path.."/tradutor.lua")
minetest.log('verbose',"[OFICIOS_BASICO] tradutor carregado...")

dofile(path.."/construtor.lua")
minetest.log('verbose',"[OFICIOS_BASICO] item de construtor carregado...")

dofile(path.."/cientista.lua")
minetest.log('verbose',"[OFICIOS_BASICO] item de cientista carregado...")

dofile(path.."/cozinheiro.lua")
minetest.log('verbose',"[OFICIOS_BASICO] item de cozinheiro carregado...")

dofile(path.."/ferreiro.lua")
minetest.log('verbose',"[OFICIOS_BASICO] item de ferreiro carregado...")

minetest.log('action',"[OFICIOS_BASICO] carregado.")
