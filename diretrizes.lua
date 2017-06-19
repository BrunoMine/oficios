--[[
	Mod Oficios para Minetest
	Copyright (C) 2017 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Diretrizes
  ]]

-- Uso de sistema de registro emergencial 
-- (para caso não esteja ativo desde o inicio do servidor)
SISTEMA_DE_REGISTRO_EMERGENCIAL = true

-- Escala de niveis (jamais alterar apos iniciar o uso no servidor)
OFICIOS_NIVEIS = {
	00000, -- 1
	00500, -- 2
	01500, -- 3
	02500, -- 4
	04000, -- 5
	06000, -- 6
	08500, -- 7
	11500, -- 8
	14500, -- 9
	20000  -- 10
}

-- Calculando limiteis de nível e experiência
local lim =table.maxn(OFICIOS_NIVEIS)
LIMITE_DE_XP = OFICIOS_NIVEIS[lim]
LIMITE_DE_NIVEL = lim
