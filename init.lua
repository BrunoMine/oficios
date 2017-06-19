--[[
	Mod Oficios para Minetest
	Copyright (C) 2017 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Inicialização de scripts
  ]]
  
  
local path = minetest.get_modpath("oficios")

oficios = {}
oficios.receitas = {}

minetest.log('verbose',"[OFICIOS] iniciando carreamento...")

dofile(path.."/diretrizes.lua")
minetest.log('verbose',"[OFICIOS] diretrizes carregadas...")

dofile(path.."/formularios.lua")
minetest.log('verbose',"[OFICIOS] formularios carregados...")

dofile(path.."/banco_de_dados.lua")
minetest.log('verbose',"[OFICIOS] Banco de Dados carregado...")

dofile(path.."/contador_tempo.lua")
minetest.log('verbose',"[OFICIOS] Contador de tempo carregado...")

dofile(path.."/funcoes.lua")
minetest.log('verbose',"[OFICIOS] funcoes carregadas...")

minetest.log('action',"[OFICIOS] carregado.")

