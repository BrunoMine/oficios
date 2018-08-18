--[[
	Mod Oficios_Basicos para Minetest
	Copyright (C) 2018 BrunoMine (https://github.com/BrunoMine)
	
	Recebeste uma cópia da GNU Lesser General
	Public License junto com esse software,
	se não, veja em <http://www.gnu.org/licenses/>. 
	
	Ferreiro
  ]]

local S = oficios_basicos.S

-- Removido receita de escudo de madeira melhorado (apenas a receita não deve existir)
minetest.clear_craft({output = 'shields:shield_enhanced_wood'})

-- Registrando receita de Escudo de Madeira Melhorado
local itens_requeridos = {
	{"shields:shield_wood", 1},
	{"default:steel_ingot", 2},
	{"default:stick", 1},
}
local desc = S("Esse escudo parece mais pesado e resistente do que um simples Escudo de Madeira comum.")
oficios.montar_receita(
	"ferreiro", -- Nome do oficio
	"shields:shield_enhanced_wood", -- Item a ser criado
	1, -- Nivel requerido
	desc, -- Descricao
	25, -- XP recebido
	itens_requeridos, -- Itens requeridos
	{00,00,15} -- Tempo
)

-- Definir numero de usos do isqueiro
local USOS = 10

-- Desgaste por uso
local DESGASTE_POR_USO = math.ceil(65535/USOS)

-- Isqueiro
minetest.register_tool("oficios_basicos:isqueiro", {
	description = S("Isqueiro"),
	inventory_image = "oficios_basicos_isqueiro.png",
	wield_image = "oficios_basicos_isqueiro_inv.png",
	on_place = function(itemstack, placer, pointed_thing)
		if pointed_thing then
			local pos = pointed_thing.above
			local lugar = minetest.get_node(pos)
			if lugar.name=="air" then
				if minetest.is_protected(pos, placer:get_player_name()) == false then
					lugar.name = "fire:basic_flame"
					minetest.set_node(pos, lugar)
					minetest.sound_play("oficios_basicos_isqueiro", {pos = placer:getpos(), max_hear_distance = 3, loop = false, gain = 1})
					itemstack:add_wear(DESGASTE_POR_USO)
					return itemstack
				end
			end
		end
	end,
})


-- Registrar receitas par ferreiro
-- Registrando receita de Escudo de Madeira Melhorado
local itens_requeridos = {
	{"default:steel_ingot", 1},
	{"default:stick", 1},
	{"default:flint", 1},
}
local desc = S("É realmente necessário falar sobre quão útil é um isqueiro?")
oficios.montar_receita(
	"ferreiro", -- Nome do oficio
	"oficios_basicos:isqueiro", -- Item a ser criado
	2, -- Nivel requerido
	desc, -- Descricao
	45, -- XP recebido
	itens_requeridos, -- Itens requeridos
	{00,00,15} -- Tempo
)
