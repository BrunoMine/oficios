--[[
	Mod Oficios_Basicos para Minetest
	Copyright (C) 2018 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Construtor
  ]]

local S = oficios_basicos.S

-- Mesa
minetest.register_node("oficios_basicos:mesa", {
	description = S("Mesa"),
	drawtype = "nodebox",
	paramtype = 'light',
	tiles = {
		"oficios_basicos_mesa_cima.png", -- Cima
		"oficios_basicos_mesa_cima.png", -- Baixo
		"oficios_basicos_mesa_lado.png", -- Lado direito
		"oficios_basicos_mesa_lado.png", -- Lado esquerda
		"oficios_basicos_mesa_lado.png", -- Fundo
		"oficios_basicos_mesa_lado.png" -- Frente
	},
	node_box = {
		type = "fixed",
		fixed = {
				{-0.5, 0.3125, -0.5, 0.5, 0.5, 0.5}, -- Tampa
				{0.1875, -0.5, -0.4375, 0.4375, 0.4375, -0.1875}, -- Perna_1
				{-0.4375, -0.5, -0.4375, -0.1875, 0.375, -0.1875}, -- Perna_2
				{-0.4375, -0.5, 0.1875, -0.1875, 0.375, 0.4375}, -- Perna_3
				{0.1875, -0.5, 0.1875, 0.4375, 0.375, 0.4375}, -- Perna_4
		}
	},
	groups = {choppy=3,oddly_breakable_by_hand=3},
	sounds = default.node_sound_wood_defaults(),
})

-- Registrando receita
local itens_requeridos = {
	{"default:tree", 3},
	{"default:steel_ingot", 2}
}
local desc = S("Uma mesa simples para decorar o ambiente.")
oficios.montar_receita(
	"construtor", -- Nome do oficio
	"oficios_basicos:mesa", -- Item a ser criado
	1, -- Nivel requerido
	desc, -- Descricao
	20, -- XP recebido
	itens_requeridos, -- Itens requeridos
	{00,00,20} -- Tempo
)
